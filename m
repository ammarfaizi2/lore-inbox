Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSHGWuT>; Wed, 7 Aug 2002 18:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSHGWuS>; Wed, 7 Aug 2002 18:50:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28636 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315276AbSHGWuQ>;
	Wed, 7 Aug 2002 18:50:16 -0400
Date: Wed, 07 Aug 2002 15:40:04 -0700 (PDT)
Message-Id: <20020807.154004.104177403.davem@redhat.com>
To: rkuhn@e18.physik.tu-muenchen.de
Cc: kwijibo@zianet.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208080007300.4058-100000@pc40.e18.physik.tu-muenchen.de>
References: <3D51940A.60805@zianet.com>
	<Pine.LNX.4.44.0208080007300.4058-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
   Date: Thu, 8 Aug 2002 00:10:31 +0200 (CEST)

   Since the insertion of a dummy write solved the problem, I would say it's 
   the chipset's PCI reordering, which is malfunctioning in the 2466.

Roland can you retry using this patch?  The difference from
my previous one is that when we use the indirect register
writing of the mailbox registers, we offset into the GRCMBOX
area of the chip registers.

This seems to be how Broadcom's driver does indirect accesses
to mailbox registers.

--- drivers/net/tg3.c.~1~	Wed Aug  7 15:42:34 2002
+++ drivers/net/tg3.c	Wed Aug  7 15:45:56 2002
@@ -173,8 +173,23 @@
 	}
 }
 
+static void tg3_write_indirect_mbox(struct tg3 *tp, u32 off, u32 val)
+{
+	if (/*XXX*/ 1 || (tp->tg3_flags & TG3_FLAG_PCIMEM_ORDERING_HWBUG) != 0) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&tp->indirect_lock, flags);
+		pci_write_config_dword(tp->pdev, TG3PCI_REG_BASE_ADDR,
+				       off + 0x5600);
+		pci_write_config_dword(tp->pdev, TG3PCI_REG_DATA, val);
+		spin_unlock_irqrestore(&tp->indirect_lock, flags);
+	} else {
+		writel(val, tp->regs + off);
+	}
+}
+
 #define tw32(reg,val)		tg3_write_indirect_reg32(tp,(reg),(val))
-#define tw32_mailbox(reg, val)	writel(((val) & 0xffffffff), tp->regs + (reg))
+#define tw32_mailbox(reg, val)	tg3_write_indirect_mbox(tp,(reg),(val))
 #define tw16(reg,val)		writew(((val) & 0xffff), tp->regs + (reg))
 #define tw8(reg,val)		writeb(((val) & 0xff), tp->regs + (reg))
 #define tr32(reg)		readl(tp->regs + (reg))
--- drivers/net/tg3.h.~1~	Wed Aug  7 15:44:04 2002
+++ drivers/net/tg3.h	Wed Aug  7 15:44:30 2002
@@ -1740,7 +1740,8 @@
 #define TG3_FLAG_POLL_SERDES		0x00000080
 #define TG3_FLAG_PHY_RESET_ON_INIT	0x00000100
 #define TG3_FLAG_PCIX_TARGET_HWBUG	0x00000200
-#define TG3_FLAG_WOL_SPEED_100MB	0x00000400
+#define TG3_FLAG_PCIMEM_ORDERING_HWBUG	0x00000400
+#define TG3_FLAG_WOL_SPEED_100MB	0x00000800
 #define TG3_FLAG_WOL_ENABLE		0x00001000
 #define TG3_FLAG_NVRAM			0x00002000
 #define TG3_FLAG_NVRAM_BUFFERED		0x00004000
