Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUBRWEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUBRWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:04:35 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:40717 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268243AbUBRWE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:04:28 -0500
Message-ID: <4033E147.D30E8383@SteelEye.com>
Date: Wed, 18 Feb 2004 17:03:51 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
CC: Jens Axboe <axboe@suse.de>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nbd oops on unload. [PATCH x2]
References: <20040217224700.GE6242@redhat.com> <4032FF7D.55D9935B@SteelEye.com> <20040218071752.GB27190@suse.de> <4033A33F.FF279C05@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------703A63713E533A2C83BA8378"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------703A63713E533A2C83BA8378
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Clements wrote:

> Dave Jones wrote:
> > modprobe nbd ; rmmod nbd  was enough to reproduce this one..
> > (2.6.3rc4)

> Ahh, cleanup was being done in the wrong order.
> 
> Patch coming shortly...

Here it is, as well as another to fix some return codes (so nbd-client
can exit with the proper error code, rather than 0, when an error
occurs).

Tested against 2.6.3-rc2. Please apply.

Thanks,
Paul
--------------703A63713E533A2C83BA8378
Content-Type: text/x-patch; charset=us-ascii;
 name="nbd_cleanup_fix_2_6_3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_cleanup_fix_2_6_3.diff"

--- 2_6_3_rc2/drivers/block/nbd.c.ERROR_RETURN_FIXES	Wed Feb 18 12:32:42 2004
+++ 2_6_3_rc2/drivers/block/nbd.c	Wed Feb 18 12:44:50 2004
@@ -751,8 +751,7 @@ static int __init nbd_init(void)
 	return 0;
 out:
 	while (i--) {
-		if (nbd_dev[i].disk->queue)
-			blk_cleanup_queue(nbd_dev[i].disk->queue);
+		blk_cleanup_queue(nbd_dev[i].disk->queue);
 		put_disk(nbd_dev[i].disk);
 	}
 	return err;
@@ -764,9 +763,8 @@ static void __exit nbd_cleanup(void)
 	for (i = 0; i < MAX_NBD; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		if (disk) {
-			if (disk->queue)
-				blk_cleanup_queue(disk->queue);
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
 			put_disk(disk);
 		}
 	}

--------------703A63713E533A2C83BA8378
Content-Type: text/x-patch; charset=us-ascii;
 name="nbd_error_return_fixes_2_6_3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_error_return_fixes_2_6_3.diff"

--- 2_6_3_rc2/drivers/block/nbd.c.PRISTINE	Tue Feb 17 13:46:40 2004
+++ 2_6_3_rc2/drivers/block/nbd.c	Wed Feb 18 12:29:15 2004
@@ -221,6 +221,8 @@ static int sock_xmit(struct socket *sock
 			printk(KERN_ERR "nbd: %s - sock=%p at buf=%p, size=%d returned %d.\n",
 			       send? "send": "receive", sock, buf, size, result);
 #endif
+			if (result == 0)
+				result = -EPIPE; /* short read */
 			break;
 		}
 		size -= result;
@@ -309,7 +311,7 @@ void nbd_send_req(struct nbd_device *lo,
 	up(&lo->tx_lock);
 	return;
 
-      error_out:
+error_out:
 	up(&lo->tx_lock);
 	req->errors++;
 }
@@ -358,23 +360,22 @@ struct request *nbd_read_stat(struct nbd
 	if (result <= 0) {
 		printk(KERN_ERR "%s: Receive control failed (result %d)\n",
 				lo->disk->disk_name, result);
-		lo->harderror = result;
-		return NULL;
+		goto harderror;
 	}
 	req = nbd_find_request(lo, reply.handle);
 	if (req == NULL) {
 		printk(KERN_ERR "%s: Unexpected reply (%p)\n",
 				lo->disk->disk_name, reply.handle);
-		lo->harderror = result;
-		return NULL;
+		result = -EBADR;
+		goto harderror;
 	}
 
 	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
 		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
 				lo->disk->disk_name,
 				(unsigned long)ntohl(reply.magic));
-		lo->harderror = result;
-		return NULL;
+		result = -EPROTO;
+		goto harderror;
 	}
 	if (ntohl(reply.error)) {
 		printk(KERN_ERR "%s: Other side returned error (%d)\n",
@@ -396,8 +397,7 @@ struct request *nbd_read_stat(struct nbd
 					printk(KERN_ERR "%s: Receive data failed (result %d)\n",
 							lo->disk->disk_name,
 							result);
-					lo->harderror = result;
-					return NULL;
+					goto harderror;
 				}
 				dprintk(DBG_RX, "%s: request %p: got %d bytes data\n",
 					lo->disk->disk_name, req, bvec->bv_len);
@@ -405,6 +405,9 @@ struct request *nbd_read_stat(struct nbd
 		}
 	}
 	return req;
+harderror:
+	lo->harderror = result;
+	return NULL;
 }
 
 void nbd_do_it(struct nbd_device *lo)
@@ -416,8 +419,6 @@ void nbd_do_it(struct nbd_device *lo)
 #endif
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
-	printk(KERN_NOTICE "%s: req should never be null\n",
-			lo->disk->disk_name);
 	return;
 }
 

--------------703A63713E533A2C83BA8378--

