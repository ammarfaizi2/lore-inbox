Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSJJCxF>; Wed, 9 Oct 2002 22:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSJJCxF>; Wed, 9 Oct 2002 22:53:05 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:46056 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262924AbSJJCw7>; Wed, 9 Oct 2002 22:52:59 -0400
Date: Wed, 9 Oct 2002 22:50:53 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.41-ac2 : drivers/isdn/hisax/ locking updates
Message-ID: <Pine.LNX.4.44.0210092239560.9141-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patches replace the cli/save(restore)_flags combo 
with spin_(un)lock_irqsave/restore . Please review. 

The files affected are asuscom.c , diva.c jade.c , jade_irq.c , w6692.c 

Regards,
Frank

--- linux/drivers/isdn/hisax/asuscom.c.old	Mon Sep  9 18:43:46 2002
+++ linux/drivers/isdn/hisax/asuscom.c	Wed Oct  9 22:25:07 2002
@@ -24,6 +24,7 @@
 
 const char *Asuscom_revision = "$Revision: 1.11.6.3 $";
 
+static spinlock_t asuscom_lock = SPIN_LOCK_UNLOCKED;
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
 
@@ -46,13 +47,12 @@
 readreg(unsigned int ale, unsigned int adr, u_char off)
 {
 	register u_char ret;
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&asuscom_lock, flags);
 	byteout(ale, off);
 	ret = bytein(adr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&asuscom_lock, flags);
 	return (ret);
 }
 
@@ -69,13 +69,12 @@
 static inline void
 writereg(unsigned int ale, unsigned int adr, u_char off, u_char data)
 {
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&asuscom_lock, flags);
 	byteout(ale, off);
 	byteout(adr, data);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&asuscom_lock, flags);
 }
 
 static inline void
@@ -263,14 +262,13 @@
 static void
 reset_asuscom(struct IsdnCardState *cs)
 {
-	long flags;
+	unsigned long flags;
 
 	if (cs->subtyp == ASUS_IPAC)
 		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_POTA2, 0x20);
 	else
 		byteout(cs->hw.asus.adr, ASUS_RESET);	/* Reset On */
-	save_flags(flags);
-	sti();
+	spin_lock_irqsave(&asuscom_lock, flags);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout((10*HZ)/1000);
 	if (cs->subtyp == ASUS_IPAC)
@@ -286,7 +284,7 @@
 		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_MASK, 0xc0);
 		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_PCFG, 0x12);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&asuscom_lock, flags);
 }
 
 static int


--- linux/drivers/isdn/hisax/diva.c.old	Mon Sep  9 18:43:47 2002
+++ linux/drivers/isdn/hisax/diva.c	Wed Oct  9 22:37:50 2002
@@ -29,6 +29,7 @@
 extern const char *CardType[];
 
 const char *Diva_revision = "$Revision: 1.25.6.5 $";
+static spinlock_t diva_lock = SPIN_LOCK_UNLOCKED;
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -85,13 +86,12 @@
 readreg(unsigned int ale, unsigned int adr, u_char off)
 {
 	register u_char ret;
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&diva_lock, flags);
 	byteout(ale, off);
 	ret = bytein(adr);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 	return (ret);
 }
 
@@ -108,13 +108,12 @@
 static inline void
 writereg(unsigned int ale, unsigned int adr, u_char off, u_char data)
 {
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&diva_lock, flags);
 	byteout(ale, off);
 	byteout(adr, data);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 }
 
 static inline void
@@ -408,13 +407,12 @@
 static inline void
 MemWriteHSCXCMDR(struct IsdnCardState *cs, int hscx, u_char data)
 {
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&diva_lock, flags);
 	MemwaitforCEC(cs, hscx);
 	MemWriteHSCX(cs, hscx, HSCX_CMDR, data);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 }
 
 static void
@@ -422,7 +420,7 @@
 {
 	u_char *ptr;
 	struct IsdnCardState *cs = bcs->cs;
-	long flags;
+	unsigned long flags;
 	int cnt;
 
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
@@ -435,8 +433,7 @@
 		bcs->hw.hscx.rcvidx = 0;
 		return;
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&diva_lock, flags);
 	ptr = bcs->hw.hscx.rcvbuf + bcs->hw.hscx.rcvidx;
 	cnt = count;
 	while (cnt--)
@@ -444,7 +441,7 @@
 	MemWriteHSCXCMDR(cs, bcs->hw.hscx.hscx, 0x80);
 	ptr = bcs->hw.hscx.rcvbuf + bcs->hw.hscx.rcvidx;
 	bcs->hw.hscx.rcvidx += count;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 	if (cs->debug & L1_DEB_HSCX_FIFO) {
 		char *t = bcs->blog;
 
@@ -462,7 +459,7 @@
 	int more, count, cnt;
 	int fifo_size = test_bit(HW_IPAC, &cs->HW_Flags)? 64: 32;
 	u_char *ptr,*p;
-	long flags;
+	unsigned long flags;
 
 
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
@@ -481,8 +478,7 @@
 		count = bcs->tx_skb->len;
 	cnt = count;
 	MemwaitforXFW(cs, bcs->hw.hscx.hscx);
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&diva_lock, flags);
 	p = ptr = bcs->tx_skb->data;
 	skb_pull(bcs->tx_skb, count);
 	bcs->tx_cnt -= count;
@@ -491,7 +487,7 @@
 		memwritereg(cs->hw.diva.cfg_reg, bcs->hw.hscx.hscx ? 0x40 : 0,
 			*p++);
 	MemWriteHSCXCMDR(cs, bcs->hw.hscx.hscx, more ? 0x8 : 0xa);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 	if (cs->debug & L1_DEB_HSCX_FIFO) {
 		char *t = bcs->blog;
 
@@ -753,10 +749,9 @@
 static void
 reset_diva(struct IsdnCardState *cs)
 {
-	long flags;
+	unsigned long flags;
 
-	save_flags(flags);
-	sti();
+	spin_lock_irqsave(&diva_lock, flags);
 	if (cs->subtyp == DIVA_IPAC_ISA) {
 		writereg(cs->hw.diva.isac_adr, cs->hw.diva.isac, IPAC_POTA2, 0x20);
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -803,7 +798,7 @@
 		}
 		byteout(cs->hw.diva.ctrl, cs->hw.diva.ctrl_reg);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&diva_lock, flags);
 }
 
 #define DIVA_ASSIGN 1

--- linux/drivers/isdn/hisax/jade.c.old	Mon Oct  7 21:58:27 2002
+++ linux/drivers/isdn/hisax/jade.c	Wed Oct  9 22:30:01 2002
@@ -18,6 +18,7 @@
 #include "isdnl1.h"
 #include <linux/interrupt.h>
 
+static spinlock_t jade_lock = SPIN_LOCK_UNLOCKED;
 
 int __init
 JadeVersion(struct IsdnCardState *cs, char *s)
@@ -50,10 +51,9 @@
 jade_write_indirect(struct IsdnCardState *cs, u_char reg, u_char value)
 {
     int to = 50;
-    long flags;
+    unsigned long flags;
     u_char ret;
-    save_flags(flags);
-    cli();
+    spin_lock_irqsave(&jade_lock, flags);
     /* Write the data */
     cs->BC_Write_Reg(cs, -1, COMM_JADE+1, value);
     /* Say JADE we wanna write indirect reg 'reg' */
@@ -68,12 +68,12 @@
 	    /* Got acknowledge */
 	    break;
 	if (!to) {
-	    restore_flags(flags);
+	    spin_unlock_irqrestore(&jade_lock, flags);
     	    printk(KERN_INFO "Can not see ready bit from JADE DSP (reg=0x%X, value=0x%X)\n", reg, value);
 	    return;
 	}
     }
-    restore_flags(flags);
+    spin_unlock_irqrestore(&jade_lock, flags);
 }
 
 
@@ -145,20 +145,19 @@
 jade_l2l1(struct PStack *st, int pr, void *arg)
 {
     struct sk_buff *skb = arg;
-    long flags;
+    unsigned long flags;
 
     switch (pr) {
 	case (PH_DATA | REQUEST):
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&jade_lock, flags);
 		if (st->l1.bcs->tx_skb) {
 			skb_queue_tail(&st->l1.bcs->squeue, skb);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&jade_lock, flags);
 		} else {
 			st->l1.bcs->tx_skb = skb;
 			test_and_set_bit(BC_FLG_BUSY, &st->l1.bcs->Flag);
 			st->l1.bcs->hw.hscx.count = 0;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&jade_lock, flags);
 			st->l1.bcs->cs->BC_Send_Data(st->l1.bcs);
 		}
 		break;

--- linux/drivers/isdn/hisax/w6692.c.old	Mon Oct  7 21:58:27 2002
+++ linux/drivers/isdn/hisax/w6692.c	Mon Oct  7 23:16:11 2002
@@ -43,6 +43,8 @@
 
 const char *w6692_revision = "$Revision: 1.12.6.6 $";
 
+static spinlock_t w6692_lock = SPIN_LOCK_UNLOCKED;
+
 #define DBUSY_TIMER_VALUE 80
 
 static char *W6692Ver[] __initdata =
@@ -149,7 +151,7 @@
 W6692_empty_fifo(struct IsdnCardState *cs, int count)
 {
 	u_char *ptr;
-	long flags;
+	unsigned long flags;
 
 	if ((cs->debug & L1_DEB_ISAC) && !(cs->debug & L1_DEB_ISAC_FIFO))
 		debugl1(cs, "W6692_empty_fifo");
@@ -164,11 +166,10 @@
 	}
 	ptr = cs->rcvbuf + cs->rcvidx;
 	cs->rcvidx += count;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&w6692_lock, flags);
 	cs->readW6692fifo(cs, ptr, count);
 	cs->writeW6692(cs, W_D_CMDR, W_D_CMDR_RACK);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&w6692_lock, flags);
 	if (cs->debug & L1_DEB_ISAC_FIFO) {
 		char *t = cs->dlog;
 
@@ -183,7 +184,7 @@
 {
 	int count, more;
 	u_char *ptr;
-	long flags;
+	unsigned long flags;
 
 	if ((cs->debug & L1_DEB_ISAC) && !(cs->debug & L1_DEB_ISAC_FIFO))
 		debugl1(cs, "W6692_fill_fifo");
@@ -200,14 +201,13 @@
 		more = !0;
 		count = W_D_FIFO_THRESH;
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&w6692_lock, flags);
 	ptr = cs->tx_skb->data;
 	skb_pull(cs->tx_skb, count);
 	cs->tx_cnt += count;
 	cs->writeW6692fifo(cs, ptr, count);
 	cs->writeW6692(cs, W_D_CMDR, more ? W_D_CMDR_XMS : (W_D_CMDR_XMS | W_D_CMDR_XME));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&w6692_lock , flags);
 	if (test_and_set_bit(FLG_DBUSY_TIMER, &cs->HW_Flags)) {
 		debugl1(cs, "W6692_fill_fifo dbusytimer running");
 		del_timer(&cs->dbusytimer);
@@ -229,7 +229,7 @@
 {
 	u_char *ptr;
 	struct IsdnCardState *cs = bcs->cs;
-	long flags;
+	unsigned long flags;
 
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
 		debugl1(cs, "W6692B_empty_fifo");
@@ -243,11 +243,10 @@
 	}
 	ptr = bcs->hw.w6692.rcvbuf + bcs->hw.w6692.rcvidx;
 	bcs->hw.w6692.rcvidx += count;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&w6692_lock, flags);
 	READW6692BFIFO(cs, bcs->channel, ptr, count);
 	cs->BC_Write_Reg(cs, bcs->channel, W_B_CMDR, W_B_CMDR_RACK | W_B_CMDR_RACT);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&w6692_lock , flags);
 	if (cs->debug & L1_DEB_HSCX_FIFO) {
 		char *t = bcs->blog;
 
@@ -264,7 +263,7 @@
 	struct IsdnCardState *cs = bcs->cs;
 	int more, count;
 	u_char *ptr;
-	long flags;
+	unsigned long flags;
 
 
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
@@ -282,15 +281,14 @@
 	} else
 		count = bcs->tx_skb->len;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&w6692_lock, flags);
 	ptr = bcs->tx_skb->data;
 	skb_pull(bcs->tx_skb, count);
 	bcs->tx_cnt -= count;
 	bcs->hw.w6692.count += count;
 	WRITEW6692BFIFO(cs, bcs->channel, ptr, count);
 	cs->BC_Write_Reg(cs, bcs->channel, W_B_CMDR, W_B_CMDR_RACT | W_B_CMDR_XMS | (more ? 0 : W_B_CMDR_XME));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&w6692_lock , flags);
 	if (cs->debug & L1_DEB_HSCX_FIFO) {
 		char *t = bcs->blog;
 
@@ -411,7 +409,7 @@
 	u_char val, exval, v1;
 	struct sk_buff *skb;
 	unsigned int count;
-	long flags;
+	unsigned long flags;
 	int icnt = 5;
 
 	if (!cs) {
@@ -442,8 +440,7 @@
 			if (count == 0)
 				count = W_D_FIFO_THRESH;
 			W6692_empty_fifo(cs, count);
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&w6692_lock, flags);
 			if ((count = cs->rcvidx) > 0) {
 				cs->rcvidx = 0;
 				if (!(skb = alloc_skb(count, GFP_ATOMIC)))
@@ -453,7 +450,7 @@
 					skb_queue_tail(&cs->rq, skb);
 				}
 			}
-			restore_flags(flags);
+			spin_unlock_irqrestore(&w6692_lock , flags);
 		}
 		cs->rcvidx = 0;
 		W6692_sched_event(cs, D_RCVBUFREADY);
@@ -745,20 +742,19 @@
 W6692_l2l1(struct PStack *st, int pr, void *arg)
 {
 	struct sk_buff *skb = arg;
-	long flags;
+	unsigned long flags;
 
 	switch (pr) {
 		case (PH_DATA | REQUEST):
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&w6692_lock, flags);
 			if (st->l1.bcs->tx_skb) {
 				skb_queue_tail(&st->l1.bcs->squeue, skb);
-				restore_flags(flags);
+				spin_unlock_irqrestore(&w6692_lock , flags);
 			} else {
 				st->l1.bcs->tx_skb = skb;
 				test_and_set_bit(BC_FLG_BUSY, &st->l1.bcs->Flag);
 				st->l1.bcs->hw.w6692.count = 0;
-				restore_flags(flags);
+				spin_unlock_irqrestore(&w6692_lock , flags);
 				st->l1.bcs->cs->BC_Send_Data(st->l1.bcs);
 			}
 			break;

