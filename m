Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTHGW0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271045AbTHGW0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:26:55 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:62468 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271043AbTHGW0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:26:51 -0400
Message-ID: <3F32D1CD.CF8469A5@SteelEye.com>
Date: Thu, 07 Aug 2003 18:25:17 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21]: nbd ksymoops-report
References: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com> <3F328DB9.4EF38D9A@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------85098A6AF4092FBB5C2DEDD3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------85098A6AF4092FBB5C2DEDD3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Clements wrote:
> 
> Paul Clements wrote:
> >
> > On Thu, 7 Aug 2003, Bernd Schubert wrote:
> >
> > > every time when nbd-client disconnects a nbd-device the decoded oops
> > > from below will happen.
> > > This only happens after we upgraded from 2.4.20 to 2.4.21,
> > > so I guess the backported update from 2.5.50 causes this.

[snip]

> > Would you be willing to test a patch against 2.4.21?
> 
> If you're willing to test the attached patch, I'd be grateful. Otherwise
> I'll test it in the next few days and forward on to Marcelo...

OK, the previous patch didn't quite do it. The attached should work (I
got a chance to test it, finally). 

Thanks,
Paul
--------------85098A6AF4092FBB5C2DEDD3
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd_sock_null_race_fix_2_4_21-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd_sock_null_race_fix_2_4_21-2.diff"

diff -up linux-2.4.21-PRISTINE/drivers/block/nbd.c linux-2.4.21/drivers/block/nbd.c
--- linux-2.4.21-PRISTINE/drivers/block/nbd.c	2003-06-13 10:51:32.000000000 -0400
+++ linux-2.4.21/drivers/block/nbd.c	2003-08-07 18:05:39.000000000 -0400
@@ -428,23 +428,24 @@ static int nbd_ioctl(struct inode *inode
                 return 0 ;
  
 	case NBD_CLEAR_SOCK:
+		error = 0;
+		down(&lo->tx_lock);
+		lo->sock = NULL;
+		up(&lo->tx_lock);
+		spin_lock(&lo->queue_lock);
+		file = lo->file;
+		lo->file = NULL;
+		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
-			return -EBUSY;
+			printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
+			error = -EBUSY;
 		}
-		file = lo->file;
-		if (!file) {
-			spin_unlock(&lo->queue_lock);
-			return -EINVAL;
-		}
-		lo->file = NULL;
-		lo->sock = NULL;
 		spin_unlock(&lo->queue_lock);
-		fput(file);
-		return 0;
+		if (file)
+			fput(file);
+		return error;
 	case NBD_SET_SOCK:
 		if (lo->file)
 			return -EBUSY;
@@ -491,9 +492,12 @@ static int nbd_ioctl(struct inode *inode
 		 * there should be a more generic interface rather than
 		 * calling socket ops directly here */
 		down(&lo->tx_lock);
-		printk(KERN_WARNING "nbd: shutting down socket\n");
-		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
-		lo->sock = NULL;
+		if (lo->sock) {
+			printk(KERN_WARNING "nbd: shutting down socket\n");
+			lo->sock->ops->shutdown(lo->sock,
+				SEND_SHUTDOWN|RCV_SHUTDOWN);
+			lo->sock = NULL;
+		}
 		up(&lo->tx_lock);
 		spin_lock(&lo->queue_lock);
 		file = lo->file;
Common subdirectories: linux-2.4.21-PRISTINE/drivers/block/paride and linux-2.4.21/drivers/block/paride

--------------85098A6AF4092FBB5C2DEDD3--

