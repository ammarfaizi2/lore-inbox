Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVADFIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVADFIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVADEvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:51:48 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:28872 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262041AbVADEod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:44:33 -0500
Date: Tue, 4 Jan 2005 15:27:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/11] PPC64: remove serialPortAddr from the naca
Message-Id: <20050104152705.6030abc5.sfr@canb.auug.org.au>
In-Reply-To: <20050104152340.67219ccf.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_27_05_+1100_iHTpbPF/v2VYEpcD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_27_05_+1100_iHTpbPF/v2VYEpcD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The serialPortAddr field of the naca was only being used locally, remove
it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.5/arch/ppc64/kernel/maple_setup.c linus-bk-naca.6/arch/ppc64/kernel/maple_setup.c
--- linus-bk-naca.5/arch/ppc64/kernel/maple_setup.c	2004-12-31 14:53:21.000000000 +1100
+++ linus-bk-naca.6/arch/ppc64/kernel/maple_setup.c	2004-12-11 00:53:42.000000000 +1100
@@ -75,7 +75,8 @@
 extern void maple_pci_init(void);
 extern void maple_pcibios_fixup(void);
 extern int maple_pci_get_legacy_ide_irq(struct pci_dev *dev, int channel);
-extern void generic_find_legacy_serial_ports(unsigned int *default_speed);
+extern void generic_find_legacy_serial_ports(u64 *physport,
+		unsigned int *default_speed);
 
 
 static void maple_restart(char *cmd)
@@ -129,6 +130,7 @@
 static void __init maple_init_early(void)
 {
 	unsigned int default_speed;
+	u64 physport;
 
 	DBG(" -> maple_init_early\n");
 
@@ -138,14 +140,14 @@
 	hpte_init_native();
 
 	/* Find the serial port */
-       	generic_find_legacy_serial_ports(&default_speed);
+	generic_find_legacy_serial_ports(&physport, &default_speed);
 
-	DBG("naca->serialPortAddr: %lx\n", (long)naca->serialPortAddr);
+	DBG("phys port addr: %lx\n", (long)physport);
 
-	if (naca->serialPortAddr) {
+	if (physport) {
 		void *comport;
 		/* Map the uart for udbg. */
-		comport = (void *)__ioremap(naca->serialPortAddr, 16, _PAGE_NO_CACHE);
+		comport = (void *)__ioremap(physport, 16, _PAGE_NO_CACHE);
 		udbg_init_uart(comport, default_speed);
 
 		ppc_md.udbg_putc = udbg_putc;
diff -ruN linus-bk-naca.5/arch/ppc64/kernel/pSeries_setup.c linus-bk-naca.6/arch/ppc64/kernel/pSeries_setup.c
--- linus-bk-naca.5/arch/ppc64/kernel/pSeries_setup.c	2004-12-31 15:22:17.000000000 +1100
+++ linus-bk-naca.6/arch/ppc64/kernel/pSeries_setup.c	2004-12-31 15:35:13.000000000 +1100
@@ -81,7 +81,8 @@
 extern int  pSeries_set_rtc_time(struct rtc_time *rtc_time);
 extern void find_udbg_vterm(void);
 extern void SystemReset_FWNMI(void), MachineCheck_FWNMI(void);	/* from head.S */
-extern void generic_find_legacy_serial_ports(unsigned int *default_speed);
+extern void generic_find_legacy_serial_ports(u64 *physport,
+		unsigned int *default_speed);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
@@ -344,6 +345,7 @@
 	void *comport;
 	int iommu_off = 0;
 	unsigned int default_speed;
+	u64 physport;
 
 	DBG(" -> pSeries_init_early()\n");
 
@@ -357,13 +359,13 @@
 			     get_property(of_chosen, "linux,iommu-off", NULL));
 	}
 
-	generic_find_legacy_serial_ports(&default_speed);
+	generic_find_legacy_serial_ports(&physport, &default_speed);
 
 	if (systemcfg->platform & PLATFORM_LPAR)
 		find_udbg_vterm();
-	else if (naca->serialPortAddr) {
+	else if (physport) {
 		/* Map the uart for udbg. */
-		comport = (void *)__ioremap(naca->serialPortAddr, 16, _PAGE_NO_CACHE);
+		comport = (void *)__ioremap(physport, 16, _PAGE_NO_CACHE);
 		udbg_init_uart(comport, default_speed);
 
 		ppc_md.udbg_putc = udbg_putc;
diff -ruN linus-bk-naca.5/arch/ppc64/kernel/setup.c linus-bk-naca.6/arch/ppc64/kernel/setup.c
--- linus-bk-naca.5/arch/ppc64/kernel/setup.c	2004-12-31 16:24:54.000000000 +1100
+++ linus-bk-naca.6/arch/ppc64/kernel/setup.c	2004-12-31 16:23:30.000000000 +1100
@@ -1154,7 +1154,8 @@
 static struct plat_serial8250_port serial_ports[MAX_LEGACY_SERIAL_PORTS+1];
 static unsigned int old_serial_count;
 
-void __init generic_find_legacy_serial_ports(unsigned int *default_speed)
+void __init generic_find_legacy_serial_ports(u64 *physport,
+		unsigned int *default_speed)
 {
 	struct device_node *np;
 	u32 *sizeprop;
@@ -1172,7 +1173,7 @@
 
 	DBG(" -> generic_find_legacy_serial_port()\n");
 
-	naca->serialPortAddr = 0;
+	*physport = 0;
 	if (default_speed)
 		*default_speed = 0;
 
@@ -1294,7 +1295,7 @@
 				io_base = (io_base << 32) | rangesp[4];
 		}
 		if (io_base != 0) {
-			naca->serialPortAddr = io_base + reg->address;
+			*physport = io_base + reg->address;
 			if (default_speed && spd)
 				*default_speed = *spd;
 		}
diff -ruN linus-bk-naca.5/include/asm-ppc64/naca.h linus-bk-naca.6/include/asm-ppc64/naca.h
--- linus-bk-naca.5/include/asm-ppc64/naca.h	2004-12-10 18:42:14.000000000 +1100
+++ linus-bk-naca.6/include/asm-ppc64/naca.h	2004-12-11 00:03:55.000000000 +1100
@@ -22,7 +22,6 @@
 	u64 debug_switch;		/* Debug print control       0x20 */
 	u64 banner;                     /* Ptr to banner string      0x28 */
 	u64 log;                        /* Ptr to log buffer         0x30 */
-	u64 serialPortAddr;		/* Phy addr of serial port   0x38 */
 };
 
 extern struct naca_struct *naca;

--Signature=_Tue__4_Jan_2005_15_27_05_+1100_iHTpbPF/v2VYEpcD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hsZ4CJfqux9a+8RAgbfAJ9RXPzKkVT4tuL00fmD0nf0RkYtYwCePR6T
Wya16HZyyOI7G1EeU+Ktqw0=
=kPhH
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_27_05_+1100_iHTpbPF/v2VYEpcD--
