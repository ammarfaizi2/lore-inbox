Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbTCLUwu>; Wed, 12 Mar 2003 15:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbTCLUwW>; Wed, 12 Mar 2003 15:52:22 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:49313 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262009AbTCLUus>;
	Wed, 12 Mar 2003 15:50:48 -0500
Date: Wed, 12 Mar 2003 23:59:35 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com
Subject: [2.4] Memleak/unchecked user access in Megaraid driver?
Message-ID: <20030312205935.GA28556@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Seems there is a memleak on exit path and unchecked user addresses access
   in megaraid driver from 2.4-current.

   Probably something like following patch should be applied (probably
   somebody should review it first anyway, I do not have ability to test it,
   but it looks correct to me).

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/scsi/megaraid.c 1.21 vs edited =====
--- 1.21/drivers/scsi/megaraid.c	Fri Dec 13 12:29:59 2002
+++ edited/drivers/scsi/megaraid.c	Wed Mar 12 23:59:09 2003
@@ -4895,19 +4895,18 @@
 
 			if( kvaddr == NULL ) {
 				printk(KERN_WARNING "megaraid:allocation failed\n");
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/*0x20400 */
-				kfree(scsicmd);
-#else
-				scsi_init_free((char *)scsicmd, sizeof(Scsi_Cmnd));
-#endif
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out;
 			}
 
 			ioc.ui.fcs.buffer = kvaddr;
 
 			if (inlen) {
 				/* copyin the user data */
-				copy_from_user(kvaddr, (char *)uaddr, length );
+				if (copy_from_user(kvaddr, (char *)uaddr, length )) {
+					ret = -EFAULT;
+					goto out;
+				}
 			}
 		}
 
@@ -4925,7 +4924,8 @@
 
 		if( !scsicmd->result && outlen ) {
 			if (copy_to_user(uaddr, kvaddr, length))
-				return -EFAULT;
+				ret = -EFAULT;
+				goto out;
 		}
 
 		/*
@@ -4944,6 +4944,7 @@
 			put_user (scsicmd->result, &uioc->mbox[17]);
 		}
 
+out:
 		if (kvaddr) {
 			dma_free_consistent(pdevp, length, kvaddr, dma_addr);
 		}
