Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCMMgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCMMgu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVCMMgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:36:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:25479 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261186AbVCMMgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:36:45 -0500
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110717016.5787.143.camel@gaston>
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6upsy37o0v.fsf@zork.zork.net>  <1110717016.5787.143.camel@gaston>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 23:35:51 +1100
Message-Id: <1110717351.5787.146.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 23:30 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2005-03-13 at 12:01 +0000, Sean Neakums wrote:
> > Machine check in kernel mode.
> > Caused by (from SRR1=149030): Transfer error ack signal
> > Oops: machine check, sig: 7 [#1]
> > TASK = etc. 'pmud' etc.
> > (for registers and such, see:
> >  http://flynn.zork.net/~sneakums/pmac-machine-check-on-sleep-2611mm3.jpeg )
> > Call trace:
> >  pmac_ide_pci_suspend
> >  pci_device_suspend
> >  suspend_device
> >  device_suspend
> >  0xc03dd894
> >  0xc03dddb8
> >  0xc03de7cc
> >  do_ioctl
> >  vfs_ioctl
> >  sys_ioctl
> >  ret_from_syscall
> 
> Does that fix it ?

Oh, and eventually this one too. Closer to what darwin does: doesn't
disable the ATA/100 cell during sleep. Let me know with both of the
patches. Best would even be if you could figure out which one gives the
best power consumption during sleep in fact (if it makes any noticeable
difference).

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-03-13 10:10:58.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-03-13 23:29:40.000000000 +1100
@@ -1208,16 +1208,17 @@
 	if (pmif->mediabay)
 		return 0;
 	
-	/* Disable the bus */
-	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id, 0);
-
-	/* Kauai has it different */
+	/* Kauai has bus control FCRs directly here */
 	if (pmif->kauai_fcr) {
 		u32 fcr = readl(pmif->kauai_fcr);
 		fcr &= ~(KAUAI_FCR_UATA_RESET_N | KAUAI_FCR_UATA_ENABLE);
 		writel(fcr, pmif->kauai_fcr);
 	}
 
+	/* Disable the bus on older machines and the cell on kauai */
+	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id,
+			    0);
+
 	return 0;
 }
 
Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-03-13 18:23:11.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-03-13 23:34:18.000000000 +1100
@@ -830,6 +830,7 @@
 	return 0;
 }
 
+#if 0
 static long __pmac
 core99_ata100_enable(struct device_node* node, long value)
 {
@@ -859,6 +860,7 @@
 	}
     	return 0;
 }
+#endif
 
 static long __pmac
 core99_ide_enable(struct device_node* node, long param, long value)
@@ -876,8 +878,10 @@
 	    case 2:
 		return simple_feature_tweak(node, macio_unknown,
 			KEYLARGO_FCR1, KL1_UIDE_ENABLE, value);
+#if 0
 	    case 3:
 	    	return core99_ata100_enable(node, value);
+#endif
 	    default:
 	    	return -ENODEV;
 	}


