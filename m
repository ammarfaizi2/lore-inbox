Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUH1TSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUH1TSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUH1TSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:18:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:41433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267619AbUH1TSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:18:17 -0400
Date: Sat, 28 Aug 2004 12:16:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no>
 <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
 <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org>
 <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sat, Aug 28, 2004 at 11:44:52AM -0700, Linus Torvalds wrote:
> > Going back to O_XATTR: that would end up doing the "special vfsmount"  
> > magic at the beginning of the lookup. If the dentry you started with
> > wasn't marked D_HYBRID, it would just return -ENOTDIR.
> 
> OK, let me restate the question - what do we get from pwd if we do
> fchdir() to such beast?

We'll see the "attribute path". We could (if we want to) mark the point 
where we walked into attribute space somehow (since we can see it by just 
looking at the vfsmount: d_root/d_mountpoint being the same), but even if 
we don't, we'll get a sane-looking path.

(It's not just "getcwd()", it's /proc interfaces too, for opening files,
and we already have the notion of magic markers like "(deleted)" to show
human-readable information).

The question about what to do at the "attribute point" (and there may
actually be several, if the filesystem supports attributes on attribute
files) likely depends on whether we support the previously discussed
"lookup()" magic for attributes.

So if we do support it, I think we should just make the attribute point
look exactly like a normal directory, since that path would work as-is. If
we don't support it (and at directory points), we might want to just
consider it a special root.

NOTE! Anybody who tries to use the "getcwd()" string as a real path is 
already broken - you have pathname permissions that may not make it 
possible to look up the path you see.

So we have multiple options:

 - support "file/attribute" lookup: show the path as-is, so you'd show it 
   as
	"/path/to/file/attribute"

 - alternatively, even if you _do_ support the normal lookup, show it with 
   a double slash (which will still be a valid path), just as a visual 
   clue:
	"/path/to/file//attribute"

 - for directories, or if we do _not_ support the extended lookup format,
   we could show it the same way we show deleted files, something like 
   this:
	"/path/to/file/attribute (attr)"

 - using "http notation" for non-standard-namespaces (we already do this
   for sockets and pipes, for example)

	"attr:attribute@/path/to/file"

pick your poison.

		Linus
