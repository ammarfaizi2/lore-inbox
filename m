Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbTC0RJT>; Thu, 27 Mar 2003 12:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTC0RIQ>; Thu, 27 Mar 2003 12:08:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56453
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263308AbTC0RH2>; Thu, 27 Mar 2003 12:07:28 -0500
Date: Thu, 27 Mar 2003 18:24:57 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271824.h2RIOv7B019702@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PC9800 uses different IDE i/o bases for legacy mode devices

(Osamu Tomita)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/include/asm-i386/ide.h linux-2.5.66-ac1/include/asm-i386/ide.h
--- linux-2.5.66-bk3/include/asm-i386/ide.h	2003-03-27 17:13:28.000000000 +0000
+++ linux-2.5.66-ac1/include/asm-i386/ide.h	2003-03-14 01:19:57.000000000 +0000
@@ -26,6 +26,9 @@
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
+#ifdef CONFIG_X86_PC9800
+		case 0x640: return 9;
+#endif
 		case 0x1f0: return 14;
 		case 0x170: return 15;
 		case 0x1e8: return 11;
@@ -40,12 +43,17 @@
 static __inline__ unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
+#ifdef CONFIG_X86_PC9800
+		case 0:
+		case 1:	return 0x640;
+#else
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;
 		case 2: return 0x1e8;
 		case 3: return 0x168;
 		case 4: return 0x1e0;
 		case 5: return 0x160;
+#endif
 		default:
 			return 0;
 	}
@@ -56,13 +64,24 @@
 {
 	unsigned long reg = data_port;
 	int i;
+#ifdef CONFIG_X86_PC9800
+	unsigned long increment = data_port == 0x640 ? 2 : 1;
+#endif
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hw->io_ports[i] = reg;
+#ifdef CONFIG_X86_PC9800
+		reg += increment;
+#else
 		reg += 1;
+#endif
 	}
 	if (ctrl_port) {
 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+#ifdef CONFIG_X86_PC9800
+	} else if (data_port == 0x640) {
+		hw->io_ports[IDE_CONTROL_OFFSET] = 0x74c;
+#endif
 	} else {
 		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
 	}
