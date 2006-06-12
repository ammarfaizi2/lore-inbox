Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWFLGfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWFLGfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFLGfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:35:09 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:10714 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750830AbWFLGfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:35:06 -0400
Date: Mon, 12 Jun 2006 00:35:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060612063513.GI5964@schatzie.adilger.int>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Jeff Garzik <jeff@garzik.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <1150041738.3131.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150041738.3131.79.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2006  18:00 +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-09 at 21:44 +0100, Alan Cox wrote:
> > OTOH the number of complaints about this is minimal, people want to go
> > forwards in a controlled manner not backwards.
> 
> well... they want to be able to go "a little bit" backwards; say one
> version of an OS (6 months). Eg the scenario that ought to work is "go
> to newer version, hate it, go back". But yes that's a limited time to go
> back, not the "go back to 2.2" kind of "go back".

Interestingly, one of the reasons we want(ed) to get the extents code into
the ext3 mainline ASAP is that this would allow it to be available for the
"go back" phase when (in a couple of years) you NEED to have support for
gigantic block devices and have no choice but use this code to update.
For today it would only be used by people who really want to use it.

On Jun 11, 2006  18:02 +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-09 at 14:51 -0400, Jeff Garzik wrote:
> > PRECISELY.  So you should stop modifying a filesystem whose design is 
> > admittedly _not_ modern!
> > 
> > ext3 is already essentially xiafs-on-life-support, when you consider 
> > today's large storage systems and today's filesystem technology.  Just 
> > look at the ugly hacks needed to support expanding an ext3 filesystem 
> > online.
> 
> actually I think I disagree with you. One thing I've noticed over the
> years is that ext2 layout has one thing going for it: it is simple and
> robust. Maybe "ext2 layout" is the wrong word, "block bitmap and
> direct/indirect block based" may be better. It seems that once you go
> into tree space (and I would call htree a borderline thing there) you
> get both really complex code and fragile behavior all over (mostly in
> terms of "when something goes wrong")

You're correct in calling htree a borderline case, because the directory
metadata is still accessible in a "linear" manner if the tree is corrupted
for some reason.  I've recently been thinking of making the structure even
more robust by encoding a singly- or doubly-linked list into the directory
leaf blocks.

However, in the direct/indirect block tree is the most fragile part of
ext2/ext3.  It also has the bad effect that corruption in the file indirect
tree can easily amplify into widespread filesystem corruption because wrongly
freeing indirect block and reallocating it will potentially cause 1024 more
blocks to be freed when that indirect block is unlinked, etc.  This is also
the slowest part of e2fsck checking if it detects corruption (duplication)
in the block allocation.

When we had very small filesystems it was easy to tell if an
indirect block was corrupt, because the valid block numbers made up only
a small fraction of the 2^32 possible block numbers.  However, with large
filesystems valid block numbers make up a large fraction of the 2^32 block
number space.  As we get to 16TB filesystems it is impossible to tell when
an indirect block is filled with garbage and when it is valid.

One of the features of the extent format is that firstly it has a magic
number in each "indirect" block (called an extent index block).  Secondly,
there is enough redundancy that it allows internal validation of the extent
data (e.g. that extents are sequentially increasing logical offsets, that
the parent's logical offset is correctly "encompassing" all of the leaf's
logical offsets.

Finally, one of the features that has been designed into the extent format
(though not yet implemented) is that it is possible to add a checksum to
each extent index to verify the metadata more strongly.  There will also
be space to have a back-pointer to the parent inode for validation.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

