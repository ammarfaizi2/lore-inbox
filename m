Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWJXIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWJXIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWJXINq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:46 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:11720 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932433AbWJXINN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:13 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Ben Nizette <ben@mallochdigital.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 5/8] AVR32: add io{read,write}{8,16,32}{be,} support
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:43 +0200
Message-Id: <1161677566524-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775661978-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com> <11616775661390-git-send-email-hskinnemoen@atmel.com> <11616775661978-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Nizette <ben@mallochdigital.com>

A number of new drivers require io{read,write}{8,16,32}{be,} family of io
operations.  These are provided for the AVR32 by this patch in the form of
a series of macros.

Access to the (memory mapped) io space through these macros is defined to
be little endian only as little endian devices (such as PCI) are the main
consumer of IO access.  If high speed access is required,
io{read,write}{16,32}be macros are supplied to perform native big endian
access to this io space.

Signed-off-by: Ben Nizette <ben@mallochdigital.com>
Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/io.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/asm-avr32/io.h b/include/asm-avr32/io.h
index 2fc8f11..eec4750 100644
--- a/include/asm-avr32/io.h
+++ b/include/asm-avr32/io.h
@@ -76,6 +76,39 @@ #define readsb(p, d, l)		__raw_readsb((u
 #define readsw(p, d, l)		__raw_readsw((unsigned int)p, d, l)
 #define readsl(p, d, l)		__raw_readsl((unsigned int)p, d, l)
 
+
+/*
+ * io{read,write}{8,16,32} macros in both le (for PCI style consumers) and native be
+ */
+#ifndef ioread8
+
+#define ioread8(p)	({ unsigned int __v = __raw_readb(p); __v; })
+
+#define ioread16(p)	({ unsigned int __v = le16_to_cpu(__raw_readw(p)); __v; })
+#define ioread16be(p)	({ unsigned int __v = be16_to_cpu(__raw_readw(p)); __v; })
+
+#define ioread32(p)	({ unsigned int __v = le32_to_cpu(__raw_readl(p)); __v; })
+#define ioread32be(p)	({ unsigned int __v = be32_to_cpu(__raw_readl(p)); __v; })
+
+#define iowrite8(v,p)	__raw_writeb(v, p)
+
+#define iowrite16(v,p)	__raw_writew(cpu_to_le16(v), p)
+#define iowrite16be(v,p)	__raw_writew(cpu_to_be16(v), p)
+
+#define iowrite32(v,p)	__raw_writel(cpu_to_le32(v), p)
+#define iowrite32be(v,p)	__raw_writel(cpu_to_be32(v), p)
+
+#define ioread8_rep(p,d,c)	__raw_readsb(p,d,c)
+#define ioread16_rep(p,d,c)	__raw_readsw(p,d,c)
+#define ioread32_rep(p,d,c)	__raw_readsl(p,d,c)
+
+#define iowrite8_rep(p,s,c)	__raw_writesb(p,s,c)
+#define iowrite16_rep(p,s,c)	__raw_writesw(p,s,c)
+#define iowrite32_rep(p,s,c)	__raw_writesl(p,s,c)
+
+#endif
+
+
 /*
  * These two are only here because ALSA _thinks_ it needs them...
  */
-- 
1.4.1.1

