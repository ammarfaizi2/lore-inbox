Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSHGO6A>; Wed, 7 Aug 2002 10:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSHGO6A>; Wed, 7 Aug 2002 10:58:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32728 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311898AbSHGO57>;
	Wed, 7 Aug 2002 10:57:59 -0400
Date: Wed, 07 Aug 2002 07:48:38 -0700 (PDT)
Message-Id: <20020807.074838.106638568.davem@redhat.com>
To: rkuhn@e18.physik.tu-muenchen.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208071646570.3705-100000@pc40.e18.physik.tu-muenchen.de>
References: <20020807.072020.130694315.davem@redhat.com>
	<Pine.LNX.4.44.0208071646570.3705-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
   Date: Wed, 7 Aug 2002 16:49:24 +0200 (CEST)

   Sorry, same problem as before. It looks like the spinlocked write method 
   does not work on the BCM5701 chip :-(

I'm still not entirely convinced of this :-)
Backout all of your changes and try this patch instead:

--- drivers/net/tg3.c.~1~	Wed Aug  7 07:56:39 2002
+++ drivers/net/tg3.c	Wed Aug  7 07:57:08 2002
@@ -173,8 +173,18 @@
 	}
 }
 
+static void tg3_write_mailbox_reg32(struct tg3 *tp, u32 off, u32 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tp->indirect_lock, flags);
+	pci_write_config_dword(tp->pdev, TG3PCI_REG_BASE_ADDR, off);
+	pci_write_config_dword(tp->pdev, TG3PCI_REG_DATA, val);
+	spin_unlock_irqrestore(&tp->indirect_lock, flags);
+}
+
 #define tw32(reg,val)		tg3_write_indirect_reg32(tp,(reg),(val))
-#define tw32_mailbox(reg, val)	writel(((val) & 0xffffffff), tp->regs + (reg))
+#define tw32_mailbox(reg, val)	tg3_write_mailbox_reg32(tp,(reg),(val))
 #define tw16(reg,val)		writew(((val) & 0xffff), tp->regs + (reg))
 #define tw8(reg,val)		writeb(((val) & 0xff), tp->regs + (reg))
 #define tr32(reg)		readl(tp->regs + (reg))
