Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUITTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUITTdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUITTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:33:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:661 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267248AbUITTd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:33:26 -0400
Date: Mon, 20 Sep 2004 21:40:07 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Karsten Keil <keil@isdn4linux.de>
Subject: [PATCH] readb/writeb pointer from integer without a cast fixes -
 correct way to fix?
Message-ID: <Pine.LNX.4.61.0409202134100.2729@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, here's a patch attempting to fix the following warnings :

  CC      drivers/isdn/hisax/teles0.o
drivers/isdn/hisax/teles0.c: In function `readisac':
drivers/isdn/hisax/teles0.c:35: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c: In function `writeisac':
drivers/isdn/hisax/teles0.c:41: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c: In function `readhscx':
drivers/isdn/hisax/teles0.c:49: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c: In function `writehscx':
drivers/isdn/hisax/teles0.c:56: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c: In function `reset_teles0':
drivers/isdn/hisax/teles0.c:236: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/isdn/hisax/teles0.c:238: warning: passing arg 2 of `writeb' makes pointer from integer without a cast

I hope I got it right. It builds fine, but I don't have the hardware to 
test and I would like some confirmation that this is the correct way to 
fix these warnings before I get started on the rest of them.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.9-rc2-bk5-orig/drivers/isdn/hisax/teles0.c linux-2.6.9-rc2-bk5/drivers/isdn/hisax/teles0.c
--- linux-2.6.9-rc2-bk5-orig/drivers/isdn/hisax/teles0.c	2004-08-14 07:36:58.000000000 +0200
+++ linux-2.6.9-rc2-bk5/drivers/isdn/hisax/teles0.c	2004-09-20 21:33:05.000000000 +0200
@@ -32,28 +32,28 @@ const char *teles0_revision = "$Revision
 static inline u_char
 readisac(unsigned long adr, u_char off)
 {
-	return readb(adr + ((off & 1) ? 0x2ff : 0x100) + off);
+	return readb((u_char *)(adr + ((off & 1) ? 0x2ff : 0x100) + off));
 }
 
 static inline void
 writeisac(unsigned long adr, u_char off, u_char data)
 {
-	writeb(data, adr + ((off & 1) ? 0x2ff : 0x100) + off); mb();
+	writeb(data, (u_char *)(adr + ((off & 1) ? 0x2ff : 0x100) + off)); mb();
 }
 
 
 static inline u_char
 readhscx(unsigned long adr, int hscx, u_char off)
 {
-	return readb(adr + (hscx ? 0x1c0 : 0x180) +
-		     ((off & 1) ? 0x1ff : 0) + off);
+	return readb((u_char *)(adr + (hscx ? 0x1c0 : 0x180) +
+		     ((off & 1) ? 0x1ff : 0) + off));
 }
 
 static inline void
 writehscx(unsigned long adr, int hscx, u_char off, u_char data)
 {
-	writeb(data, adr + (hscx ? 0x1c0 : 0x180) +
-	       ((off & 1) ? 0x1ff : 0) + off); mb();
+	writeb(data, (u_char *)(adr + (hscx ? 0x1c0 : 0x180) +
+	       ((off & 1) ? 0x1ff : 0) + off)); mb();
 }
 
 static inline void
@@ -233,9 +233,9 @@ reset_teles0(struct IsdnCardState *cs)
 		byteout(cs->hw.teles0.cfg_reg + 4, cfval | 1);
 		HZDELAY(HZ / 10 + 1);
 	}
-	writeb(0, cs->hw.teles0.membase + 0x80); mb();
+	writeb(0, (unsigned long *)(cs->hw.teles0.membase + 0x80)); mb();
 	HZDELAY(HZ / 5 + 1);
-	writeb(1, cs->hw.teles0.membase + 0x80); mb();
+	writeb(1, (unsigned long *)(cs->hw.teles0.membase + 0x80)); mb();
 	HZDELAY(HZ / 5 + 1);
 	return(0);
 }



