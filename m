Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUH3D5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUH3D5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 23:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUH3D5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 23:57:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:37045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266631AbUH3D5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 23:57:12 -0400
Date: Sun, 29 Aug 2004 20:55:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
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
In-Reply-To: <20040830030157.GE16297@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408292042380.2295@ppc970.osdl.org>
References: <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com>
 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org>
 <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org> <1093830135.8099.181.camel@lade.trondhjem.org>
 <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
 <20040830030157.GE16297@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > So I don't see any way to extend pathname semantics to distinguish between 
> > "directory contents" and "directory attribute stream". 
> 
> I do, actually.  There might be a way and it is kinda-sorta similar to
> your openat() variant, but lives in normal namespace.  No, I'm not too
> fond of that, but since we are discussing weird variants anyway...
> 
> 	a) associated directory tree of object is not automounted on top
> of it.  Instead of that, we always do detached vfsmount (and do it on demand -
> see below)
> 	b) we have a bunch of pseudo-symlinks in /proc/<pid>/fd/ - same
> kind as what we already have there, but instead of (file->f_vfsmount,
> file->f_dentry) they lead to associated vfsmount (allocated if needed).
> Once we get a reference to such guy, we can
> 	* do further lookups
> 	* chdir there and poke around
> 	* hell, we can even bind it someplace (that will require slight change
> in attach_mnt() logics, but it's not hard) and get it permanently mounted

Well, the above _is_ the same as "openat()", really. It's just using a
filesystem starting point to emulate a new system call. Same thing
conceptually. You could do pretty much any system call as a filesystem
action if you wanted to ;)

I don't disagree with doing so - as a way to expose the new system call to
scripts. But I don't think you're being entirely intellectually honest if
you think this suddendly makes it be "one namespace". It's still a
secondary namespace rooted in an entry in the normal ones - exactly like
"openat()". 

For a non-script, a native "openat()" interface would be more efficient
and less confusing, and conceptually no different from yours.  No reason
we couldn't have both, since they are 100% equivalent and would share the
same code anyway...

		Linus
