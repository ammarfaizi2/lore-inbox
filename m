Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUBREHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUBREHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:07:30 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60127 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262902AbUBREGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:06:48 -0500
Date: Wed, 18 Feb 2004 15:06:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: Linux 2.6.3-rc4
Message-Id: <20040218150640.6cf643bf.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__18_Feb_2004_15_06_40_+1100_HFtjFLdGYao=W1Lf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__18_Feb_2004_15_06_40_+1100_HFtjFLdGYao=W1Lf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2004 19:51:08 -0800 (PST) Linus Torvalds <torvalds@osdl.org> wrote:
>
> Most notably, this should support ppc/ppc64 out-of-the-box

The following patch makes this even more true :-).  This patch lets
2.6.3-rc4 build and boot on an PPC64 iSeries box (at least for my
configuration).  The veth.o bit in the networking Makefile got there by
accident and should be removed anyway ...

There is more to make it work properly (note the "Temporary hack"), but
this gets us closer.

Please consider applying.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.3-rc4/arch/ppc64/kernel/iSeries_irq.c 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_irq.c
--- 2.6.3-rc4/arch/ppc64/kernel/iSeries_irq.c	2004-02-04 17:24:34.000000000 +1100
+++ 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_irq.c	2004-02-18 14:50:04.000000000 +1100
@@ -57,6 +57,7 @@
 
 void iSeries_init_irq_desc(irq_desc_t *desc)
 {
+	desc->handler = &iSeries_IRQ_handler;
 }
 
 /* This is called by init_IRQ.  set in ppc_md.init_IRQ by iSeries_setup.c */
@@ -87,22 +88,6 @@
 #define IRQ_TO_IDSEL(irq)	(((((irq) - 1) >> 3) & 7) + 1)
 #define IRQ_TO_FUNC(irq)	(((irq) - 1) & 7)
 
-/*
- * This is called out of iSeries_scan_slot to assign the EADS slot
- * to its IRQ number
- */
-int __init iSeries_assign_IRQ(int irq, HvBusNumber busNumber,
-		HvSubBusNumber subBusNumber, HvAgentId deviceId)
-{
-	irq_desc_t *desc = get_real_irq_desc(irq);
-
-	if (desc == NULL)
-		return -1;
-	desc->handler = &iSeries_IRQ_handler;
-	return 0;
-}
-
-
 /* This is called by iSeries_activate_IRQs */
 static unsigned int iSeries_startup_IRQ(unsigned int irq)
 {
@@ -125,6 +110,11 @@
 }
 
 /*
+ * Temporary hack
+ */
+#define get_irq_desc(irq)	&irq_desc[(irq)]
+
+/*
  * This is called out of iSeries_fixup to activate interrupt
  * generation for usable slots
  */
diff -ruN 2.6.3-rc4/arch/ppc64/kernel/iSeries_pci.c 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_pci.c
--- 2.6.3-rc4/arch/ppc64/kernel/iSeries_pci.c	2004-02-18 11:30:38.000000000 +1100
+++ 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_pci.c	2004-02-18 14:43:09.000000000 +1100
@@ -406,7 +406,6 @@
 
 	/* iSeries_allocate_IRQ.: 0x18.00.12(0xA3) */
   	Irq = iSeries_allocate_IRQ(Bus, 0, EADsIdSel);
-	iSeries_assign_IRQ(Irq, Bus, 0, EADsIdSel);
 	PPCDBG(PPCDBG_BUSWALK,
 		"PCI:- allocate and assign IRQ 0x%02X.%02X.%02X = 0x%02X\n",
 		Bus, 0, EADsIdSel, Irq);
diff -ruN 2.6.3-rc4/arch/ppc64/kernel/iSeries_setup.c 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_setup.c
--- 2.6.3-rc4/arch/ppc64/kernel/iSeries_setup.c	2004-02-18 11:30:38.000000000 +1100
+++ 2.6.3-rc4-1/arch/ppc64/kernel/iSeries_setup.c	2004-02-18 14:37:32.000000000 +1100
@@ -315,7 +315,6 @@
 	ppc_md.setup_residual = iSeries_setup_residual;
 	ppc_md.get_cpuinfo = iSeries_get_cpuinfo;
 	ppc_md.init_IRQ = iSeries_init_IRQ;
-	ppc_md.init_irq_desc = iSeries_init_irq_desc;
 	ppc_md.get_irq = iSeries_get_irq;
 	ppc_md.init = NULL;
 
diff -ruN 2.6.3-rc4/drivers/net/Makefile 2.6.3-rc4-1/drivers/net/Makefile
--- 2.6.3-rc4/drivers/net/Makefile	2004-02-18 11:30:51.000000000 +1100
+++ 2.6.3-rc4-1/drivers/net/Makefile	2004-02-18 14:40:06.000000000 +1100
@@ -45,7 +45,6 @@
 obj-$(CONFIG_SIS900) += sis900.o
 obj-$(CONFIG_YELLOWFIN) += yellowfin.o
 obj-$(CONFIG_ACENIC) += acenic.o
-obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_NATSEMI) += natsemi.o
 obj-$(CONFIG_NS83820) += ns83820.o
 obj-$(CONFIG_STNIC) += stnic.o 8390.o

--Signature=_Wed__18_Feb_2004_15_06_40_+1100_HFtjFLdGYao=W1Lf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAMuTQFG47PeJeR58RAlJXAKCq/gPftKRfDFkyO5cqPv31HVFU/gCgsAzq
3uF3bJwBIGR3HAZZoUJX9Ws=
=OjY2
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2004_15_06_40_+1100_HFtjFLdGYao=W1Lf--
