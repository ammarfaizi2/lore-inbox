Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbTEENlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTEENlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:41:21 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:30350 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262216AbTEENlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:41:20 -0400
Date: Mon, 5 May 2003 09:52:24 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200305051352.h45DqOc8017722@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] iphase stack usage cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

someone noted the iphase driver's stack usage.  this
should take care of the biggest offender.

--- linux-2.5.68/drivers/atm/iphase.c.000	Mon May  5 08:43:18 2003
+++ linux-2.5.68/drivers/atm/iphase.c	Mon May  5 09:41:56 2003
@@ -2789,11 +2789,15 @@
              break;
           case MEMDUMP_FFL:
           {  
-             ia_regs_t       regs_local;
-             ffredn_t        *ffL = &regs_local.ffredn;
-             rfredn_t        *rfL = &regs_local.rfredn;
+             ia_regs_t       *regs_local;
+             ffredn_t        *ffL;
+             rfredn_t        *rfL;
                      
 	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
+	     regs_local = kmalloc(sizeof(*regs_local), GFP_KERNEL);
+	     if (!regs_local) return -ENOMEM;
+	     ffL = &regs_local->ffredn;
+	     rfL = &regs_local->rfredn;
              /* Copy real rfred registers into the local copy */
  	     for (i=0; i<(sizeof (rfredn_t))/4; i++)
                 ((u_int *)rfL)[i] = ((u_int *)iadev->reass_reg)[i] & 0xffff;
@@ -2801,8 +2805,11 @@
 	     for (i=0; i<(sizeof (ffredn_t))/4; i++)
                 ((u_int *)ffL)[i] = ((u_int *)iadev->seg_reg)[i] & 0xffff;
 
-             if (copy_to_user(ia_cmds.buf, &regs_local,sizeof(ia_regs_t)))
+             if (copy_to_user(ia_cmds.buf, regs_local,sizeof(ia_regs_t))) {
+                kfree(regs_local);
                 return -EFAULT;
+             }
+             kfree(regs_local);
              printk("Board %d registers dumped\n", board);
              ia_cmds.status = 0;                  
 	 }	
