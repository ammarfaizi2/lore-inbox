Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131522AbRCUQkp>; Wed, 21 Mar 2001 11:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131599AbRCUQkg>; Wed, 21 Mar 2001 11:40:36 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:62217 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S131522AbRCUQkb>;
	Wed, 21 Mar 2001 11:40:31 -0500
Date: Wed, 21 Mar 2001 17:39:30 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, khc@pm.waw.pl,
        Alan Cox <alan@redhat.com>
Subject: [PATCH] Re: [PATCH] Re: [PATCH] 2.4.3-pre6 - hdlc/dscc4 missing bits
Message-ID: <20010321173930.A29474@se1.cogenit.fr>
In-Reply-To: <20010321163031.A28981@se1.cogenit.fr> <3AB8CDE0.2B2619AF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB8CDE0.2B2619AF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 21, 2001 at 10:50:56AM -0500
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> écrit :
> You should use this patch instead, from Alan's tree, for updating
> include/linux/if_arp.h...

It adds confusion: do you imagine the poor soul who discovers hdlc in Linux
and sees ARPHRD_CISCO and ARPHRD_HDLC for the same use after some hours
of code-greping (both will be used at the moment if hdlc.c do so) ?
Don't be surprised if he ends using label pointers everywhere. :o)

What about the following (2.5 ?):

diff -u -N --recursive linux-2.4.3-pre6.orig/drivers/net/wan/comx-proto-ppp.c linux-2.4.3-pre6/drivers/net/wan/comx-proto-ppp.c
--- linux-2.4.3-pre6.orig/drivers/net/wan/comx-proto-ppp.c	Wed Mar 21 10:56:18 2001
+++ linux-2.4.3-pre6/drivers/net/wan/comx-proto-ppp.c	Wed Mar 21 14:26:37 2001
@@ -208,7 +208,7 @@
 
 	if(ch->protocol == &hdlc_protocol) {
 		pppdev->sppp.pp_flags |= PP_CISCO;
-		dev->type = ARPHRD_HDLC;
+		dev->type = ARPHRD_CISCO;
 	} else {
 		pppdev->sppp.pp_flags &= ~PP_CISCO;
 		dev->type = ARPHRD_PPP;
diff -u -N --recursive linux-2.4.3-pre6.orig/drivers/net/wan/lmc/lmc_main.c linux-2.4.3-pre6/drivers/net/wan/lmc/lmc_main.c
--- linux-2.4.3-pre6.orig/drivers/net/wan/lmc/lmc_main.c	Wed Mar 21 10:56:18 2001
+++ linux-2.4.3-pre6/drivers/net/wan/lmc/lmc_main.c	Wed Mar 21 14:25:55 2001
@@ -74,7 +74,7 @@
 #include <asm/uaccess.h>
 //#include <asm/spinlock.h>
 #else				/* 2.0 kernel */
-#define ARPHRD_HDLC 513
+#define ARPHRD_CISCO 513
 #endif
 
 #include <linux/module.h>
@@ -900,7 +900,7 @@
     /* Just fill in the entries for the device */
 
     dev->init = lmc_init;
-    dev->type = ARPHRD_HDLC;
+    dev->type = ARPHRD_CISCO;
     dev->hard_start_xmit = lmc_start_xmit;
     dev->open = lmc_open;
     dev->stop = lmc_close;
diff -u -N --recursive linux-2.4.3-pre6.orig/drivers/net/wan/syncppp.c linux-2.4.3-pre6/drivers/net/wan/syncppp.c
--- linux-2.4.3-pre6.orig/drivers/net/wan/syncppp.c	Wed Mar 21 10:56:18 2001
+++ linux-2.4.3-pre6/drivers/net/wan/syncppp.c	Wed Mar 21 14:23:54 2001
@@ -964,7 +964,7 @@
 	{
 		case SPPPIOCCISCO:
 			sp->pp_flags|=PP_CISCO;
-			dev->type = ARPHRD_HDLC;
+			dev->type = ARPHRD_CISCO;
 			break;
 		case SPPPIOCPPP:
 			sp->pp_flags&=~PP_CISCO;
@@ -1031,7 +1031,7 @@
 	dev->hard_header = sppp_hard_header;
 	dev->rebuild_header = sppp_rebuild_header;
 	dev->tx_queue_len = 10;
-	dev->type = ARPHRD_HDLC;
+	dev->type = ARPHRD_CISCO;
 	dev->addr_len = 0;
 	dev->hard_header_len = sizeof(struct ppp_header);
 	dev->mtu = PPP_MTU;
diff -u -N --recursive linux-2.4.3-pre6.orig/drivers/net/wan/z85230.c linux-2.4.3-pre6/drivers/net/wan/z85230.c
--- linux-2.4.3-pre6.orig/drivers/net/wan/z85230.c	Wed Mar 21 10:56:18 2001
+++ linux-2.4.3-pre6/drivers/net/wan/z85230.c	Wed Mar 21 14:24:30 2001
@@ -471,7 +471,7 @@
 			printk(KERN_INFO "%s: DCD raised\n", chan->dev->name);
 			write_zsreg(chan, R3, chan->regs[3]|RxENABLE);
 			if(chan->netdevice &&
-			    ((chan->netdevice->type == ARPHRD_HDLC) ||
+			    ((chan->netdevice->type == ARPHRD_CISCO) ||
 			    (chan->netdevice->type == ARPHRD_PPP)))
 				sppp_reopen(chan->netdevice);
 		}
@@ -590,7 +590,7 @@
 			printk(KERN_INFO "%s: DCD raised\n", chan->dev->name);
 			write_zsreg(chan, R3, chan->regs[3]|RxENABLE);
 			if(chan->netdevice &&
-			    ((chan->netdevice->type == ARPHRD_HDLC) ||
+			    ((chan->netdevice->type == ARPHRD_CISCO) ||
 			    (chan->netdevice->type == ARPHRD_PPP)))
 				sppp_reopen(chan->netdevice);
 		}
diff -u -N --recursive linux-2.4.3-pre6.orig/include/linux/if_arp.h linux-2.4.3-pre6/include/linux/if_arp.h
--- linux-2.4.3-pre6.orig/include/linux/if_arp.h	Thu Jan  4 22:51:20 2001
+++ linux-2.4.3-pre6/include/linux/if_arp.h	Wed Mar 21 14:19:21 2001
@@ -50,9 +50,10 @@
 #define ARPHRD_X25	271		/* CCITT X.25			*/
 #define ARPHRD_HWX25	272		/* Boards with X.25 in firmware	*/
 #define ARPHRD_PPP	512
-#define ARPHRD_HDLC	513		/* (Cisco) HDLC 		*/
+#define ARPHRD_CISCO	513		/* (Cisco) HDLC 		*/
 #define ARPHRD_LAPB	516		/* LAPB				*/
 #define ARPHRD_DDCMP    517		/* Digital's DDCMP protocol     */
+#define ARPHRD_RAWHDLC  518             /* Raw HDLC                     */
 
 #define ARPHRD_TUNNEL	768		/* IPIP tunnel			*/
 #define ARPHRD_TUNNEL6	769		/* IPIP6 tunnel			*/
 
-- 
Ueimor
