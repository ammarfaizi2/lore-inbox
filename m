Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUIGKLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUIGKLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUIGKLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:11:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47240 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267799AbUIGKK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:10:57 -0400
Date: Tue, 7 Sep 2004 12:09:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907100941.GN6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com> <20040907093437.GK6323@suse.de> <20040907025921.7f6a4139.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907025921.7f6a4139.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Tue, Sep 07 2004, Paul Mackerras wrote:
> > > Jens Axboe writes:
> > > 
> > > > __copy_to_user is the unchecking version of copy_to_user.
> > > 
> > > It doesn't range-check the address, but it does return non-zero
> > > (number of bytes not copied) if it encounters a fault writing to the
> > > user buffer.
> > 
> > but it doesn't matter, if it returns non-zero then something happened
> > between the access_ok() and the actual copy because the user app did
> > something silly. so I don't care much really, I think the major point is
> > the kernel will cope.
> > 
> > you could remove the access_ok() and change it to a copy_to_user()
> > instead, I don't care either way. it's the old and slow interface which
> > really never is used unless things have gone wrong anyways.
> > 
> 
> Sure, but at present if an application tries to read cdrom data to address
> 0x00000000 (say), the kernel will return "success".  It should return an
> error code.  (Actually, it should return a short read if any data was
> transferred, but whatever).

Because access_ok() isn't reliable? Otherwise I don't see how that will
happen. There is another bug in there though, ret is never returned if
cdrom_read_block() fails.

> Plus the patch will fix a __must_check warning.

Then lets do it right.

===== drivers/cdrom/cdrom.c 1.69 vs edited =====
--- 1.69/drivers/cdrom/cdrom.c	2004-08-23 10:15:20 +02:00
+++ edited/drivers/cdrom/cdrom.c	2004-09-07 12:08:13 +02:00
@@ -1946,11 +1946,6 @@
 	if (!nr)
 		return -ENOMEM;
 
-	if (!access_ok(VERIFY_WRITE, ubuf, nframes * CD_FRAMESIZE_RAW)) {
-		kfree(cgc.buffer);
-		return -EFAULT;
-	}
-
 	cgc.data_direction = CGC_DATA_READ;
 	while (nframes > 0) {
 		if (nr > nframes)
@@ -1959,13 +1954,16 @@
 		ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
 		if (ret)
 			break;
-		__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr);
+		ret = -EFAULT;
+		if (copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr))
+			break;
 		ubuf += CD_FRAMESIZE_RAW * nr;
 		nframes -= nr;
 		lba += nr;
+		ret = 0;
 	}
 	kfree(cgc.buffer);
-	return 0;
+	return ret;
 }
 
 static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,

-- 
Jens Axboe

