Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280828AbRKYLmH>; Sun, 25 Nov 2001 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKYLl7>; Sun, 25 Nov 2001 06:41:59 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:56461 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280821AbRKYLlv>; Sun, 25 Nov 2001 06:41:51 -0500
Message-ID: <3C00E763.DC6C65AB@t-online.de>
Date: Sun, 25 Nov 2001 13:43:15 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-greased-turkey i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, andre@linux-ide.org, dhinds@zen.stanford.edu,
        marcelo@conectiva.com.br, torvalds@transmeta.com
CC: fred@pont.net
Subject: patch-2.4.15: Fix CompactFlash+PCMCIA+PCI system freeze (Resend)
Content-Type: multipart/mixed;
 boundary="------------15DDDDD021E5279DDB589116"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------15DDDDD021E5279DDB589116
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

this patch is nedded to prevent system freeze on
inserting a CompactFlash (or any other ATA) card
into a PCMCIA-PCI adapter card !

The IDE maintainer (Andre) agreed with the patch but didn't submit
since the August thread .

So he must be bypassed !!!

Thanks David for integrating the minimal one-liner patch (i.e. non-freeze)
to pcmcia-cs-3.1.30. For proper working we must tell the ide subsystem
it is OK to share IRQ (which is mandatory for PCI), this takes some
trivial lines to fix the API in the ide subsystem (about "chipset"s).

Regards, Gunther



diff -ur linux-2.4.15.orig/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
--- linux-2.4.15.orig/drivers/ide/ide-cs.c      Sun Sep 30 21:26:05 2001
+++ linux/drivers/ide/ide-cs.c  Sun Nov 25 13:11:36 2001
@@ -42,6 +42,7 @@
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -226,6 +227,16 @@
 #define CFG_CHECK(fn, args...) \
 if (CardServices(fn, args) != 0) goto next_entry
 
+int idecs_register (int io_base, int ctl_base, int irq)
+{
+        hw_regs_t hw;
+        ide_init_hwif_ports(&hw, (ide_ioreg_t) io_base, (ide_ioreg_t) ctl_base, NULL);
+        hw.irq = irq;
+        hw.chipset = ide_pci; // this enables IRQ sharing w/ PCI irqs
+        return ide_register_hw(&hw, NULL);
+}
+
+
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
@@ -327,12 +338,16 @@
     if (link->io.NumPorts2)
        release_region(link->io.BasePort2, link->io.NumPorts2);
 
+    /* disable drive interrupts during IDE probe */
+    if(ctl_base)
+       outb(0x02, ctl_base);
+
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
-       hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
+       hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
        if (hd >= 0) break;
        if (link->io.NumPorts1 == 0x20) {
-           hd = ide_register(io_base+0x10, ctl_base+0x10,
+           hd = idecs_register(io_base+0x10, ctl_base+0x10,
                              link->irq.AssignedIRQ);
            if (hd >= 0) {
                io_base += 0x10; ctl_base += 0x10;
Only in linux/drivers/ide: ide-cs.c-2415
diff -ur linux-2.4.15.orig/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.4.15.orig/drivers/ide/ide.c Thu Oct 25 22:58:35 2001
+++ linux/drivers/ide/ide.c     Sun Nov 25 13:02:34 2001
@@ -2293,6 +2293,7 @@
        memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
        hwif->irq = hw->irq;
        hwif->noprobe = 0;
+       hwif->chipset = hw->chipset;
 
        if (!initializing) {
                ide_probe_module();
diff -ur linux-2.4.15.orig/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.4.15.orig/include/linux/ide.h       Thu Nov 22 20:48:07 2001
+++ linux/include/linux/ide.h   Sun Nov 25 13:05:57 2001
@@ -223,6 +223,23 @@
 #endif
 
 /*
+ * hwif_chipset_t is used to keep track of the specific hardware
+ * chipset used by each IDE interface, if known.
+ */
+typedef enum {  ide_unknown,    ide_generic,    ide_pci,
+                ide_cmd640,     ide_dtc2278,    ide_ali14xx,
+                ide_qd65xx,     ide_umc8672,    ide_ht6560b,
+                ide_pdc4030,    ide_rz1000,     ide_trm290,
+                ide_cmd646,     ide_cy82c693,   ide_4drives,
+                ide_pmac,       ide_etrax100
+} hwif_chipset_t;
+
+#define IDE_CHIPSET_PCI_MASK    \
+    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
+#define IDE_CHIPSET_IS_PCI(c)   ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
+
+
+/*
  * Structure to hold all information about the location of this port
  */
 typedef struct hw_regs_s {
@@ -231,6 +248,7 @@
        int             dma;                    /* our dma entry */
        ide_ack_intr_t  *ack_intr;              /* acknowledge interrupt */
        void            *priv;                  /* interface specific data */
+       hwif_chipset_t  chipset;
 } hw_regs_t;
 
 /*
@@ -439,22 +457,6 @@
  * ide soft-power support
  */
 typedef int (ide_busproc_t) (struct hwif_s *, int);
-
-/*
- * hwif_chipset_t is used to keep track of the specific hardware
- * chipset used by each IDE interface, if known.
- */
-typedef enum { ide_unknown,    ide_generic,    ide_pci,
-               ide_cmd640,     ide_dtc2278,    ide_ali14xx,
-               ide_qd65xx,     ide_umc8672,    ide_ht6560b,
-               ide_pdc4030,    ide_rz1000,     ide_trm290,
-               ide_cmd646,     ide_cy82c693,   ide_4drives,
-               ide_pmac,       ide_etrax100
-} hwif_chipset_t;
-
-#define IDE_CHIPSET_PCI_MASK   \
-    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
-#define IDE_CHIPSET_IS_PCI(c)  ((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 typedef struct ide_pci_devid_s {
--------------15DDDDD021E5279DDB589116
Content-Type: application/octet-stream;
 name="gmdiff-lx2415-compactflash+pcmcia+PCI"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-lx2415-compactflash+pcmcia+PCI"

ZGlmZiAtdXIgbGludXgtMi40LjE1Lm9yaWcvZHJpdmVycy9pZGUvaWRlLWNzLmMgbGludXgv
ZHJpdmVycy9pZGUvaWRlLWNzLmMKLS0tIGxpbnV4LTIuNC4xNS5vcmlnL2RyaXZlcnMvaWRl
L2lkZS1jcy5jCVN1biBTZXAgMzAgMjE6MjY6MDUgMjAwMQorKysgbGludXgvZHJpdmVycy9p
ZGUvaWRlLWNzLmMJU3VuIE5vdiAyNSAxMzoxMTozNiAyMDAxCkBAIC00Miw2ICs0Miw3IEBA
CiAjaW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+CiAjaW5jbHVkZSA8bGludXgvaGRyZWcuaD4K
ICNpbmNsdWRlIDxsaW51eC9tYWpvci5oPgorI2luY2x1ZGUgPGxpbnV4L2lkZS5oPgogCiAj
aW5jbHVkZSA8YXNtL2lvLmg+CiAjaW5jbHVkZSA8YXNtL3N5c3RlbS5oPgpAQCAtMjI2LDYg
KzIyNywxNiBAQAogI2RlZmluZSBDRkdfQ0hFQ0soZm4sIGFyZ3MuLi4pIFwKIGlmIChDYXJk
U2VydmljZXMoZm4sIGFyZ3MpICE9IDApIGdvdG8gbmV4dF9lbnRyeQogCitpbnQgaWRlY3Nf
cmVnaXN0ZXIgKGludCBpb19iYXNlLCBpbnQgY3RsX2Jhc2UsIGludCBpcnEpCit7CisgICAg
ICAgIGh3X3JlZ3NfdCBodzsKKyAgICAgICAgaWRlX2luaXRfaHdpZl9wb3J0cygmaHcsIChp
ZGVfaW9yZWdfdCkgaW9fYmFzZSwgKGlkZV9pb3JlZ190KSBjdGxfYmFzZSwgTlVMTCk7Cisg
ICAgICAgIGh3LmlycSA9IGlycTsKKyAgICAgICAgaHcuY2hpcHNldCA9IGlkZV9wY2k7IC8v
IHRoaXMgZW5hYmxlcyBJUlEgc2hhcmluZyB3LyBQQ0kgaXJxcworICAgICAgICByZXR1cm4g
aWRlX3JlZ2lzdGVyX2h3KCZodywgTlVMTCk7Cit9CisKKwogdm9pZCBpZGVfY29uZmlnKGRl
dl9saW5rX3QgKmxpbmspCiB7CiAgICAgY2xpZW50X2hhbmRsZV90IGhhbmRsZSA9IGxpbmst
PmhhbmRsZTsKQEAgLTMyNywxMiArMzM4LDE2IEBACiAgICAgaWYgKGxpbmstPmlvLk51bVBv
cnRzMikKIAlyZWxlYXNlX3JlZ2lvbihsaW5rLT5pby5CYXNlUG9ydDIsIGxpbmstPmlvLk51
bVBvcnRzMik7CiAKKyAgICAvKiBkaXNhYmxlIGRyaXZlIGludGVycnVwdHMgZHVyaW5nIElE
RSBwcm9iZSAqLworICAgIGlmKGN0bF9iYXNlKQorICAgIAlvdXRiKDB4MDIsIGN0bF9iYXNl
KTsKKwogICAgIC8qIHJldHJ5IHJlZ2lzdHJhdGlvbiBpbiBjYXNlIGRldmljZSBpcyBzdGls
bCBzcGlubmluZyB1cCAqLwogICAgIGZvciAoaSA9IDA7IGkgPCAxMDsgaSsrKSB7Ci0JaGQg
PSBpZGVfcmVnaXN0ZXIoaW9fYmFzZSwgY3RsX2Jhc2UsIGxpbmstPmlycS5Bc3NpZ25lZElS
USk7CisJaGQgPSBpZGVjc19yZWdpc3Rlcihpb19iYXNlLCBjdGxfYmFzZSwgbGluay0+aXJx
LkFzc2lnbmVkSVJRKTsKIAlpZiAoaGQgPj0gMCkgYnJlYWs7CiAJaWYgKGxpbmstPmlvLk51
bVBvcnRzMSA9PSAweDIwKSB7Ci0JICAgIGhkID0gaWRlX3JlZ2lzdGVyKGlvX2Jhc2UrMHgx
MCwgY3RsX2Jhc2UrMHgxMCwKKwkgICAgaGQgPSBpZGVjc19yZWdpc3Rlcihpb19iYXNlKzB4
MTAsIGN0bF9iYXNlKzB4MTAsCiAJCQkgICAgICBsaW5rLT5pcnEuQXNzaWduZWRJUlEpOwog
CSAgICBpZiAoaGQgPj0gMCkgewogCQlpb19iYXNlICs9IDB4MTA7IGN0bF9iYXNlICs9IDB4
MTA7Ck9ubHkgaW4gbGludXgvZHJpdmVycy9pZGU6IGlkZS1jcy5jLTI0MTUKZGlmZiAtdXIg
bGludXgtMi40LjE1Lm9yaWcvZHJpdmVycy9pZGUvaWRlLmMgbGludXgvZHJpdmVycy9pZGUv
aWRlLmMKLS0tIGxpbnV4LTIuNC4xNS5vcmlnL2RyaXZlcnMvaWRlL2lkZS5jCVRodSBPY3Qg
MjUgMjI6NTg6MzUgMjAwMQorKysgbGludXgvZHJpdmVycy9pZGUvaWRlLmMJU3VuIE5vdiAy
NSAxMzowMjozNCAyMDAxCkBAIC0yMjkzLDYgKzIyOTMsNyBAQAogCW1lbWNweShod2lmLT5p
b19wb3J0cywgaHdpZi0+aHcuaW9fcG9ydHMsIHNpemVvZihod2lmLT5ody5pb19wb3J0cykp
OwogCWh3aWYtPmlycSA9IGh3LT5pcnE7CiAJaHdpZi0+bm9wcm9iZSA9IDA7CisJaHdpZi0+
Y2hpcHNldCA9IGh3LT5jaGlwc2V0OwogCiAJaWYgKCFpbml0aWFsaXppbmcpIHsKIAkJaWRl
X3Byb2JlX21vZHVsZSgpOwpkaWZmIC11ciBsaW51eC0yLjQuMTUub3JpZy9pbmNsdWRlL2xp
bnV4L2lkZS5oIGxpbnV4L2luY2x1ZGUvbGludXgvaWRlLmgKLS0tIGxpbnV4LTIuNC4xNS5v
cmlnL2luY2x1ZGUvbGludXgvaWRlLmgJVGh1IE5vdiAyMiAyMDo0ODowNyAyMDAxCisrKyBs
aW51eC9pbmNsdWRlL2xpbnV4L2lkZS5oCVN1biBOb3YgMjUgMTM6MDU6NTcgMjAwMQpAQCAt
MjIzLDYgKzIyMywyMyBAQAogI2VuZGlmCiAKIC8qCisgKiBod2lmX2NoaXBzZXRfdCBpcyB1
c2VkIHRvIGtlZXAgdHJhY2sgb2YgdGhlIHNwZWNpZmljIGhhcmR3YXJlCisgKiBjaGlwc2V0
IHVzZWQgYnkgZWFjaCBJREUgaW50ZXJmYWNlLCBpZiBrbm93bi4KKyAqLwordHlwZWRlZiBl
bnVtIHsgIGlkZV91bmtub3duLCAgICBpZGVfZ2VuZXJpYywgICAgaWRlX3BjaSwKKyAgICAg
ICAgICAgICAgICBpZGVfY21kNjQwLCAgICAgaWRlX2R0YzIyNzgsICAgIGlkZV9hbGkxNHh4
LAorICAgICAgICAgICAgICAgIGlkZV9xZDY1eHgsICAgICBpZGVfdW1jODY3MiwgICAgaWRl
X2h0NjU2MGIsCisgICAgICAgICAgICAgICAgaWRlX3BkYzQwMzAsICAgIGlkZV9yejEwMDAs
ICAgICBpZGVfdHJtMjkwLAorICAgICAgICAgICAgICAgIGlkZV9jbWQ2NDYsICAgICBpZGVf
Y3k4MmM2OTMsICAgaWRlXzRkcml2ZXMsCisgICAgICAgICAgICAgICAgaWRlX3BtYWMsICAg
ICAgIGlkZV9ldHJheDEwMAorfSBod2lmX2NoaXBzZXRfdDsKKworI2RlZmluZSBJREVfQ0hJ
UFNFVF9QQ0lfTUFTSyAgICBcCisgICAgKCgxPDxpZGVfcGNpKXwoMTw8aWRlX2NtZDY0Nil8
KDE8PGlkZV9hbGkxNHh4KSkKKyNkZWZpbmUgSURFX0NISVBTRVRfSVNfUENJKGMpICAgKChJ
REVfQ0hJUFNFVF9QQ0lfTUFTSyA+PiAoYykpICYgMSkKKworCisvKgogICogU3RydWN0dXJl
IHRvIGhvbGQgYWxsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBsb2NhdGlvbiBvZiB0aGlzIHBv
cnQKICAqLwogdHlwZWRlZiBzdHJ1Y3QgaHdfcmVnc19zIHsKQEAgLTIzMSw2ICsyNDgsNyBA
QAogCWludAkJZG1hOwkJCS8qIG91ciBkbWEgZW50cnkgKi8KIAlpZGVfYWNrX2ludHJfdAkq
YWNrX2ludHI7CQkvKiBhY2tub3dsZWRnZSBpbnRlcnJ1cHQgKi8KIAl2b2lkCQkqcHJpdjsJ
CQkvKiBpbnRlcmZhY2Ugc3BlY2lmaWMgZGF0YSAqLworCWh3aWZfY2hpcHNldF90ICBjaGlw
c2V0OwogfSBod19yZWdzX3Q7CiAKIC8qCkBAIC00MzksMjIgKzQ1Nyw2IEBACiAgKiBpZGUg
c29mdC1wb3dlciBzdXBwb3J0CiAgKi8KIHR5cGVkZWYgaW50IChpZGVfYnVzcHJvY190KSAo
c3RydWN0IGh3aWZfcyAqLCBpbnQpOwotCi0vKgotICogaHdpZl9jaGlwc2V0X3QgaXMgdXNl
ZCB0byBrZWVwIHRyYWNrIG9mIHRoZSBzcGVjaWZpYyBoYXJkd2FyZQotICogY2hpcHNldCB1
c2VkIGJ5IGVhY2ggSURFIGludGVyZmFjZSwgaWYga25vd24uCi0gKi8KLXR5cGVkZWYgZW51
bSB7CWlkZV91bmtub3duLAlpZGVfZ2VuZXJpYywJaWRlX3BjaSwKLQkJaWRlX2NtZDY0MCwJ
aWRlX2R0YzIyNzgsCWlkZV9hbGkxNHh4LAotCQlpZGVfcWQ2NXh4LAlpZGVfdW1jODY3MiwJ
aWRlX2h0NjU2MGIsCi0JCWlkZV9wZGM0MDMwLAlpZGVfcnoxMDAwLAlpZGVfdHJtMjkwLAot
CQlpZGVfY21kNjQ2LAlpZGVfY3k4MmM2OTMsCWlkZV80ZHJpdmVzLAotCQlpZGVfcG1hYywg
ICAgICAgaWRlX2V0cmF4MTAwCi19IGh3aWZfY2hpcHNldF90OwotCi0jZGVmaW5lIElERV9D
SElQU0VUX1BDSV9NQVNLCVwKLSAgICAoKDE8PGlkZV9wY2kpfCgxPDxpZGVfY21kNjQ2KXwo
MTw8aWRlX2FsaTE0eHgpKQotI2RlZmluZSBJREVfQ0hJUFNFVF9JU19QQ0koYykJKChJREVf
Q0hJUFNFVF9QQ0lfTUFTSyA+PiAoYykpICYgMSkKIAogI2lmZGVmIENPTkZJR19CTEtfREVW
X0lERVBDSQogdHlwZWRlZiBzdHJ1Y3QgaWRlX3BjaV9kZXZpZF9zIHsK
--------------15DDDDD021E5279DDB589116--

