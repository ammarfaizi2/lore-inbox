Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRCNFWu>; Wed, 14 Mar 2001 00:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRCNFWk>; Wed, 14 Mar 2001 00:22:40 -0500
Received: from f74.law3.hotmail.com ([209.185.241.74]:45060 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131305AbRCNFW3>;
	Wed, 14 Mar 2001 00:22:29 -0500
X-Originating-IP: [65.25.188.54]
From: "John William" <jw2357@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] HP Vectra XU 5/90 interrupt problems
Date: Wed, 14 Mar 2001 05:21:43 
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_2ca8_4bc7_4770"
Message-ID: <F74vus7H5bYjxHBJnHP0000e647@hotmail.com>
X-OriginalArrivalTime: 14 Mar 2001 05:21:43.0160 (UTC) FILETIME=[A7F03780:01C0AC46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_2ca8_4bc7_4770
Content-Type: text/plain; format=flowed

I propose a patch of mpparse.c (patched against 2.4.2) to fix the Vectra XU 
interrupt problem.

By the time we get to construct_default_ioirq_mptable(), we know we have an 
ISA/PCI machine without any IRQ entries in the MP table. At this point the 
kernel would just set up all the IRQ entries as ISA conforming entries (edge 
sensitive). So any shared PCI interrupts won't work right.

A quick sanity check is made against the ELCR data (IRQ0, 1, 2 and 13 can 
never be level sensitive). If the check passes, the ELCR data is copied into 
the new MP table we are creating. This sets the PCI interrupts to level 
sensitive.

This patch works on the Vectra XU 5/90 machines I have here.

Comments are welcome!

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

------=_NextPart_000_2ca8_4bc7_4770
Content-Type: text/plain; name="mpparse.diff"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mpparse.diff"

diff -u linux/arch/i386/kernel/mpparse.bak linux/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.bak	Tue Nov 14 23:25:34 2000
+++ linux/arch/i386/kernel/mpparse.c	Tue Mar 13 23:08:01 2001
@@ -361,10 +361,19 @@
	return num_processors;
}

+static int __init ELCR_trigger(unsigned int irq)
+{
+	unsigned int port;
+
+	port = 0x4d0 + (irq >> 3);
+	return (inb(port) >> (irq & 7)) & 1;
+}
+
static void __init construct_default_ioirq_mptable(int mpc_default_type)
{
	struct mpc_config_intsrc intsrc;
	int i;
+	int ELCR_fallback = 0;

	intsrc.mpc_type = MP_INTSRC;
	intsrc.mpc_irqflag = 0;			/* conforming */
@@ -372,6 +381,26 @@
	intsrc.mpc_dstapic = mp_ioapics[0].mpc_apicid;

	intsrc.mpc_irqtype = mp_INT;
+
+	/*
+	 *  If true, we have an ISA/PCI system with no IRQ entries
+	 *  in the MP table. To prevent the PCI interrupts from being set up
+	 *  incorrectly, we try to use the ELCR. The sanity check to see if
+	 *  there is good ELCR data is very simple - IRQ0, 1, 2 and 13 can
+	 *  never be level sensitive, so we simply see if the ELCR agrees.
+	 *  If it does, we assume it's valid.
+	 */
+	if (mpc_default_type == 5) {
+		printk("ISA/PCI bus type with no IRQ information... falling back to 
ELCR\n");
+
+		if (ELCR_trigger(0) || ELCR_trigger(1) || ELCR_trigger(2) || 
ELCR_trigger(13))
+			printk("ELCR contains invalid data... not using ELCR\n");
+		else {
+			printk("Using ELCR to identify PCI interrupts\n");
+			ELCR_fallback = 1;
+		}
+	}
+
	for (i = 0; i < 16; i++) {
		switch (mpc_default_type) {
		case 2:
@@ -381,6 +410,18 @@
		default:
			if (i == 2)
				continue;	/* IRQ2 is never connected */
+		}
+
+		if (ELCR_fallback) {
+			/*
+			 *  If the ELCR indicates a level-sensitive interrupt, we
+			 *  copy that information over to the MP table in the
+			 *  irqflag field (level sensitive, active high polarity).
+			 */
+			if (ELCR_trigger(i))
+				intsrc.mpc_irqflag = 13;
+			else
+				intsrc.mpc_irqflag = 0;
		}

		intsrc.mpc_srcbusirq = i;


------=_NextPart_000_2ca8_4bc7_4770--
