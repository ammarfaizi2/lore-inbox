Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSLBH0N>; Mon, 2 Dec 2002 02:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSLBH0N>; Mon, 2 Dec 2002 02:26:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:13460 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265647AbSLBH0J>;
	Mon, 2 Dec 2002 02:26:09 -0500
Date: Sun, 1 Dec 2002 23:33:09 -0800
From: Richard Henderson <rth@twiddle.net>
To: Bjoern Brauel <bjb@gentoo.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: patch: linux-2.4.20 alpha broken cia(rev1) fix
Message-ID: <20021201233309.A32203@twiddle.net>
Mail-Followup-To: Bjoern Brauel <bjb@gentoo.org>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <3DE7A5F4.5030503@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE7A5F4.5030503@gentoo.org>; from bjb@gentoo.org on Fri, Nov 29, 2002 at 06:37:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 06:37:56PM +0100, Bjoern Brauel wrote:
> The attached patch fixes the initialization for CIA revision 1 chips 
> that can be found on most Alcor machines. As it is impossible to boot 
> such a box together with the Qlogic ISP SCSI controller without this 
> patch I believe it is important to include it in the official kernel.

Try this version instead.  Control structures should not be
replicated in different functions like that.  It's a sure
recipie for one of them getting out of sync.


r~



===== arch/alpha/kernel/core_cia.c 1.6 vs edited =====
--- 1.6/arch/alpha/kernel/core_cia.c	Mon Feb  4 23:52:51 2002
+++ edited/arch/alpha/kernel/core_cia.c	Sun Dec  1 23:26:06 2002
@@ -370,7 +370,7 @@
 }
 
 static inline void
-cia_prepare_tbia_workaround(void)
+cia_prepare_tbia_workaround(int window)
 {
 	unsigned long *ppte, pte;
 	long i;
@@ -382,10 +382,10 @@
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;
 
-	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
-	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
-				    & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	*(vip)CIA_IOC_PCI_Wn_BASE(window) = CIA_BROKEN_TBIA_BASE | 3;
+	*(vip)CIA_IOC_PCI_Wn_MASK(window)
+	  = (CIA_BROKEN_TBIA_SIZE*1024 - 1) & 0xfff00000;
+	*(vip)CIA_IOC_PCI_Tn_BASE(window) = virt_to_phys(ppte) >> 2;
 }
 
 static void __init
@@ -605,8 +605,7 @@
 do_init_arch(int is_pyxis)
 {
 	struct pci_controller *hose;
-	int temp;
-	int cia_rev;
+	int temp, cia_rev, tbia_window;
 
 	cia_rev = *(vip)CIA_IOC_CIA_REV & CIA_REV_MASK;
 	printk("pci: cia revision %d%s\n",
@@ -715,8 +714,20 @@
 	   are compared against W_DAC.  We can, however, directly map 4GB,
 	   which is better than before.  However, due to assumptions made
 	   elsewhere, we should not claim that we support DAC unless that
-	   4GB covers all of physical memory.  */
-	if (is_pyxis || max_low_pfn > (0x100000000 >> PAGE_SHIFT)) {
+	   4GB covers all of physical memory.
+
+	   On CIA rev 1, apparently W1 and W2 can't be used for SG.
+	   At least, there are reports that it doesn't work for Alcor.
+	   In that case, we have no choice but to use W3 for the TBIA
+	   workaround, which means we can't use DAC at all.  */
+
+	tbia_window = 1;
+	if (is_pyxis) {
+		*(vip)CIA_IOC_PCI_W3_BASE = 0;
+	} else if (cia_rev == 1) {
+		*(vip)CIA_IOC_PCI_W1_BASE = 0;
+		tbia_window = 3;
+	} else if (max_low_pfn > (0x100000000 >> PAGE_SHIFT)) {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0;
 	} else {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0x00000000 | 1 | 8;
@@ -728,7 +739,7 @@
 	}
 
 	/* Prepare workaround for apparently broken tbia. */
-	cia_prepare_tbia_workaround();
+	cia_prepare_tbia_workaround(tbia_window);
 }
 
 void __init
===== include/asm-alpha/core_cia.h 1.4 vs edited =====
--- 1.4/include/asm-alpha/core_cia.h	Mon Feb  4 23:55:11 2002
+++ edited/include/asm-alpha/core_cia.h	Sun Dec  1 20:23:23 2002
@@ -202,6 +202,10 @@
 #define CIA_IOC_PCI_W3_MASK		(IDENT_ADDR + 0x8760000740UL)
 #define CIA_IOC_PCI_T3_BASE		(IDENT_ADDR + 0x8760000780UL)
 
+#define CIA_IOC_PCI_Wn_BASE(N)	  (IDENT_ADDR + 0x8760000400UL + (N)*0x100)
+#define CIA_IOC_PCI_Wn_MASK(N)	  (IDENT_ADDR + 0x8760000440UL + (N)*0x100)
+#define CIA_IOC_PCI_Tn_BASE(N)	  (IDENT_ADDR + 0x8760000480UL + (N)*0x100)
+
 #define CIA_IOC_PCI_W_DAC		(IDENT_ADDR + 0x87600007C0UL)
 
 /*
