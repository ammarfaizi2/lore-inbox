Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSIDXW5>; Wed, 4 Sep 2002 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSIDXW5>; Wed, 4 Sep 2002 19:22:57 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:41419 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316322AbSIDXWy>;
	Wed, 4 Sep 2002 19:22:54 -0400
Date: Wed, 4 Sep 2002 16:27:29 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Wavelan ISA update
Message-ID: <20020904232728.GC21592@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Could you please push the following patch upstream ?
	A few cleanups for the good old Wavelan ISA driver. Tested on
2.5.32 SMP.

	Have fun...

	Jean

----------------------------------------------------------

diff -u -p linux/drivers/net/wireless/wavelan.p.25.h linux/drivers/net/wireless/wavelan.p.h
--- linux/drivers/net/wireless/wavelan.p.25.h	Tue Sep  3 14:39:56 2002
+++ linux/drivers/net/wireless/wavelan.p.h	Wed Sep  4 15:22:23 2002
@@ -351,6 +351,12 @@
  *		o got rid of wavelan_ioctl()
  *		o use a bunch of iw_handler instead
  *
+ * Changes made for release in 2.5.35 :
+ * ----------------------------------
+ *	- Set dev->trans_start to avoid filling the logs
+ *	- Handle better spurious/bogus interrupt
+ *	- Avoid deadlocks in mmc_out()/mmc_in()
+ *
  * Wishes & dreams:
  * ----------------
  *	- roaming (see Pcmcia driver)
diff -u -p linux/drivers/net/wireless/wavelan.25.c linux/drivers/net/wireless/wavelan.c
--- linux/drivers/net/wireless/wavelan.25.c	Tue Sep  3 14:39:45 2002
+++ linux/drivers/net/wireless/wavelan.c	Wed Sep  4 15:27:10 2002
@@ -312,8 +312,11 @@ static void update_psa_checksum(device *
  */
 static inline void mmc_out(unsigned long ioaddr, u16 o, u8 d)
 {
+	int count = 0;
+
 	/* Wait for MMC to go idle */
-	while (inw(HASR(ioaddr)) & HASR_MMC_BUSY);
+	while ((count++ < 100) && (inw(HASR(ioaddr)) & HASR_MMC_BUSY))
+		udelay(10);
 
 	outw((u16) (((u16) d << 8) | (o << 1) | 1), MMCR(ioaddr));
 }
@@ -339,10 +342,14 @@ static inline void mmc_write(unsigned lo
  */
 static inline u8 mmc_in(unsigned long ioaddr, u16 o)
 {
-	while (inw(HASR(ioaddr)) & HASR_MMC_BUSY);
+	int count = 0;
+
+	while ((count++ < 100) && (inw(HASR(ioaddr)) & HASR_MMC_BUSY))
+		udelay(10);
 	outw(o << 1, MMCR(ioaddr));
 
-	while (inw(HASR(ioaddr)) & HASR_MMC_BUSY);
+	while ((count++ < 100) && (inw(HASR(ioaddr)) & HASR_MMC_BUSY))
+		udelay(10);
 	return (u8) (inw(MMCR(ioaddr)) >> 8);
 }
 
@@ -2958,6 +2965,9 @@ static inline int wv_packet_write(device
 		    (unsigned char *) &nop.nop_h.ac_link,
 		    sizeof(nop.nop_h.ac_link));
 
+	/* Make sure the watchdog will keep quiet for a while */
+	dev->trans_start = jiffies;
+
 	/* Keep stats up to date. */
 	lp->stats.tx_bytes += length;
 
@@ -3874,29 +3884,48 @@ static void wavelan_interrupt(int irq, v
 	 * the spinlock. */
 	spin_lock(&lp->spinlock);
 
+	/* We always had spurious interrupts at startup, but lately I
+	 * saw them comming *between* the request_irq() and the
+	 * spin_lock_irqsave() in wavelan_open(), so the spinlock
+	 * protection is no enough.
+	 * So, we also check lp->hacr that will tell us is we enabled
+	 * irqs or not (see wv_ints_on()).
+	 * We can't use netif_running(dev) because we depend on the
+	 * proper processing of the irq generated during the config. */
+
+	/* Which interrupt it is ? */
+	hasr = hasr_read(ioaddr);
+
+#ifdef DEBUG_INTERRUPT_INFO
+	printk(KERN_INFO
+	       "%s: wavelan_interrupt(): hasr 0x%04x; hacr 0x%04x.\n",
+	       dev->name, hasr, lp->hacr);
+#endif
+
 	/* Check modem interrupt */
-	if ((hasr = hasr_read(ioaddr)) & HASR_MMC_INTR) {
+	if ((hasr & HASR_MMC_INTR) && (lp->hacr & HACR_MMC_INT_ENABLE)) {
 		u8 dce_status;
 
+#ifdef DEBUG_INTERRUPT_ERROR
+		printk(KERN_INFO
+		       "%s: wavelan_interrupt(): unexpected mmc interrupt: status 0x%04x.\n",
+		       dev->name, dce_status);
+#endif
 		/*
 		 * Interrupt from the modem management controller.
 		 * This will clear it -- ignored for now.
 		 */
 		mmc_read(ioaddr, mmroff(0, mmr_dce_status), &dce_status,
 			 sizeof(dce_status));
-#ifdef DEBUG_INTERRUPT_ERROR
-		printk(KERN_INFO
-		       "%s: wavelan_interrupt(): unexpected mmc interrupt: status 0x%04x.\n",
-		       dev->name, dce_status);
-#endif
 	}
 
 	/* Check if not controller interrupt */
-	if ((hasr & HASR_82586_INTR) == 0) {
+	if (((hasr & HASR_82586_INTR) == 0) ||
+	    ((lp->hacr & HACR_82586_INT_ENABLE) == 0)) {
 #ifdef DEBUG_INTERRUPT_ERROR
 		printk(KERN_INFO
-		       "%s: wavelan_interrupt(): interrupt not coming from i82586\n",
-		       dev->name);
+		       "%s: wavelan_interrupt(): interrupt not coming from i82586 - hasr 0x%04x.\n",
+		       dev->name, hasr);
 #endif
 		spin_unlock (&lp->spinlock);
 		return;
