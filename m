Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUIZAKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUIZAKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUIZAKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:10:52 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:26296 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269129AbUIZAKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:10:48 -0400
Date: Sun, 26 Sep 2004 01:10:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 6/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409252350210.21041@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409260109450.24909@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <20040925063519.GQ23987@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.60.0409252350210.21041@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Anton Altaparmakov wrote:

> On Sat, 25 Sep 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Fri, Sep 24, 2004 at 05:13:53PM +0100, Anton Altaparmakov wrote:
> > >  	/* Get the starting vcn of the index_block holding the child node. */
> > > -	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
> > > +	vcn = sle64_to_cpup((sle64*)((u8*)ie + le16_to_cpu(ie->length) - 8));
> > 
> > I don't like the look of that.  Are there any alignment warranties for that
> > pointer?  The same goes for other users of that function...
> 
> The above pointer is always aligned to 8-byte boundary as goes for all 
> users of sle64_to_cpup().
> 
> If that matters, everything using _to_cpup() in ntfs is aligned 
> sufficiently expect for perhaps the two uses of le32_to_cpu() in 

s/expect/except/
s/le32_to_cpu/le32_to_cpup/

> fs/ntfs/collate.c and the four uses of le16_to_cpu() in 

s/le16_to_cpu/le16_to_cpup/

> fs/ntfs/compress.c where I would not be so sure and in fact the compress.c 
> ones I am pretty sure that there is no alignement guarantee for anything 
> at all.
> 
> Simillar, some of the othe *le*_to_cpu() conversion in NTFS are not 
> aligned (especially most of the boot sector ones).
> 
> I decided to not use the get_unaligned macros despite of this after a 
> discussion on LKML (perhaps fs-devel or perhaps only #kernel several years 
> ago, can't remember) where it was discussed that all architectures can do 
> the appropriate fixups on unaligned accesses if they need them and that 
> get_unaligned makes code very slow so it is better to just do the accesses 
> and have high speed on architectures which don't care and to have fixups 
> on other architectures than it is to use get_unaligned everywhere.
> 
> Is there anything wrong with that?  Remember that NTFS in real life is 
> almost entirely restricted to x86 which AFAIK doesn't care about 
> alignement.  I guess Windows now also exists (as beta) for ia64 and x86_64 
> but I don't know if these architectures require alignment or not...
> 
> Best regards,
> 
> 	Anton
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
