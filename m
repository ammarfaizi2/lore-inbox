Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbRLHACp>; Fri, 7 Dec 2001 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285693AbRLHACb>; Fri, 7 Dec 2001 19:02:31 -0500
Received: from ns.ithnet.com ([217.64.64.10]:24077 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285692AbRLHACJ>;
	Fri, 7 Dec 2001 19:02:09 -0500
Date: Sat, 8 Dec 2001 01:01:57 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, marcelo@conectiva.com.br,
        torvalds@transmeta.com
Subject: [PATCH] for pre6: hisax user config MAX_CARD and fix potential data trashing
Message-Id: <20011208010157.1b6ff664.skraw@ithnet.com>
In-Reply-To: <20011204174836.0ab6f5de.skraw@ithnet.com>
In-Reply-To: <20011204174836.0ab6f5de.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Karsten,
Hello Kai,
 
attached is the second patch for ISDN-Driver HiSax for kernel-inclusion that does the
following:
 
1) Make HISAX_MAX_CARDS user configurable during make menuconfig

2) Fix a potential trashing of data for the auto-add of SCITEL QUAD card. It did not check at all, if there was enough room to include further cards!

Patch is diffed to 2.4.17-pre6 (yes I am fast :-) and compiles ok.
As it is a bit bigger than originaly intended, can you please comment on it, Kai.
I had to fix the init part, because you can now configure the MAX_CARDS-value _down_ to 1.

Thanks to Keith Owens for Makefile fiddling.

Regards,
Stephan

hisax-max-patch-2:

--- linux/drivers/isdn/Config.in-orig	Sat Dec  8 00:35:27 2001
+++ linux/drivers/isdn/Config.in	Sat Dec  8 00:35:15 2001
@@ -42,6 +42,7 @@
    fi
    bool '  HiSax Support for german 1TR6' CONFIG_HISAX_1TR6
    bool '  HiSax Support for US NI1' CONFIG_HISAX_NI1
+   int  '  Maximum number of cards supported by HiSax' CONFIG_HISAX_MAX_CARDS 8
    comment '  HiSax supported cards'
    bool '  Teles 16.0/8.0' CONFIG_HISAX_16_0
    bool '  Teles 16.3 or PNP or PCMCIA' CONFIG_HISAX_16_3
--- linux/drivers/isdn/hisax/Makefile-orig	Sat Dec  8 00:24:43 2001
+++ linux/drivers/isdn/hisax/Makefile	Sat Dec  8 00:25:39 2001
@@ -4,6 +4,10 @@
 
 O_TARGET	  := vmlinux-obj.o
 
+# Define maximum number of cards
+
+EXTRA_CFLAGS      += -DHISAX_MAX_CARDS=$(CONFIG_HISAX_MAX_CARDS)
+
 # Objects that export symbols.
 
 export-objs	  := config.o fsm.o hisax_isac.o
--- linux/drivers/isdn/hisax/hisax.h-orig	Sat Dec  8 00:24:20 2001
+++ linux/drivers/isdn/hisax/hisax.h	Sat Dec  8 00:40:49 2001
@@ -950,7 +950,9 @@
 #define  MON0_TX	4
 #define  MON1_TX	8
 
+#ifndef HISAX_MAX_CARDS
 #define	 HISAX_MAX_CARDS	8
+#endif
 
 #define  ISDN_CTYPE_16_0	1
 #define  ISDN_CTYPE_8_0		2
--- linux/drivers/isdn/hisax/config.c-orig	Sat Dec  8 00:24:26 2001
+++ linux/drivers/isdn/hisax/config.c	Sat Dec  8 00:33:57 2001
@@ -336,17 +336,8 @@
 	NULL, \
 }
 
-#define EMPTY_CARD	{0, DEFAULT_PROTO, {0, 0, 0, 0}, NULL}
-
 struct IsdnCard cards[HISAX_MAX_CARDS] = {
 	FIRST_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
-	EMPTY_CARD,
 };
 
 #define HISAX_IDSIZE (HISAX_MAX_CARDS*8)
@@ -454,6 +445,7 @@
 	i = 0;
 	j = 1;
 	while (argc && (i < HISAX_MAX_CARDS)) {
+		cards[i].protocol = DEFAULT_PROTO;
 		if (argc) {
 			cards[i].typ = ints[j];
 			j++;
@@ -1405,6 +1397,8 @@
 			cards[j].protocol = protocol[i];
 			nzproto++;
 		}
+		else
+			cards[j].protocol = DEFAULT_PROTO;
 		switch (type[i]) {
 		case ISDN_CTYPE_16_0:
 			cards[j].para[0] = irq[i];
@@ -1481,15 +1475,22 @@
 			} else {
 				/* QUADRO is a 4 BRI card */
 				cards[j++].para[0] = 1;
-				cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
-				cards[j].protocol = protocol[i];
-				cards[j++].para[0] = 2;
-				cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
-				cards[j].protocol = protocol[i];
-				cards[j++].para[0] = 3;
-				cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
-				cards[j].protocol = protocol[i];
-				cards[j].para[0] = 4;
+				/* we need to check if further cards can be added */
+				if (j < HISAX_MAX_CARDS) {
+					cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
+					cards[j].protocol = protocol[i];
+					cards[j++].para[0] = 2;
+				}
+				if (j < HISAX_MAX_CARDS) {
+					cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
+					cards[j].protocol = protocol[i];
+					cards[j++].para[0] = 3;
+				}
+				if (j < HISAX_MAX_CARDS) {
+					cards[j].typ = ISDN_CTYPE_SCT_QUADRO;
+					cards[j].protocol = protocol[i];
+					cards[j].para[0] = 4;
+				}
 			}
 			break;
 		}
@@ -1563,6 +1564,8 @@
 		if (protocol[i]) {
 			cards[i].protocol = protocol[i];
 		}
+		else
+			cards[i].protocol = DEFAULT_PROTO;
 	}
 	cards[0].para[0] = pcm_irq;
 	cards[0].para[1] = (int) pcm_iob;
@@ -1603,6 +1606,8 @@
 		if (protocol[i]) {
 			cards[i].protocol = protocol[i];
 		}
+		else
+			cards[i].protocol = DEFAULT_PROTO;
 	}
 	cards[0].para[0] = pcm_irq;
 	cards[0].para[1] = (int) pcm_iob;
@@ -1643,6 +1648,8 @@
 		if (protocol[i]) {
 			cards[i].protocol = protocol[i];
 		}
+		else
+			cards[i].protocol = DEFAULT_PROTO;
 	}
 	cards[0].para[0] = pcm_irq;
 	cards[0].para[1] = (int) pcm_iob;
@@ -1683,6 +1690,8 @@
 		if (protocol[i]) {
 			cards[i].protocol = protocol[i];
 		}
+		else
+			cards[i].protocol = DEFAULT_PROTO;
 	}
 	cards[0].para[0] = pcm_irq;
 	cards[0].para[1] = (int) pcm_iob;
