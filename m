Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUESXmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUESXmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUESXmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:42:40 -0400
Received: from mail-gw.ygnition.net ([66.135.144.21]:44043 "EHLO
	quirrell.iqcicom.com") by vger.kernel.org with ESMTP
	id S264675AbUESXmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:42:38 -0400
Date: Wed, 19 May 2004 16:36:07 -0700 (PDT)
From: Muthukumar Ratty <muthu@iqmail.net>
To: <linux-kernel@vger.kernel.org>
cc: <akpm@osdl.org>
Subject: [PATCH] 2.6.6-mm4 compile fix.
Message-ID: <Pine.LNX.4.33.0405191632190.14047-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,
Compilation fails for me at drivers/media/radio/radio-cadet.c. Its because
of the readq change introduced in -mm4. Patch attached.

thanks,
Muthu.



--- drivers/media/radio/radio-cadet.c	2004-05-19 16:30:25.672467232 -0700
+++ drivers/media/radio/radio-cadet.c.readq	2004-05-19 16:30:01.444150496 -0700
@@ -45,7 +45,7 @@ static int users=0;
 static int curtuner=0;
 static int tunestat=0;
 static int sigstrength=0;
-static wait_queue_head_t radio_readq;
+static wait_queue_head_t readq;
 struct timer_list tunertimer,rdstimer,readtimer;
 static __u8 rdsin=0,rdsout=0,rdsstat=0;
 static unsigned char rdsbuf[RDS_BUFFER];
@@ -309,7 +309,7 @@ void cadet_handler(unsigned long data)
 	 * Service pending read
 	 */
 	if( rdsin!=rdsout)
-	        wake_up_interruptible(&radio_readq);
+	        wake_up_interruptible(&readq);

 	/*
 	 * Clean up and exit
@@ -343,7 +343,7 @@ static ssize_t cadet_read(struct file *f
 	if(rdsin==rdsout) {
   	        if (file->f_flags & O_NONBLOCK)
 		        return -EWOULDBLOCK;
-	        interruptible_sleep_on(&radio_readq);
+	        interruptible_sleep_on(&readq);
 	}
 	while( i<count && rdsin!=rdsout)
 	        readbuf[i++]=rdsbuf[rdsout++];
@@ -473,7 +473,7 @@ static int cadet_open(struct inode *inod
 	if(users)
 		return -EBUSY;
 	users++;
-	init_waitqueue_head(&radio_readq);
+	init_waitqueue_head(&readq);
 	return 0;
 }



