Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVAMOrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVAMOrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVAMOrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:47:25 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:34739 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261635AbVAMOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:47:19 -0500
Subject: write barriers - Was: Re: [RFC][PATCH] problem of
	cont_prepare_write()
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: hirofumi@mail.parknet.co.jp, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122154325.4d8e53ef.akpm@osdl.org>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	 <20041122024654.37eb5f3d.akpm@osdl.org>
	 <1101121403.18623.10.camel@imp.csi.cam.ac.uk>
	 <20041122135354.38feab51.akpm@osdl.org>
	 <Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>
	 <20041122154325.4d8e53ef.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 13 Jan 2005 14:47:07 +0000
Message-Id: <1105627627.22536.30.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to pickup such a long thread but here goes anyway...

On Mon, 2004-11-22 at 15:43 -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > I always have a flush_dcache_page(page) between the memset() and 
> > the SetPageUptodate() so I don't need the barrier, right?  Or does the 
> > flush_dcache_page() not imply ordering?
> 
> err, flush_dcache_page() might indeed provide a write barrier on all
> architectures which need write barriers.  Then again it might not ;) It's
> not intended that this be the case.

What about if the page is unmapped between the memset() and the
SetPageUptodate()?  Does that imply ordering?  I.e. do I need a write
barrier in code like this:

memset(page_address(page), 0, blah);
flush_dcache_page(page);
kunmap(page);
SetPageUptodate(page);

And a more general question:

If I am setting two variables in sequence and it is essential that if a
different cpu reads those variables it seems them updated in the same
order as they were written in the C code do I need a write barrier in
between the two?  For example:

ntfs_inode->allocated_size = 10;
ntfs_inode->initilized_size = 10;

Should another CPU see initialized_size = 10 but allocated_size < 10 the
ntfs driver will blow up in some places.  So does that mean I need a
write barrier, between the two?

If yes, do I still need it if I wrap the two settings (and all accesses)
with a spin lock?  And in particular with a rw-spinlock?  For example:

write_lock_irqsave(&ntfs_inode->size_lock, flags);
ntfs_inode->allocated_size = 10;
ntfs_inode->initilized_size = 10;
write_unlock_irqrestore(&ntfs_inode->size_lock, flags);

Do I still need a write barrier or does the spinlock imply it already?

Thanks a lot in advance and apologies for the stupid(?) questions...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

