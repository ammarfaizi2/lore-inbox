Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUBSSaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSSaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:30:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:14464 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267470AbUBSS3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:29:54 -0500
Date: Thu, 19 Feb 2004 18:29:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219182948.GA3414@mail.shareable.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > > For example, the rule can be that _any_ regular dentry create will 
> > > invalidate all the "case-insensitive" dentries. Just to be simple about 
> > > it.
> > 
> > If that's the rule, then with exactly the same algorithmic efficiency,
> > readdir+dnotify can be used to maintain the cache in userspace
> > instead.  There is nothing gained by using the helper module in that case.
> 
> Wrong.
> Because the dnotify would trigger EVEN FOR SAMBA OPERATIONS.

Ah, I didn't know you meant "_any_ regular dentry create (except for
Samba operations)".

To apply that rule, you either need alternate versions of rename() and
other file syscalls, or something akin to a process-specific flag (set
by the helper module) saying that this is a Samba process and dentry
creation _by this process_ shouldn't invalidate case-insensitive
dentries.

And if you have either of those, the bit of code which says "don't
invalidate case-insenitive dentries because this is a Samba process"
can just as easily say "don't send dnotify events to the current
process".

And once you've done that, it's easier just to add a DN_IGNORE_SELF
flag to dnotify meaning to ignore events caused by the current
process, and forget about the helper module.  That'd be useful for
other programs, too.

-- Jamie
