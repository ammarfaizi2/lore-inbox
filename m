Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbULHC0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbULHC0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULHC0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:26:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:2436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262009AbULHC0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:26:12 -0500
Date: Tue, 7 Dec 2004 18:25:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041207182557.23eed970.akpm@osdl.org>
In-Reply-To: <20041208022020.GH16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041208003736.GD16322@dualathlon.random>
	<1102467253.8095.10.camel@npiggin-nld.site>
	<20041208013732.GF16322@dualathlon.random>
	<20041207180033.6699425b.akpm@osdl.org>
	<20041208022020.GH16322@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, Dec 07, 2004 at 06:00:33PM -0800, Andrew Morton wrote:
> > untuned SCSI benchmark results without realising that.  If a distro is
> > always selecting CFQ then they've probably gone and deoptimised all their
> > IDE users.  
> 
> The enterprise distro definitely shouldn't use "as" by default: database
> apps _must_ not use AS, they've to use either CFQ or deadline. CFQ is
> definitely the best for enterprise distros. This is a tangible result,
> SCSI/IDE doesn't matter at all (and keep in mind they use O_DIRECT a
> lot, so such 64kib Jens found would be a showstopper for a enterprise
> release, slelecting something different than "as" is a _must_ for
> enterprise distro).

That's a missing hint in the direct-io code.  This fixes it up:

--- 25/fs/direct-io.c~a	2004-12-07 18:12:25.491602512 -0800
+++ 25-akpm/fs/direct-io.c	2004-12-07 18:13:13.661279608 -0800
@@ -1161,6 +1161,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	struct dio *dio;
 	int reader_with_isem = (rw == READ && dio_lock_type == DIO_OWN_LOCKING);
 
+	current->flags |= PF_SYNCWRITE;
+
 	if (bdev)
 		bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
 
@@ -1244,6 +1246,7 @@ __blockdev_direct_IO(int rw, struct kioc
 out:
 	if (reader_with_isem)
 		up(&inode->i_sem);
+	current->flags &= ~PF_SYNCWRITE;
 	return retval;
 }
 EXPORT_SYMBOL(__blockdev_direct_IO);
_

> ...
> 
> If you believe AS is going to perform better than CFQ on the database
> enterprise usage, we just need to prove it in practice after the round
> of fixes, then changing the default back to "as" it'll be an additional
> one liner on top of the blocker direct-io bug.

I don't think AS will ever meet the performance of CFQ or deadline for the
seeky database loads, unfortunately.  We busted a gut over that and were
never able to get better than 90% or so.

