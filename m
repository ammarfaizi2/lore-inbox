Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUILLWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUILLWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUILLWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:22:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43002 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268672AbUILLUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:20:43 -0400
Date: Sun, 12 Sep 2004 13:20:30 +0200 (MEST)
Message-Id: <200409121120.i8CBKU3o015140@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ipslinux@adaptec.com, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] ips scsi driver compile failure fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/ips.c fails to compile in the 2.4.28-pre3 kernel:

In file included from ips.c:190:
ips.h:101: error: redefinition of typedef 'irqreturn_t'
/tmp/linux-2.4.28-pre3/include/linux/interrupt.h:16: error: previous declaration of 'irqreturn_t' was here

The irqreturn_t etc compat definitions in ips.h are in conflict
with the compat definitions in interrupt.h, added in kernel 2.4.23.
The patch below fixes the issue for me.

/Mikael

--- linux-2.4.28-pre3/drivers/scsi/ips.h.~1~	2004-09-12 00:23:20.000000000 +0200
+++ linux-2.4.28-pre3/drivers/scsi/ips.h	2004-09-12 02:09:04.000000000 +0200
@@ -97,13 +97,13 @@
 
    #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
    
-      #ifndef irqreturn_t
+      #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
          typedef void irqreturn_t;
+         #define IRQ_NONE
+         #define IRQ_HANDLED
+         #define IRQ_RETVAL(x)
       #endif 
       
-      #define IRQ_NONE
-      #define IRQ_HANDLED
-      #define IRQ_RETVAL(x)
       #define IPS_REGISTER_HOSTS(SHT)      scsi_register_module(MODULE_SCSI_HA,SHT)
       #define IPS_UNREGISTER_HOSTS(SHT)    scsi_unregister_module(MODULE_SCSI_HA,SHT)
       #define IPS_ADD_HOST(shost,device)
