Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUH3DCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUH3DCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 23:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUH3DCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 23:02:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265823AbUH3DCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 23:02:03 -0400
Date: Mon, 30 Aug 2004 04:01:57 +0100
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
Message-ID: <20040830030157.GE16297@parcelfarce.linux.theplanet.co.uk>
References: <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org> <1093830135.8099.181.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 07:31:49PM -0700, Linus Torvalds wrote:
> And that's not just theory - it's quite common for programs to just 
> concatenate a directory name (which may or may not end with a slash) with 
> another path-name that starts with a slash. So you _will_ see existing 
> scripts and programs using things like "/usr/include//sys/type.h", and 
> they'd break if "//" would switch from "regular namespace" to "attribute 
> namespace".
> 
> So I don't see any way to extend pathname semantics to distinguish between 
> "directory contents" and "directory attribute stream". 

I do, actually.  There might be a way and it is kinda-sorta similar to
your openat() variant, but lives in normal namespace.  No, I'm not too
fond of that, but since we are discussing weird variants anyway...

	a) associated directory tree of object is not automounted on top
of it.  Instead of that, we always do detached vfsmount (and do it on demand -
see below)
	b) we have a bunch of pseudo-symlinks in /proc/<pid>/fd/ - same
kind as what we already have there, but instead of (file->f_vfsmount,
file->f_dentry) they lead to associated vfsmount (allocated if needed).
Once we get a reference to such guy, we can
	* do further lookups
	* chdir there and poke around
	* hell, we can even bind it someplace (that will require slight change
in attach_mnt() logics, but it's not hard) and get it permanently mounted

Since it's not attached anywhere, normal GC logics works just fine.  And
yes, they are usable from scripts, etc. -
	exec 42<foo/bar/baz
	cat /proc/self/fd/#42/whatever/crap/you/want
and enjoy.

> However, being prodded by Andries, I think I'm wrong _anyway_. Since the
> dcache is only "dense" down one path to the root, and doesn't contain all
> the alternate ways of getting to a particular directory, I came to the
> conclusion that the VFS layer can't actually do cyclic detection after
> all...

<blinks>
<rereads a bunch of earlier postings>

Oh, _that_'s what you meant...  No, we definitely have no chance in hell
to catch loops, dcache or not.  It costs too much - we need to examine
a *lot* of nodes to do that and all of them would have to be read at some
point.  We either need entire fs tree locked in core or we might have to
reread it on every rename().  The former will kill us on memory use, the
latter - on amount of IO.
