Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282688AbRLFSwC>; Thu, 6 Dec 2001 13:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLFSvy>; Thu, 6 Dec 2001 13:51:54 -0500
Received: from d-dialin-651.addcom.de ([62.96.161.179]:23278 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282499AbRLFSvs>; Thu, 6 Dec 2001 13:51:48 -0500
Date: Thu, 6 Dec 2001 19:50:05 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Karsten Keil <keil@isdn4linux.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: ISDN compile broken since 2.4.17-pre3
In-Reply-To: <Pine.NEB.4.43.0112061603240.3735-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0112061944440.4484-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Adrian Bunk wrote:

> 2.4.17-pre3 adds the files hisax_isac.{c,h}. The problem is that they
> define a function isac_interrupt that is different from the one already
> present in isac.{c,h}. This produces the following error when you use a
> .config that tries to compile both files into the kernel:

Uh-oh, you're right. Here's a patch which renames the new function (and 
some others, for consistency). 

Marcelo, please apply.

--Kai

diff -X excl -urN linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_fcpcipnp.c linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_fcpcipnp.c
--- linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_fcpcipnp.c	Thu Dec  6 19:16:40 2001
+++ linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_fcpcipnp.c	Thu Dec  6 19:26:35 2001
@@ -533,7 +533,7 @@
 	dev_kfree_skb_irq(skb);
 }
 
-static void hdlc_irq(struct fritz_bcs *bcs, u32 stat)
+static void hdlc_irq_one(struct fritz_bcs *bcs, u32 stat)
 {
 	DBG(0x10, "ch%d stat %#x", bcs->channel, stat);
 	if (stat & HDLC_INT_RPR) {
@@ -550,7 +550,7 @@
 	}
 }
 
-static inline void hdlc_interrupt(struct fritz_adapter *adapter)
+static inline void hdlc_irq(struct fritz_adapter *adapter)
 {
 	int nr;
 	u32 stat;
@@ -559,7 +559,7 @@
 		stat = adapter->read_hdlc_status(adapter, nr);
 		DBG(0x10, "HDLC %c stat %#x", 'A' + nr, stat);
 		if (stat & HDLC_INT_MASK)
-			hdlc_irq(&adapter->bcs[nr], stat);
+			hdlc_irq_one(&adapter->bcs[nr], stat);
 	}
 }
 
@@ -642,10 +642,10 @@
 		return;
 	DBG(2, "STATUS0 %#x", val);
 	if (val & AVM_STATUS0_IRQ_ISAC)
-		isacsx_interrupt(&adapter->isac);
+		isacsx_irq(&adapter->isac);
 
 	if (val & AVM_STATUS0_IRQ_HDLC)
-		hdlc_interrupt(adapter);
+		hdlc_irq(adapter);
 }
 
 static void fcpci_irq(int intno, void *dev, struct pt_regs *regs)
@@ -659,10 +659,10 @@
 		return;
 	DBG(2, "sval %#x", sval);
 	if (!(sval & AVM_STATUS0_IRQ_ISAC))
-		isac_interrupt(&adapter->isac);
+		isac_irq(&adapter->isac);
 
 	if (!(sval & AVM_STATUS0_IRQ_HDLC))
-		hdlc_interrupt(adapter);
+		hdlc_irq(adapter);
 }
 
 // ----------------------------------------------------------------------
diff -X excl -urN linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_isac.c linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_isac.c
--- linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_isac.c	Thu Dec  6 19:16:40 2001
+++ linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_isac.c	Thu Dec  6 19:28:15 2001
@@ -601,7 +601,7 @@
 	}
 }
 
-void isac_interrupt(struct isac *isac)
+void isac_irq(struct isac *isac)
 {
 	unsigned char val;
 
@@ -741,7 +741,7 @@
 	}
 }
 
-void isacsx_interrupt(struct isac *isac)
+void isacsx_irq(struct isac *isac)
 {
 	unsigned char val;
 
@@ -887,10 +887,10 @@
 EXPORT_SYMBOL(isac_d_l2l1);
 
 EXPORT_SYMBOL(isacsx_setup);
-EXPORT_SYMBOL(isacsx_interrupt);
+EXPORT_SYMBOL(isacsx_irq);
 
 EXPORT_SYMBOL(isac_setup);
-EXPORT_SYMBOL(isac_interrupt);
+EXPORT_SYMBOL(isac_irq);
 
 module_init(hisax_isac_init);
 module_exit(hisax_isac_exit);
diff -X excl -urN linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_isac.h linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_isac.h
--- linux-2.4.17-pre4.patches/drivers/isdn/hisax/hisax_isac.h	Thu Dec  6 19:32:06 2001
+++ linux-2.4.17-pre4.work/drivers/isdn/hisax/hisax_isac.h	Thu Dec  6 19:33:32 2001
@@ -37,9 +37,9 @@
 void isac_d_l2l1(struct hisax_if *hisax_d_if, int pr, void *arg);
 
 void isac_setup(struct isac *isac);
-void isac_interrupt(struct isac *isac);
+void isac_irq(struct isac *isac);
 
 void isacsx_setup(struct isac *isac);
-void isacsx_interrupt(struct isac *isac);
+void isacsx_irq(struct isac *isac);
 
 #endif



