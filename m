Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSJONeL>; Tue, 15 Oct 2002 09:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJONeL>; Tue, 15 Oct 2002 09:34:11 -0400
Received: from poup.poupinou.org ([195.101.94.96]:302 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S262784AbSJONeK>;
	Tue, 15 Oct 2002 09:34:10 -0400
Date: Tue, 15 Oct 2002 15:40:01 +0200
To: deanna_bonds@adaptec.com
Cc: linux-kernel@vger.kernel.org, ducrot@poupinou.org
Subject: [PATCH] [2.4.20-pre10]  dpt_i2o fix
Message-ID: <20021015134001.GA3842@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first chunk of attached patch alloc wait_data with
kmalloc(..., GFP_ATOMIC) instead of GPF_KERNEL
in the function adpt_i2o_post_wait() because this function
is called in the function adpt_i2o_passthru() (line 1717 or
so) but with a spin_lock held.

The second chunk correct the expected behaviour in teh
function adpt_i2o_parse_lct().

The test 'if(pDev == NULL)' is always true, and the kmalloc
is done for pDev->next_lun.


--- linux-2.4.20-pre10/drivers/scsi/dpt_i2o.c	2002/10/15 12:07:13	1.1
+++ linux-2.4.20-pre10/drivers/scsi/dpt_i2o.c	2002/10/15 13:05:26
@@ -1122,7 +1122,7 @@
 	ulong flags = 0;
 	struct adpt_i2o_post_wait_data *p1, *p2;
 	struct adpt_i2o_post_wait_data *wait_data =
-		kmalloc(sizeof(struct adpt_i2o_post_wait_data),GFP_KERNEL);
+		kmalloc(sizeof(struct adpt_i2o_post_wait_data),GFP_ATOMIC);
 	adpt_wait_queue_t wait;
 
 	if(!wait_data){
@@ -1498,7 +1498,7 @@
 							pDev->next_lun; pDev = pDev->next_lun){
 					}
 					pDev->next_lun = kmalloc(sizeof(struct adpt_device),GFP_KERNEL);
-					if(pDev == NULL) {
+					if(pDev->next_lun == NULL) {
 						return -ENOMEM;
 					}
 					memset(pDev->next_lun,0,sizeof(struct adpt_device));


Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
