Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVESXjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVESXjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVESXez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:34:55 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:20369 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261327AbVESXeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:34:13 -0400
Message-ID: <428D2270.40509@acm.org>
Date: Thu, 19 May 2005 18:34:08 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use completions, not semaphores, in the IPMI powerdown code
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060900000501060802020709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900000501060802020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060900000501060802020709
Content-Type: text/x-patch;
 name="ipmi-poweroff-use-completion-no-sem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-poweroff-use-completion-no-sem.patch"

Don't use semaphores for IPC in the poweroff code, use completions
instead.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_poweroff.c
@@ -31,12 +31,13 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <asm/semaphore.h>
-#include <linux/kdev_t.h>
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/proc_fs.h>
 #include <linux/string.h>
+#include <linux/completion.h>
+#include <linux/kdev_t.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
 
@@ -89,10 +90,10 @@
 
 static void receive_handler(struct ipmi_recv_msg *recv_msg, void *handler_data)
 {
-	struct semaphore *sem = recv_msg->user_msg_data;
+	struct completion *comp = recv_msg->user_msg_data;
 
-	if (sem)
-		up(sem);
+	if (comp)
+		complete(comp);
 }
 
 static struct ipmi_user_hndl ipmi_poweroff_handler =
@@ -105,27 +106,27 @@
 					  struct ipmi_addr       *addr,
 					  struct kernel_ipmi_msg *send_msg)
 {
-	int              rv;
-	struct semaphore sem;
+	int               rv;
+	struct completion comp;
 
-	sema_init (&sem, 0);
+	init_completion(&comp);
 
-	rv = ipmi_request_supply_msgs(user, addr, 0, send_msg, &sem,
+	rv = ipmi_request_supply_msgs(user, addr, 0, send_msg, &comp,
 				      &halt_smi_msg, &halt_recv_msg, 0);
 	if (rv)
 		return rv;
 
-	down (&sem);
+	wait_for_completion(&comp);
 
 	return halt_recv_msg.msg.data[0];
 }
 
-/* We are in run-to-completion mode, no semaphore is desired. */
+/* We are in run-to-completion mode, no completion is desired. */
 static int ipmi_request_in_rc_mode(ipmi_user_t            user,
 				   struct ipmi_addr       *addr,
 				   struct kernel_ipmi_msg *send_msg)
 {
-	int              rv;
+	int rv;
 
 	rv = ipmi_request_supply_msgs(user, addr, 0, send_msg, NULL,
 				      &halt_smi_msg, &halt_recv_msg, 0);

--------------060900000501060802020709--
