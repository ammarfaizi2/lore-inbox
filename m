Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVIZK1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVIZK1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 06:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVIZK1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 06:27:09 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:53080 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750789AbVIZK1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 06:27:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Message-Id;
  b=tlGj5xHR8XJ45BXq1aKmgrLffOVpsEtVCoIf6H+8sBoxsyI/S/QLADWTsNxMShIkd2Ghu1tq7znCzO+ptLRg4Q8tpuKlj3DCEyhO2eHIs6mYCPHN6mQY8jGWW0DIQ4ueDaF6u/wUmDDxd1Zd5PubWAQBeochjrjnNLpOIDsJByQ=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] Enable HPET on VIA8237 southbridge
Date: Mon, 26 Sep 2005 12:31:32 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E48NDDlv4UxFtrM"
Message-Id: <200509261231.32697.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_E48NDDlv4UxFtrM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

if you have that chip on your mainboard and want to play with it's
hpet, this might get you going.

   Karsten

--Boundary-00=_E48NDDlv4UxFtrM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-via8237-hpet-i386"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-via8237-hpet-i386"

Enable HPET on VIA8237 southbridge

Some BIOSs don't enable the hpet on that chip.
The patch enables it before all the other pci devices.

The hpet's hardware address is set to 0xFED00000,
if the VIA8237 has been identified.

This IS DANGEROUS.
I.e. because the hardware address might be assigned
later in the boot process to somthing else.

Tested succesfully on an K8T800/AMD64 Mobo.
One exception: Timer1 says it can do PERIODIC mode,
but this doesn't work here. One shot is ok.

Signed-off-by: Karsten Wiese <annabellesgraden@yahoo.de>


diff -ur linux-2.6.13-RT/arch/i386/kernel/time_hpet.c linux-2.6.13-RT-kw/arch/i386/kernel/time_hpet.c
--- linux-2.6.13-RT/arch/i386/kernel/time_hpet.c	2005-09-19 15:49:17.000000000 +0200
+++ linux-2.6.13-RT-kw/arch/i386/kernel/time_hpet.c	2005-09-24 00:58:37.000000000 +0200
@@ -223,11 +223,74 @@
 	return use_hpet;
 }
 
+#define HPET_HACK_ENABLE_DANGEROUS 1
+
+#ifdef HPET_HACK_ENABLE_DANGEROUS
+union conf_address {
+	struct {
+		u8	reg;
+		u8	func:	3;
+		u8	dev:	5;
+		u8	bus;
+		u8	reserved:7;
+		u8	enable:	1;
+	} bits;
+	u32	dword;
+};
+
+#include <linux/pci_ids.h>
+
+static void is_hpet_via8237(void)
+{
+	union conf_address ca = {
+		.bits.reg = 0,
+		.bits.dev = 17,
+		.bits.enable = 1
+	};
+	union {
+		struct {
+			u8 control;
+			u8 address[3];
+		} hpet;
+		unsigned raw;
+	} hpet;
+	u32 vendor_id, control;
+
+	control = inl(0xcf8);
+	printk("%X\n", control);
+	outl(ca.dword, 0xcf8);
+	vendor_id = inl(0xcfc);
+	if (vendor_id == (PCI_VENDOR_ID_VIA + (PCI_DEVICE_ID_VIA_8237 << 16))) {
+		hpet.raw = 0xFED00000;
+		hpet.hpet.control = 0x80;
+		ca.bits.reg = 0x68;
+		outl(ca.dword, 0xcf8);
+		outl(hpet.raw, 0xcfc);
+		outl(ca.dword, 0xcf8);
+		hpet_address = (inl(0xcfc) & 0xFFFFFF00);
+		printk(KERN_WARNING "time.c: WARNING: Enabled VIA8237 HPET "
+		       "at %#lx.\n", hpet_address);
+	}
+}
+
+#else
+
+static void is_hpet_via8237(void)
+{
+}
+
+#endif
+
+
 int is_hpet_capable(void)
 {
-	if (!boot_hpet_disable && hpet_address)
-		return 1;
-	return 0;
+	if (boot_hpet_disable)
+		return 0;
+
+        if (!hpet_address)
+		is_hpet_via8237();
+
+	return hpet_address;
 }
 
 static int __init hpet_setup(char* str)

--Boundary-00=_E48NDDlv4UxFtrM--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
