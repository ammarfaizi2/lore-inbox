Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVA0Kz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVA0Kz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVA0Kwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:52:46 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:45283 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262590AbVA0KtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:49:00 -0500
Subject: Advice sought on how to lock multiple pages in ->prepare_write and
	->writepage
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 27 Jan 2005 10:48:44 +0000
Message-Id: <1106822924.30098.27.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for advice on how to lock multiple pages in ->prepare_write
and ->writepage.  Here is an example scenario where I need to do this:

We have a mounted NTFS volume with a cluster, i.e. logical block, size
of 64kiB on a system with a PAGE_CACHE_SIZE of 4kiB.  This means we can
allocate space in a file in multiples of 64kiB (aligned to 64kiB
boundaries).  Now take a sparse file and the user is attempting to do a
write into a hole in this file and lets say the write is in the middle
of a sparse cluster (logical block).

This means that the NTFS driver will receive a write request either via
->prepare_write or ->writepage for a page which lies in the middle of
the cluster (logical block).

NTFS driver now allocates a cluster on disk to fill the hole.

Now the driver needs to write zeroes between the start of the newly
allocated cluster and the beginning of the write request as well as
between the end of the write request and the end of the cluster.

In ->prepare_write we are holding i_sem on the file's inode as well as
the page lock on the page containing the write request.

In ->writepage we are only holding the page lock on the page containing
the write request.

We also need to keep in mind that there may be other already dirty pages
n the affected region that have not hit ->writepage yet or in the most
complicated case that are hitting ->writepage simultaneously on a
different cpu or due to preempt.  Such pages that are already uptodate
would need to not be zeroed.

A further complication is that any of those pages might be currently
under a ->readpage() and hence locked but they would never be marked
dirty for writeback unless we do it now.

I also need to ensure that any pages I zero also make it to disk
(presumably simply marking these pages dirty would be the Right Way(TM)
to do this).

What would you propose can I do to perform the required zeroing in a
deadlock safe manner whilst also ensuring that it cannot happen that a
concurrent ->readpage() will cause me to miss a page and thus end up
with non-initialized/random data on disk for that page?

Thanks a lot in advance for any advice/suggestions you can give me...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

