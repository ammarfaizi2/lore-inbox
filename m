Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVASTgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVASTgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVASTgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:36:22 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:6112 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261432AbVASTgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:36:08 -0500
Message-ID: <41EEB6A7.9010809@acm.org>
Date: Wed, 19 Jan 2005 13:36:07 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Minor IPMI driver updates
Content-Type: multipart/mixed;
 boundary="------------020808040506070200070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020808040506070200070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following patch fixes some minor problems with the IPMI driver.  
Relative to 2.6.11-rc1

Thanks,

-Corey

--------------020808040506070200070104
Content-Type: text/plain;
 name="ipmi_fixes_2.6.11-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_fixes_2.6.11-rc3.diff"


This patch fixes counting of unhandled messages.  Messages that were
handled internally by the driver (to the NULL user) were miscounted
as unhanlded responses.  This counts them properly.

This patch also fixes the DMI 16-byte setting, which was set as a
16-bit setting.

It also uses the right value to initilize the address memory when
using a memory-based interface.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc1/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.11-rc1.orig/drivers/char/ipmi/ipmi_msghandler.c	2005-01-19 09:54:15.000000000 -0600
+++ linux-2.6.11-rc1/drivers/char/ipmi/ipmi_msghandler.c	2005-01-19 09:58:35.000000000 -0600
@@ -2301,12 +2301,17 @@
 
 	if (!found) {
 		/* Special handling for NULL users. */
-		if (!recv_msg->user && intf->null_user_handler)
+		if (!recv_msg->user && intf->null_user_handler){
 			intf->null_user_handler(intf, msg);
-		/* The user for the message went away, so give up. */
-		spin_lock_irqsave(&intf->counter_lock, flags);
-		intf->unhandled_local_responses++;
-		spin_unlock_irqrestore(&intf->counter_lock, flags);
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->handled_local_responses++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+		}else{
+			/* The user for the message went away, so give up. */
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->unhandled_local_responses++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+		}
 		ipmi_free_recv_msg(recv_msg);
 	} else {
 		struct ipmi_system_interface_addr *smi_addr;
Index: linux-2.6.11-rc1/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.11-rc1.orig/drivers/char/ipmi/ipmi_si_intf.c	2005-01-19 09:54:15.000000000 -0600
+++ linux-2.6.11-rc1/drivers/char/ipmi/ipmi_si_intf.c	2005-01-19 09:58:46.000000000 -0600
@@ -1299,7 +1299,7 @@
 	memset(info, 0, sizeof(*info));
 
 	info->io_setup = mem_setup;
-	info->io.info = (void *) addrs[intf_num];
+	info->io.info = &addrs[intf_num];
 	info->io.addr = NULL;
 	info->io.regspacing = regspacings[intf_num];
 	if (!info->io.regspacing)
@@ -1587,8 +1587,9 @@
 	case 0x01: /* 32-bit boundaries */
 		ipmi_data->offset = 4;
 		break;
-	case 0x02: /* 16-bit boundaries */
-		ipmi_data->offset = 2;
+	case 0x02: /* 16-byte boundaries */
+		ipmi_data->offset = 16;
+		break;
 	default:
 		printk("ipmi_si: Unknown SMBIOS IPMI Base Addr"
 		       " Modifier: 0x%x\n", reg_spacing);

--------------020808040506070200070104--
