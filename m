Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVCHT3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVCHT3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCHTZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:25:27 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6313 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261424AbVCHTV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:21:59 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: Badari Pulavarty <pbadari@us.ibm.com>
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org>  <20050308090946.GA4100@in.ibm.com>
	 <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-5v3QEISAr9EgK1gFqDgJ"
Organization: 
Message-Id: <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Mar 2005 11:18:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5v3QEISAr9EgK1gFqDgJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Andrew, please don't apply the original patch. We shouldn't even attempt
> to submit IO beyond the filesize. We should truncate the IO request to
> filesize. I will send a patch today to fix this.
> 

Well, spoke too soon. This is an ugly corner case :( But I have
a ugly hack to fix it :)

Let me ask you a basic question: Do we support DIO reads on a file
which is not blocksize multiple in size ? (say 12K - 10 bytes) ?

What about the ones which are not 4K but 512 byte multiple ? (say 7K) ?

I need answer to those, to figure out how hard I should try to fix this.

Anyway, here is ugly version of the patch - which will limit the IO
size to filesize and uses lower blocksizes to read the file (since
the filesize is only 3K, it would go down to 512 byte blocksize).

Thanks,
Badari

--=-5v3QEISAr9EgK1gFqDgJ
Content-Disposition: attachment; filename=aio-dio-short-read.patch
Content-Type: text/plain; name=aio-dio-short-read.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- fs/direct-io.c.org	2005-03-08 09:53:31.823761712 -0800
+++ fs/direct-io.c	2005-03-08 12:09:33.280084600 -0800
@@ -1180,6 +1180,22 @@ __blockdev_direct_IO(int rw, struct kioc
 		addr = (unsigned long)iov[seg].iov_base;
 		size = iov[seg].iov_len;
 		end += size;
+
+		/*
+		 * If we are trying to read beyond end of the file
+		 * truncate the IO request to filesize.
+		 * This is ugly: we change iov_len and nr_segs,
+		 * but need to do this here since we may need to
+		 * bail out if the filesize is not blocksize multiple
+		 * and we may need to do fine-grain blocksizes.
+		 */	
+		if ((rw == READ) && (end > i_size_read(inode))) {
+			iov[seg].iov_len -= (end - i_size_read(inode));
+			size = iov[seg].iov_len;
+			end = i_size_read(inode);
+			nr_segs = seg + 1;	/* Ugly - to break the loop */
+		}
+
 		if ((addr & blocksize_mask) || (size & blocksize_mask))  {
 			if (bdev)
 				 blkbits = bdev_blkbits;

--=-5v3QEISAr9EgK1gFqDgJ--

