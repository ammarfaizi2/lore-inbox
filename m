Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315441AbSEGN0q>; Tue, 7 May 2002 09:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSEGN0p>; Tue, 7 May 2002 09:26:45 -0400
Received: from jagor.srce.hr ([161.53.2.130]:54215 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S315441AbSEGN0o>;
	Tue, 7 May 2002 09:26:44 -0400
Message-Id: <200205071326.g47DQHqD004688@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: linux-kernel@vger.kernel.org
Subject: VIA KL/KM133 patch and 2.5 kernels
Date: Tue, 7 May 2002 15:26:36 +0200
X-Mailer: KMail [version 1.3.1]
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I wonder why Andre Pang's patch to fix screen corruption on systems using VIA 
KM133 or KL133 chipset motherboards hasn't been integrated in 2.5 series 
kernels yet, neither in the newest 2.5.14. Note that it _has been_ merged in 
2.4.19pre8 or 7. Why?

Andre's post on this mailing-list follows:
_____

[RFC][PATCH] Summary of KL133/KM133 problems w/2.4.18 (screen corruption/MWQ)
Date: Mon, 1 Apr 2002 17:09:26 +1000
From: Andre Pang <ozone@algorithm.com.au>
 To: Steven Walter <srwalter@yahoo.com>, Danijel Schiavuzzi 
<dschiavu@public.srce.hr>, Tom Brehm <BrehmTomB@aol.com>, Tom Eastep 
<teastep@shorewall.net>, Bill Hammock <xcp@whisper.jaggnet.org>, Berend De 
Schouwer <bds@jhb.ucs.co.za>, Denis Vlasenko 
<vda@port.imtp.ilyichevsk.odessa.ua>, Petr Vandrovec <VANDROVE@vc.cvut.cz>, 
linux-kernel@vger.kernel.org

Hi all,

People with KL133/KM133 motherboards who use the integrated
on-board video see major video corruption problems with 2.4.18.

This is because of the MWQ patch[1] which was submitted for
2.4.18.  The patch below fixes the video corruption by not
clearing bit 5, but _only_ on the K[LM]133 motherboards.  The
K[LM]133 northbridge is detected by the revision ID of the
northbridge chipset.  It thus does not affect people who use the
same VT836[35] northbridge which is present on other
motherboards, such as the KT133.

I think the patch is clean and conservative enough to go into the
production kernels.  Without the patch, the KL133 is completely
unusable in text mode and suffers major video corruption in
graphics mode; it really needs to be fixed.  Other motherboards
are completely unaffected.

Note that this is exactly what the VIA patches for Windows do:
the VIA 4in1 drivers normally clear bits 5, 6 and 7 of register
55, but they do not clear bit 5 if the motherboard is a K[LM]133.
This occurs on Windows 98 and Windows XP, and indicates to me
that what this patch does should be the correct behaviour.

Please test the patch if you have a VIA chipset at all; you
should notice no change unless you have a K[LM]133, in which case
the screen should be readable again ;).  It's against 2.4.18.

If all goes well, I'll submit it to Alan/Marcelo/Dave.

1. http://marc.theaimsgroup.com/?l=linux-kernel&m=100772126208656&w=2

--- linux-2.4.18/arch/i386/kernel/pci-pc.c      Sat Mar 30 03:14:59 2002
+++ linux-2.4.18-rx55-fix/arch/i386/kernel/pci-pc.c     Sun Mar 31 16:08:45 
2002
@@ -1110,27 +1110,48 @@
 
 /*
  * Addresses issues with problems in the memory write queue timer in
- * certain VIA Northbridges.  This bugfix is per VIA's specifications.
- *
+ * certain VIA Northbridges.  This bugfix is per VIA's specifications,
+ * except for the KL133/KM133: clearing bit 5 on those Northbridges seems
+ * to trigger a bug in its integrated ProSavage video card, which
+ * causes screen corruption.  We only clear bits 6 and 7 for that chipset,
+ * until VIA can provide us with definitive information on why screen
+ * corruption occurs, and what exactly those bits do.
+ * 
  * VIA 8363,8622,8361 Northbridges:
  *  - bits  5, 6, 7 at offset 0x55 need to be turned off
  * VIA 8367 (KT266x) Northbridges:
  *  - bits  5, 6, 7 at offset 0x95 need to be turned off
+ * VIA 8363 rev 0x81/0x84 (KL133/KM133) Northbridges:
+ *  - bits     6, 7 at offset 0x55 need to be turned off
  */
+
+#define VIA_8363_KL133_REVISION_ID 0x81
+#define VIA_8363_KM133_REVISION_ID 0x84
+
 static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
 {
        u8 v;
+       u8 revision;
        int where = 0x55;
+       int mask = 0x1f; /* clear bits 5, 6, 7 by default */
 
+       pci_read_config_byte(d, PCI_REVISION_ID, &revision);
+       
        if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
                where = 0x95; /* the memory write queue timer register is 
-                                different for the kt266x's: 0x95 not 0x55 */
+                                different for the KT266x's: 0x95 not 0x55 */
+       } else if (d->device == PCI_DEVICE_ID_VIA_8363_0 &&
+                  (revision == VIA_8363_KL133_REVISION_ID || 
+                   revision == VIA_8363_KM133_REVISION_ID)) {
+               mask = 0x3f; /* clear only bits 6 and 7; clearing bit 5
+                               causes screen corruption on the KL133/KM133 */
        }
 
        pci_read_config_byte(d, where, &v);
-       if (v & 0xe0) {
-               printk("Disabling VIA memory write queue: [%02x] 
%02x->%02x\n", where, v, v & 0x1f);
-               v &= 0x1f; /* clear bits 5, 6, 7 */
+       if (v & ~mask) {
+               printk("Disabling VIA memory write queue (PCI ID %04x, rev 
%02x): [%02x] %02x & %02x -> %02x\n", \
+                       d->device, revision, where, v, mask, v & mask);
+               v &= mask;
                pci_write_config_byte(d, where, v);
        }
 }


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
___

-- 
Danijel Schiavuzzi
