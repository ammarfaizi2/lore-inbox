Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQKLPuv>; Sun, 12 Nov 2000 10:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129987AbQKLPub>; Sun, 12 Nov 2000 10:50:31 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:57427
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129234AbQKLPuY>; Sun, 12 Nov 2000 10:50:24 -0500
Date: Sun, 12 Nov 2000 16:42:36 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dagb@cs.uit.no
Cc: linux-irda@pasta.cs.uit.no, linux-kernel@vger.kernel.org
Subject: Compile and link errors in irda in test11-pre3
Message-ID: <20001112164236.J637@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I try to compile 2.4.0-test11-pre3 I get the following in
the link phase:

drivers/net/irda/irda.o: In function `nsc_ircc_hard_xmit_fir':
drivers/net/irda/irda.o(.text+0x346e): undefined reference to `nsc_ircc_change_speed_complete'
drivers/net/irda/irda.o: In function `toshoboe_hard_xmit':
drivers/net/irda/irda.o(.text+0x632e): undefined reference to `toshoboe_change_speed'
drivers/net/irda/irda.o: In function `ircc_hard_xmit':
drivers/net/irda/irda.o(.text+0x79c3): undefined reference to `smc_ircc_change_speed'
net/network.o: In function `irda_proto_init':
net/network.o(.text.init+0x41b3): undefined reference to `irda_init'
make: *** [vmlinux] Error 1


The patch below fixes this. I'm not familiar with the irda code, so
this might be all wrong (thus Linus is not cc'ed).


--- linux-240-t11-pre3-clean/net/irda/irsyms.c	Sun Nov 12 09:46:15 2000
+++ linux/net/irda/irsyms.c	Sun Nov 12 16:32:10 2000
@@ -182,7 +182,7 @@
 EXPORT_SYMBOL(irtty_set_packet_mode);
 #endif
 
-static int __init irda_init(void)
+int __init irda_init(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
--- linux-240-t11-pre3-clean/drivers/net/irda/nsc-ircc.c	Sun Nov 12 09:46:13 2000
+++ linux/drivers/net/irda/nsc-ircc.c	Sun Nov 12 16:05:17 2000
@@ -1129,7 +1129,7 @@
 	if ((speed = irda_get_speed(skb)) != self->io.speed) {
 		/* Check for empty frame */
 		if (!skb->len) {
-			nsc_ircc_change_speed_complete(self, speed); 
+			nsc_ircc_change_speed(self, speed); 
 			return 0;
 		} else
 			self->new_speed = speed;
--- linux-240-t11-pre3-clean/drivers/net/irda/smc-ircc.c	Sun Nov 12 09:46:13 2000
+++ linux/drivers/net/irda/smc-ircc.c	Sun Nov 12 16:23:48 2000
@@ -620,7 +620,7 @@
 	if ((speed = irda_get_speed(skb)) != self->io.speed) {
 		/* Check for empty frame */
 		if (!skb->len) {
-			smc_ircc_change_speed(self, speed); 
+			self->new_speed = speed; 
 			return 0;
 		} else
 			self->new_speed = speed;
--- linux-240-t11-pre3-clean/drivers/net/irda/toshoboe.c	Sun Nov 12 09:46:13 2000
+++ linux/drivers/net/irda/toshoboe.c	Sun Nov 12 16:20:17 2000
@@ -275,7 +275,7 @@
   if ((speed = irda_get_speed(skb)) != self->io.speed) {
 	/* Check for empty frame */
 	if (!skb->len) {
-	    toshoboe_change_speed(self, speed); 
+	    self->new_speed = speed; 
 	    return 0;
 	} else
 	    self->new_speed = speed;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"God prevent we should ever be twenty years without a revolution." 
  -- Thomas Jefferson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
