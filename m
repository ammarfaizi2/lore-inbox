Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTDIFeD (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTDIFeD (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:34:03 -0400
Received: from [207.188.30.29] ([207.188.30.29]:4481 "EHLO mpenc1.prognet.com")
	by vger.kernel.org with ESMTP id S262763AbTDIFeC (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 01:34:02 -0400
Date: Tue, 8 Apr 2003 22:45:36 -0700
From: Tom Marshall <tommy@home.tig-grr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 broken for non-pci
Message-ID: <20030409054536.GA9982@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am not subscribed.  Please cc: me on responses]

2.4.21-pre7 seems to have introduced a bug in non-pci machines.  If pci is
not enabled, linkage is broken with unresolved symbol broken_440gx_bios. 

Simple fix:

$ diff -u /usr/src/linux-2.4.21-pre7/arch/i386/kernel/dmi_scan.c arch/i386/kernel/dmi_scan.c 
--- /usr/src/linux-2.4.21-pre7/arch/i386/kernel/dmi_scan.c      2003-04-05 16:43:31.000000000 -0800
+++ arch/i386/kernel/dmi_scan.c 2003-04-05 18:26:31.000000000 -0800
@@ -413,9 +413,13 @@
  * On many (all we have checked) of these boxes the $PIRQ table is wrong.
  * The MP1.4 table is right however and so SMP kernels tend to work. 
  */
- 
+
+#ifdef CONFIG_X86_IO_APIC
 extern int skip_ioapic_setup;
+#endif
+#ifdef CONFIG_PCI
 extern int broken_440gx_bios;
+#endif
 extern unsigned int pci_probe;
 static __init int broken_pirq(struct dmi_blacklist *d)
 {
@@ -427,8 +431,10 @@
 #ifdef CONFIG_X86_IO_APIC
        skip_ioapic_setup = 0;
 #endif
+#ifdef CONFIG_PCI
        broken_440gx_bios = 1;
        pci_probe |= PCI_BIOS_IRQ_SCAN;
+#endif
        
        return 0;
 }
