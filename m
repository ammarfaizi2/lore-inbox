Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUH3ErN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUH3ErN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUH3ErM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:47:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266281AbUH3Eqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:46:45 -0400
Date: Mon, 30 Aug 2004 05:46:37 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040830044637.GF16297@parcelfarce.linux.theplanet.co.uk>
References: <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org> <1093830135.8099.181.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org> <20040830030157.GE16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408292042380.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408292042380.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 08:55:02PM -0700, Linus Torvalds wrote:
> Well, the above _is_ the same as "openat()", really. It's just using a
> filesystem starting point to emulate a new system call. Same thing
> conceptually. You could do pretty much any system call as a filesystem
> action if you wanted to ;)

Umm...  Yes and no - open() is not the only thing you can do there.  You
can emulate some of the other stuff with open() + fchdir() + syscall, but...
Note that it also gives you access to other tasks' files (provided that
tasks are yours, so you can get to their /proc/.../fd).

> I don't disagree with doing so - as a way to expose the new system call to
> scripts. But I don't think you're being entirely intellectually honest if
> you think this suddendly makes it be "one namespace". It's still a
> secondary namespace rooted in an entry in the normal ones - exactly like
> "openat()". 

Well - it *does* expose these objects to all normal syscalls.  E.g. you
can unlink() a component in there without
	fd2 = open(".", ...);
	fd3 = openat(fd, ".", ....)
	fchdir(fd3);
	unlink("blah");
	fchdir(fd2);
and similar horrors (now have fun adding locking for multithreaded process,
etc.).

In that sense it is, indeed, the same namespace.

> For a non-script, a native "openat()" interface would be more efficient
> and less confusing, and conceptually no different from yours.  No reason
> we couldn't have both, since they are 100% equivalent and would share the
> same code anyway...

I'm not sure that openat() is the right interface for e.g. fileservers.
And no, I'm not saying that above is suitable for them - IMO neither variant
is what they need.  The thing is, fileserver almost certainly wants to
create and remove objects.  And you either end up with new syscalls for
doing *that* relative to opened fd or you do tons of fchdir(), which
makes benefits of openat() dubious in the best case.

Arguments about O_NOFOLLOW on the intermediate stages are bullshit, IMNSHO -
if they want to make some parts of tree inaccessible, they should simply
mkdir /tmp/FOAD; chmod 0 /tmp/FOAD; mount --bind /tmp/FOAD <blocked path>
in the namespace their daemon is running in.  And forget all that crap
about filtering pathnames and blocking symlinks on intermediate stages
(the latter is obviously worthless without the former since one can simply
substitute the symlink body in the pathname).
