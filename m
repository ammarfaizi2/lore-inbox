Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUGUJNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUGUJNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUGUJNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 05:13:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:51118 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266476AbUGUJNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 05:13:30 -0400
Date: Wed, 21 Jul 2004 11:12:49 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>
Subject: reserve legacy io regions on powermac
Message-ID: <20040721091249.GA1336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton pointed this out.

ppc32 can boot one single binary on prep, chrp and pmac boards.
pmac has no legacy io, probing for PC style legacy hardware leads to a
hard crash.
Several patches exist to prevent serial, floppy, ps2, parport and other
drivers from probing these io ports.
I think the simplest fix for 2.6 is a request_region of the problematic
areas.
PCMCIA is still missing.
I found that partport_pc.c pokes at varios ports, without claiming the
ports first. Should this be fixed?
smsc_check(), winbond_check(), winbond_check2()


If this approach is acceptable, ppc64 needs something similar.
Maybe we can put that into generic code, hidden inside CONFIG_PPC_PMAC?


--- linux-2.6.8-rc2/arch/ppc/platforms/pmac_pci.c	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.8-rc2-legacy/arch/ppc/platforms/pmac_pci.c	2004-07-21 10:46:50.000000000 +0200
@@ -883,11 +883,59 @@ pcibios_fixup_OF_interrupts(void)
 	}
 }
 
+#define I8042_DATA_REG 0x60UL
+#define I8250_2_DATA_REG 0x2e0UL
+#define I8250_3_DATA_REG 0x3e0UL
+
+#define PARPORT_278_DATA_REG 0x278UL
+#define PARPORT_371_DATA_REG 0x371UL
+#define PARPORT_378_DATA_REG 0x378UL
+#define PARPORT_3BC_DATA_REG 0x3bcUL
+#define PARPORT_678_DATA_REG 0x678UL
+#define PARPORT_778_DATA_REG 0x778UL
+#define PARPORT_7BC_DATA_REG 0x7bcUL
+
+#define ISAPNP_WRITE_213_DATA_REG 0x213UL
+#define ISAPNP_WRITE_233_DATA_REG 0x233UL
+#define ISAPNP_WRITE_253_DATA_REG 0x253UL
+#define ISAPNP_WRITE_273_DATA_REG 0x273UL
+#define ISAPNP_WRITE_393_DATA_REG 0x393UL
+#define ISAPNP_WRITE_3B3_DATA_REG 0x3b3UL
+#define ISAPNP_WRITE_3D3_DATA_REG 0x3d3UL
+#define ISAPNP_WRITE_3F3_DATA_REG 0x3f3UL
+#define ISAPNP_WRITE_A19_DATA_REG 0xa19UL
+
+static void __init
+pmac_request_regions(void)
+{
+	printk("%s(%u)\n",__FUNCTION__,__LINE__);
+	request_region(I8042_DATA_REG, 16, "reserved (no i8042)");
+	request_region(I8250_2_DATA_REG, 32, "reserved (no i8250)");
+	request_region(I8250_3_DATA_REG, 32, "reserved (no i8250)");
+	request_region(PARPORT_278_DATA_REG, 8, "reserved (no parport");
+	request_region(PARPORT_371_DATA_REG, 7, "reserved (no parport");
+	request_region(PARPORT_378_DATA_REG, 8, "reserved (no parport");
+	request_region(PARPORT_3BC_DATA_REG, 8, "reserved (no parport");
+	request_region(PARPORT_678_DATA_REG, 8, "reserved (no parport");
+	request_region(PARPORT_778_DATA_REG, 8, "reserved (no parport");
+	request_region(PARPORT_7BC_DATA_REG, 8, "reserved (no parport");
+	request_region(ISAPNP_WRITE_A19_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_213_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_233_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_253_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_273_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_393_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_3B3_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_3D3_DATA_REG, 1, "reserved (no isa-pnp)");
+	request_region(ISAPNP_WRITE_3F3_DATA_REG, 1, "reserved (no isa-pnp)");
+}
+
 void __init
 pmac_pcibios_fixup(void)
 {
 	/* Fixup interrupts according to OF tree */
 	pcibios_fixup_OF_interrupts();
+	pmac_request_regions();
 }
 
 int __pmac

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
