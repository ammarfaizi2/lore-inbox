Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWCKPLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWCKPLn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWCKPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:11:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15881 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751140AbWCKPLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:11:42 -0500
Date: Sat, 11 Mar 2006 16:11:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/bt8xx/dst_ca.c: fix 2 memory leaks
Message-ID: <20060311151142.GP21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted that thre was a memory leak if the second 
or third kmalloc() failed.

Besides this, I've also consolidated the three error handlings into one.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/bt8xx/dst_ca.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc5-mm3-full/drivers/media/dvb/bt8xx/dst_ca.c.old	2006-03-11 14:36:59.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/media/dvb/bt8xx/dst_ca.c	2006-03-11 15:28:26.000000000 +0100
@@ -473,18 +473,17 @@ static int dst_ca_ioctl(struct inode *in
 	void __user *arg = (void __user *)ioctl_arg;
 	int result = 0;
 
-	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
-		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
-		return -ENOMEM;
-	}
-	if ((p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL)) == NULL) {
-		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
-		return -ENOMEM;
-	}
-	if ((p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL)) == NULL) {
+	p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL);
+	p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL);
+	p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL);
+
+
+	if (!p_ca_message || !p_ca_slot_info || !p_ca_caps) {
 		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto free_mem_and_exit;
 	}
+
 	/*	We have now only the standard ioctl's, the driver is upposed to handle internals.	*/
 	switch (cmd) {
 	case CA_SEND_MSG:

