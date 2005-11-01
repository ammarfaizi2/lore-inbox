Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVKAIWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVKAIWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVKAIOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:39 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:32706 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964980AbVKAIOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:24 -0500
Message-ID: <436723B1.2070702@m1k.net>
Date: Tue, 01 Nov 2005 03:13:37 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 12/37] dvb: dst: fix memory leaks
Content-Type: multipart/mixed;
 boundary="------------050400050801020507050909"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400050801020507050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------050400050801020507050909
Content-Type: text/x-patch;
 name="2375.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2375.patch"

From: Perceval Anichini <perceval.anichini@streamvision.fr>

fix memory leaks

Signed-off-by: Perceval Anichini <perceval.anichini@streamvision.fr>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |   52 +++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 15 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -407,6 +407,7 @@
 
 	u32 command = 0;
 	struct ca_msg *hw_buffer;
+	int result = 0;
 
 	if ((hw_buffer = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
 		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
@@ -414,8 +415,11 @@
 	}
 	dprintk(verbose, DST_CA_DEBUG, 1, " ");
 
-	if (copy_from_user(p_ca_message, arg, sizeof (struct ca_msg)))
-		return -EFAULT;
+	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg))) {
+		result = -EFAULT;
+		goto free_mem_and_exit;
+	}
+
 
 	if (p_ca_message->msg) {
 		ca_message_header_len = p_ca_message->length;	/*	Restore it back when you are done	*/
@@ -434,7 +438,8 @@
 			dprintk(verbose, DST_CA_DEBUG, 1, "Command = SEND_CA_PMT");
 			if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {	// code simplification started
 				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_PMT Failed !");
-				return -1;
+				result = -1;
+				goto free_mem_and_exit;
 			}
 			dprintk(verbose, DST_CA_INFO, 1, " -->CA_PMT Success !");
 			break;
@@ -443,7 +448,8 @@
 			/*      Have to handle the 2 basic types of cards here  */
 			if ((dst_check_ca_pmt(state, p_ca_message, hw_buffer)) < 0) {
 				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_PMT_REPLY Failed !");
-				return -1;
+				result = -1;
+				goto free_mem_and_exit;
 			}
 			dprintk(verbose, DST_CA_INFO, 1, " -->CA_PMT_REPLY Success !");
 			break;
@@ -452,13 +458,17 @@
 
 			if ((ca_get_app_info(state)) < 0) {
 				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_APP_INFO_ENQUIRY Failed !");
-				return -1;
+				result = -1;
+				goto free_mem_and_exit;
 			}
 			dprintk(verbose, DST_CA_INFO, 1, " -->CA_APP_INFO_ENQUIRY Success !");
 			break;
 		}
 	}
-	return 0;
+free_mem_and_exit:
+	kfree (hw_buffer);
+
+	return result;
 }
 
 static int dst_ca_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long ioctl_arg)
@@ -469,6 +479,7 @@
 	struct ca_caps *p_ca_caps;
 	struct ca_msg *p_ca_message;
 	void __user *arg = (void __user *)ioctl_arg;
+	int result = 0;
 
 	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
 		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
@@ -488,14 +499,16 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Sending message");
 		if ((ca_send_message(state, p_ca_message, arg)) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SEND_MSG Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		break;
 	case CA_GET_MSG:
 		dprintk(verbose, DST_CA_INFO, 1, " Getting message");
 		if ((ca_get_message(state, p_ca_message, arg)) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_MSG Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_MSG Success !");
 		break;
@@ -508,7 +521,8 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Getting Slot info");
 		if ((ca_get_slot_info(state, p_ca_slot_info, arg)) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_SLOT_INFO Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_SLOT_INFO Success !");
 		break;
@@ -516,7 +530,8 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Getting Slot capabilities");
 		if ((ca_get_slot_caps(state, p_ca_caps, arg)) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_CAP Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_CAP Success !");
 		break;
@@ -524,7 +539,8 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Getting descrambler description");
 		if ((ca_get_slot_descr(state, p_ca_message, arg)) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_DESCR_INFO Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_DESCR_INFO Success !");
 		break;
@@ -532,7 +548,8 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Setting descrambler");
 		if ((ca_set_slot_descr()) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SET_DESCR Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_SET_DESCR Success !");
 		break;
@@ -540,14 +557,19 @@
 		dprintk(verbose, DST_CA_INFO, 1, " Setting PID");
 		if ((ca_set_pid()) < 0) {
 			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SET_PID Failed !");
-			return -1;
+			result = -1;
+			goto free_mem_and_exit;
 		}
 		dprintk(verbose, DST_CA_INFO, 1, " -->CA_SET_PID Success !");
 	default:
-		return -EOPNOTSUPP;
+		result = -EOPNOTSUPP;
 	};
+ free_mem_and_exit:
+	kfree (p_ca_message);
+	kfree (p_ca_slot_info);
+	kfree (p_ca_caps);
 
-	return 0;
+	return result;
 }
 
 static int dst_ca_open(struct inode *inode, struct file *file)


--------------050400050801020507050909--
