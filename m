Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTIRNsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTIRNsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:48:07 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:55169 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261293AbTIRNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:48:00 -0400
Message-Id: <200309181347.h8IDlnjH264650@d12relay02.megacenter.de.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: IA32 - 27 New warnings
To: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2003 15:42:29 +0200
References: <x0sQ.2ZO.5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry wrote:

> drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not used
> drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined but not used
> drivers/media/video/zoran_card.c:148: warning: `zr36067_pci_tbl' defined but not used
> drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined but not used
> drivers/net/dgrs.c:123: warning: `dgrs_pci_tbl' defined but not used
> drivers/net/hp100.c:287: warning: `hp100_pci_tbl' defined but not used
> drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not used
> drivers/scsi/aha152x.c:397: warning: `id_table' defined but not used
> drivers/scsi/dtc.c:187: warning: `dtc_setup' defined but not used
> drivers/scsi/g_NCR5380.c:925: warning: `id_table' defined but not used
> drivers/scsi/gdth.c:868: warning: `gdthtable' defined but not used
> drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not used
> sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
> sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used

Does this patch help?

        Arnd <><

===== include/linux/module.h 1.68 vs edited =====
--- 1.68/include/linux/module.h Fri Jul  4 00:00:09 2003
+++ edited/include/linux/module.h       Thu Sep 18 15:26:23 2003
@@ -59,12 +59,12 @@
 #define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)                                   \
-static const char __module_cat(name,__LINE__)[]                                  \
-  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
+static const char __module_cat(name,__LINE__)[] __attribute_used__       \
+  __attribute__((section(".modinfo"))) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)                       \
 extern const struct gtype##_id __mod_##gtype##_table           \
-  __attribute__ ((unused, alias(__stringify(name))))
+  __attribute__ ((alias(__stringify(name))))
 
 #define THIS_MODULE (&__this_module)
 
@@ -142,7 +142,8 @@
 #define __CRC_SYMBOL(sym, sec)                                 \
        extern void *__crc_##sym __attribute__((weak));         \
        static const unsigned long __kcrctab_##sym              \
-       __attribute__((section("__kcrctab" sec), unused))       \
+       __attribute_used__                                      \
+       __attribute__((section("__kcrctab" sec)))               \
        = (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)
@@ -155,7 +156,8 @@
        __attribute__((section("__ksymtab_strings")))           \
        = MODULE_SYMBOL_PREFIX #sym;                            \
        static const struct kernel_symbol __ksymtab_##sym       \
-       __attribute__((section("__ksymtab" sec), unused))       \
+       __attribute_used__                                      \
+       __attribute__((section("__ksymtab" sec)))               \
        = { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL(sym)                                     \
