Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRAHT1N>; Mon, 8 Jan 2001 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131213AbRAHT0x>; Mon, 8 Jan 2001 14:26:53 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:8680 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131139AbRAHT0q>; Mon, 8 Jan 2001 14:26:46 -0500
Date: Mon, 8 Jan 2001 20:27:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0: defxx oopses upon insmod if short on memory
Message-ID: <Pine.GSO.3.96.1010108200812.23234Z-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Is there anyone maintaining defxx these days?

 The defxx driver does a null pointer derefence if a system is short on
memory.  This happens repeatably on a 32MB machine if fsck is run just
befor loading the driver (not an unusual event upon startup and a quite
nasty one).

 The driver should check for a null pointer, obviously and the following
patch does.  Anyway, as the driver allocates quite an amount of memory
chances are it will fail to get it so I decided to call schedule() so that
temporary buffers might get freed.  Otherwise chances are it would never
succeed on a busy system.  It succeeds after ~50 iterations on my system.

 If anyone has a better idea, I would be pleased to hear it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-defxx-1
diff -up --recursive --new-file linux-2.4.0.macro/drivers/net/defxx.c linux-2.4.0/drivers/net/defxx.c
--- linux-2.4.0.macro/drivers/net/defxx.c	Tue Sep  5 19:57:51 2000
+++ linux-2.4.0/drivers/net/defxx.c	Sun Jan  7 22:56:21 2001
@@ -2709,7 +2709,10 @@ static void dfx_rcv_init(DFX_board_t *bp
 			struct sk_buff *newskb;
 			bp->descr_block_virt->rcv_data[i+j].long_0 = (u32) (PI_RCV_DESCR_M_SOP |
 				((PI_RCV_DATA_K_SIZE_MAX / PI_ALIGN_K_RCV_DATA_BUFF) << PI_RCV_DESCR_V_SEG_LEN));
-			newskb = dev_alloc_skb(NEW_SKB_SIZE);
+			while (!(newskb = dev_alloc_skb(NEW_SKB_SIZE))) {
+				printk(KERN_WARNING "%s: Could not allocate receive buffer.\n", bp->dev->name);
+				schedule();
+			}
 			/*
 			 * align to 128 bytes for compatibility with
 			 * the old EISA boards.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
