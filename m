Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUH2X62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUH2X62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUH2X62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:58:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:35305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268404AbUH2X6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:58:22 -0400
Date: Sun, 29 Aug 2004 16:54:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
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
In-Reply-To: <1093821430.8099.49.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
  <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> 
 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> 
 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> 
 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> 
 <41323751.5000607@namesys.com>  <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
  <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
 <1093821430.8099.49.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Aug 2004, Trond Myklebust wrote:
> 
> So could you explain what is stopping us from reducing the whole problem
> to the bind mount problem? IOW have "a/" be a directory that acts as if
> it is dynamically bind mounted on top of the file "a".

Hey, I suggested people do exactly that. See the other thread between me
and Al Viro on exact implementation issues - even some code snippets ;)

The problem really ends up being directories with attributes (where we
can't just overmount the existing directory). That's where "openat()" 
helps us. 

(The other problem is the purely _practical_ problem of reiser4 going
behind the VFS layer, and thus _not_ getting the aliasing and locking
right, but that's an implementation issue in my book, and nothing really
fundamental).

> Is it just the fantasy of supporting hard-links across "stream
> boundaries" (as in "touch a b; ln b a/b; ln a b/a")? I'm pretty sure
> nobody wants to have to add cyclic graph detection to their filesystems
> anyway. 8-)

It's easy enough to do the graph detection at the VFS layer, exactly 
because of the density of the dentry graph. 

(Of course, nfs-exporting a filesystem breaks that density, thanks to the
"lookup by fh" stuff, so we might not allow it for an NFS client). 

I suspect most filesystems wouldn't allow hard-links across "stream 
boundaries" in the first place. I _suspect_ that most stream 
implementations would bind the attributes more tightly than that to the 
file that owns them. reiser4 migth be the only one that might ever support 
something like that.

> What other issues would need to be addressed?

 - Whether we want it in the first place
 - whether we need the "separate namespace" thing that O_XATTR and
   openat() brings us (they certainly solve the problem, but maybe it is
   solvable another way too)
 - how to actually test this out in practice (ie getting reiser4 to do the
   proper thing wrt the VFS layer, but preferably _also_ having another
   filesystem like NFSv4 or cifs that actually uses this and shows what
   the problems are).
 - whether it makes any sense at all unless we also make at least a few 
   other filesystems support it, so that people start using it as an 
   "expected feature" rather than a "works only on a couple of machines".

And probably others.

			Linus
