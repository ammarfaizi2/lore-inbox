Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293478AbSBYToA>; Mon, 25 Feb 2002 14:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293476AbSBYTn4>; Mon, 25 Feb 2002 14:43:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293474AbSBYTnl>;
	Mon, 25 Feb 2002 14:43:41 -0500
Message-ID: <3C7A939D.FCAE9096@zip.com.au>
Date: Mon, 25 Feb 2002 11:42:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au> <3C7A35FF.5040508@sgi.com> <20020225131218.GO11837@suse.de> <3C7A398A.1060300@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> Yep, bio just made it easier to get larger requests.
> 

Which promptly go kersplat when you feed them into
submit_bio():

     BUG_ON(bio_sectors(bio) > q->max_sectors);

Given that I'm hand-rolling a monster bio, I need to know
when to wrap it up and send it off, to avoid creating a bio
which is larger than the target device will accept.  I'm currently
using the below patch.   Am I right that this is missing API
functionality, or did I miss something?

Also, I could not find a way of querying the size of the vector
at *bi_io_vec.  This is also information which would be helpful
when building large scatter/gather lists.



--- 2.5.5/drivers/block/ll_rw_blk.c~mpio-10-biobits	Mon Feb 25 00:28:21 2002
+++ 2.5.5-akpm/drivers/block/ll_rw_blk.c	Mon Feb 25 00:28:21 2002
@@ -1350,6 +1350,28 @@ static void end_bio_bh_io_sync(struct bi
 }
 
 /**
+ * bio_max_bytes: return the maximum number of bytes which can be
+ * placed in a single bio for a particular device.
+ *
+ * @dev: the device's kdev_t
+ *
+ * Each device has a maximum permissible queue size, and bios may
+ * not cover more data than that.
+ *
+ * Returns -ve on error.
+ */
+int bio_max_bytes(kdev_t dev)
+{
+	request_queue_t *q;
+	int ret = -1;
+
+	q = blk_get_queue(dev);
+	if (q)
+		ret = (q->max_sectors << 9);
+	return ret;
+}
+
+/**
  * submit_bio: submit a bio to the block device layer for I/O
  * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
  * @bio: The &struct bio which describes the I/O
--- 2.5.5/include/linux/bio.h~mpio-10-biobits	Mon Feb 25 00:28:21 2002
+++ 2.5.5-akpm/include/linux/bio.h	Mon Feb 25 00:28:21 2002
@@ -204,5 +204,6 @@ extern struct bio *bio_copy(struct bio *
 extern inline void bio_init(struct bio *);
 
 extern int bio_ioctl(kdev_t, unsigned int, unsigned long);
+extern int bio_max_bytes(kdev_t dev);
 
 #endif /* __LINUX_BIO_H */


-
