Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUBTRdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUBTRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:33:21 -0500
Received: from mail.shareable.org ([81.29.64.88]:60288 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261352AbUBTRdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:33:13 -0500
Date: Fri, 20 Feb 2004 17:33:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220173307.GF8994@mail.shareable.org>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > One 'user-space cache is valid/clean' bit should be enough - where all
> > non-Samba accesses clear the 'valid bit', and Samba sets the bit
> > manually.
> 
> Yes, that, together with O_CLEAN would work.
> 
> The problem is that you'd still need other system calls: it's not like 
> open(O_CREAT) is the only way to create a file. So you'd have to add 
> versions of "link()" etc, which means that O_CLEAN is really pretty 
> pointless, and you might as well just do it in a new system call.
> 
> Your version is also not multi-threaded: you can never allow more than one 
> thread doing the "sys_mark_dir_clean()". That was the reason for having 
> two bits: so that anybody can do a lookup in parallell, and only the 
> "filldir" part needs to be serialized.

How about this: we clean up dnotify, so it can be used for
user<->kernel dcache coherency, efficiently, and implement O_CLEAN in
a different way, which works with multiple threads, without extra
system calls for rename/link etc. and where the scope of "this
process/thread/whatever doesn't make a directory unclean" is flexible
enough for Samba, multi-threaded file viewers, maildir mail trackers
and so on.

Ok, marketing aside:

    1. open() a directory
    2. fcntl() for dnotify on the directory, as with the current interface,
       but adding a flag call DN_POLL.

Normally dnotify sends a queued signal with each event.  It can listen
in one-short or multiple event modes.  I'm surprised a signal was ever
used, because we have a perfectly good file descriptor to read from.

So DN_POLL means "register this dnotify but don't send a signal".
Instead, you'll call fcntl() again to read the dnotify status bits.

For Samba, the dnotify is equivalent to sys_mark_dir_clean().
Samba's dcache works like this, following Ingo's logic:

repeat:
	if (fcntl(dirfd, F_NOTIFY, DN_CREATE | DN_RENAME | DN_POLL) == 0) {
		... pure user-space fast path, use Samba dcache ...
		return;
	}
	... fill Samba dcache ...
	readdir() loop
	goto repeat;

(Note that DN_DELETE isn't needed: the negative userspace dcache
doesn't care about deletions).

See, that is obviously equivalent and uses an obvious (and tiny)
improvement to the existing dnotify feature.

The argument that O_CLEAN _requires_ sys_mark_dir_clean() is obviously
bogus: if O_CLEAN will abort when _this_ process/thread/whatever has
the directory marked clean, than it can just as easily abort when
this process/thread/whatever has a dnotify listening.

We might, however, like to add a flag DN_CLEAN so that O_CLEAN only
aborts for dnotifies with that flag set.  Just to stay friendly with
libraries.

-- Jamie
