Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUIAGKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUIAGKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIAGKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:10:35 -0400
Received: from florence.buici.com ([206.124.142.26]:19933 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S268683AbUIAGI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:08:59 -0400
Date: Tue, 31 Aug 2004 23:08:58 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: [wee PATCH] add SMC91x ethernet for LPD7A40X
Message-ID: <20040901060858.GA3171@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this patch three weeks ago to linux-net without any interest.
It adds the support necessary to get the SMC91x ethernet controller to
operate with the Logic Product Development LH7a40x implementations.

I'd really appreciate it if this got into the kernel.


PATCH FOLLOWS

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 20:36:21-07:00 elf@florence.buici.com 
#   Small patch that adds support for the Logic Product Development variant
#   of the smc91x implementation.  The SMC_IOBARRIER is necessary to work-around a
#   peculiarity of the memory controller that interfaces the network controller to
#   the bus.
# 
# drivers/net/smc91x.h
#   2004/08/15 20:34:32-07:00 elf@florence.buici.com +43 -0
#   Small patch that adds support for the Logic Product Development variant
#   of the smc91x implementation.  The SMC_IOBARRIER is necessary to work-around a
#   peculiarity of the memory controller that interfaces the network controller to
#   the bus.
# 
diff -Nru a/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h	Sun Aug 15 20:58:47 2004
+++ b/drivers/net/smc91x.h	Sun Aug 15 20:58:47 2004
@@ -160,6 +160,49 @@
 #define SMC_insw(a, r, p, l)	insw((a) + (r), p, l)
 #define SMC_outsw(a, r, p, l)	outsw((a) + (r), p, l)
 
+#elif	defined(CONFIG_MACH_LPD7A400) || defined(CONFIG_MACH_LPD7A404)
+
+#include <asm/arch/constants.h>	/* IOBARRIER_VIRT */
+
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+#define SMC_NOWAIT		0
+#define SMC_IOBARRIER		({ barrier (); readl (IOBARRIER_VIRT); })
+
+static inline unsigned short SMC_inw (unsigned long a, int r)
+{
+	unsigned short v;
+	v = readw (a + r);
+	SMC_IOBARRIER;
+	return v;
+}
+
+static inline void SMC_outw (unsigned short v, unsigned long a, int r)
+{
+	writew (v, a + r);
+	SMC_IOBARRIER;
+}
+
+static inline void SMC_insw (unsigned long a, int r, unsigned char* p, int l)
+{
+	while (l-- > 0) {
+		*((unsigned short*)p)++ = readw (a + r);
+		SMC_IOBARRIER;
+	}
+}
+
+static inline void SMC_outsw (unsigned long a, int r, unsigned char* p, int l)
+{
+	while (l-- > 0) {
+		writew (*((unsigned short*)p)++, a + r);
+		SMC_IOBARRIER;
+	}
+}
+
+#define RPC_LSA_DEFAULT		RPC_LED_TX_RX
+#define RPC_LSB_DEFAULT		RPC_LED_100_10
+
 #else
 
 #define SMC_CAN_USE_8BIT	1

----- End forwarded message -----
