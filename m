Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWBHHMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWBHHMD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWBHHMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:12:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15006 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161042AbWBHHLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:32 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] sh: lvalues abuse in arch/sh/boards/renesas/rts7751r2d/io.c
Message-Id: <E1F6jUB-0002iQ-3n@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1135874752 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sh/boards/renesas/rts7751r2d/io.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

63f716b9419420defb3e550a1e5f526c11b2ed2d
diff --git a/arch/sh/boards/renesas/rts7751r2d/io.c b/arch/sh/boards/renesas/rts7751r2d/io.c
index c46f915..123abbb 100644
--- a/arch/sh/boards/renesas/rts7751r2d/io.c
+++ b/arch/sh/boards/renesas/rts7751r2d/io.c
@@ -216,24 +216,26 @@ void rts7751r2d_insb(unsigned long port,
 {
 	volatile __u8 *bp;
 	volatile __u16 *p;
+	unsigned char *s = addr;
 
 	if (CHECK_AX88796L_PORT(port)) {
 		p = (volatile unsigned short *)port88796l(port, 0);
-		while (count--) *((unsigned char *) addr)++ = *p & 0xff;
+		while (count--) *s++ = *p & 0xff;
 	} else if (PXSEG(port))
-		while (count--) *((unsigned char *) addr)++ = *(volatile unsigned char *)port;
+		while (count--) *s++ = *(volatile unsigned char *)port;
 	else if (CHECK_SH7751_PCIIO(port) || shifted_port(port)) {
 		bp = (__u8 *)PCI_IOMAP(port);
-		while (count--) *((volatile unsigned char *) addr)++ = *bp;
+		while (count--) *s++ = *bp;
 	} else {
 		p = (volatile unsigned short *)port2adr(port);
-		while (count--) *((unsigned char *) addr)++ = *p & 0xff;
+		while (count--) *s++ = *p & 0xff;
 	}
 }
 
 void rts7751r2d_insw(unsigned long port, void *addr, unsigned long count)
 {
 	volatile __u16 *p;
+	__u16 *s = addr;
 
 	if (CHECK_AX88796L_PORT(port))
 		p = (volatile unsigned short *)port88796l(port, 1);
@@ -243,7 +245,7 @@ void rts7751r2d_insw(unsigned long port,
 		p = (volatile unsigned short *)PCI_IOMAP(port);
 	else
 		p = (volatile unsigned short *)port2adr(port);
-	while (count--) *((__u16 *) addr)++ = *p;
+	while (count--) *s++ = *p;
 }
 
 void rts7751r2d_insl(unsigned long port, void *addr, unsigned long count)
@@ -252,8 +254,9 @@ void rts7751r2d_insl(unsigned long port,
 		maybebadio(insl, port);
 	else if (CHECK_SH7751_PCIIO(port) || shifted_port(port)) {
 		volatile __u32 *p = (__u32 *)PCI_IOMAP(port);
+		__u32 *s = addr;
 
-		while (count--) *((__u32 *) addr)++ = *p;
+		while (count--) *s++ = *p;
 	} else
 		maybebadio(insl, port);
 }
@@ -262,24 +265,26 @@ void rts7751r2d_outsb(unsigned long port
 {
 	volatile __u8 *bp;
 	volatile __u16 *p;
+	const __u8 *s = addr;
 
 	if (CHECK_AX88796L_PORT(port)) {
 		p = (volatile unsigned short *)port88796l(port, 0);
-		while (count--) *p = *((unsigned char *) addr)++;
+		while (count--) *p = *s++;
 	} else if (PXSEG(port))
-		while (count--) *(volatile unsigned char *)port = *((unsigned char *) addr)++;
+		while (count--) *(volatile unsigned char *)port = *s++;
 	else if (CHECK_SH7751_PCIIO(port) || shifted_port(port)) {
 		bp = (__u8 *)PCI_IOMAP(port);
-		while (count--) *bp = *((volatile unsigned char *) addr)++;
+		while (count--) *bp = *s++;
 	} else {
 		p = (volatile unsigned short *)port2adr(port);
-		while (count--) *p = *((unsigned char *) addr)++;
+		while (count--) *p = *s++;
 	}
 }
 
 void rts7751r2d_outsw(unsigned long port, const void *addr, unsigned long count)
 {
 	volatile __u16 *p;
+	const __u16 *s = addr;
 
 	if (CHECK_AX88796L_PORT(port))
 		p = (volatile unsigned short *)port88796l(port, 1);
@@ -289,7 +294,7 @@ void rts7751r2d_outsw(unsigned long port
 		p = (volatile unsigned short *)PCI_IOMAP(port);
 	else
 		p = (volatile unsigned short *)port2adr(port);
-	while (count--) *p = *((__u16 *) addr)++;
+	while (count--) *p = *s++;
 }
 
 void rts7751r2d_outsl(unsigned long port, const void *addr, unsigned long count)
@@ -298,8 +303,9 @@ void rts7751r2d_outsl(unsigned long port
 		maybebadio(outsl, port);
 	else if (CHECK_SH7751_PCIIO(port) || shifted_port(port)) {
 		volatile __u32 *p = (__u32 *)PCI_IOMAP(port);
+		const __u32 *s = addr;
 
-		while (count--) *p = *((__u32 *) addr)++;
+		while (count--) *p = *s++;
 	} else
 		maybebadio(outsl, port);
 }
-- 
0.99.9.GIT

