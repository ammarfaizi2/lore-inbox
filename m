Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRLDQuy>; Tue, 4 Dec 2001 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281228AbRLDQuB>; Tue, 4 Dec 2001 11:50:01 -0500
Received: from ns.ithnet.com ([217.64.64.10]:39438 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281116AbRLDQsr>;
	Tue, 4 Dec 2001 11:48:47 -0500
Date: Tue, 4 Dec 2001 17:48:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] hisax fix MAX_CARD setup and potential buffer overflow
Message-Id: <20011204174836.0ab6f5de.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Karsten,
Hello Kai,

attached is a patch for ISDN-Driver HiSax for kernel-inclusion that does the
following:

1) Fix usage of HISAX_MAX_CARDS definition so one can _really_ create more (or
less) cards by simply editing HISAX_MAX_CARDS to an appropriate value. In the
original code the idea was visible, only implementation was broken in this
respect.

2) Fix a potential buffer overflow (strcpy) which can be triggered by adding
too long IDs during insmod.

Thanks to Henning Schmiedehausen for support.

Hopefully coming soon:

Patch to edit HISAX_MAX_CARDS during make menuconfig (configurable for joe
user)

Regards,
Stephan

PS: skraw back to the roots ;-)

hisax-max-patch:

--- linux/drivers/isdn/hisax/config.c-orig	Tue Dec  4 02:09:59 2001
+++ linux/drivers/isdn/hisax/config.c	Tue Dec  4 17:30:29 2001
@@ -338,7 +338,7 @@
 
 #define EMPTY_CARD	{0, DEFAULT_PROTO, {0, 0, 0, 0}, NULL}
 
-struct IsdnCard cards[] = {
+struct IsdnCard cards[HISAX_MAX_CARDS] = {
 	FIRST_CARD,
 	EMPTY_CARD,
 	EMPTY_CARD,
@@ -349,14 +349,15 @@
 	EMPTY_CARD,
 };
 
-static char HiSaxID[64] __devinitdata = { 0, };
+#define HISAX_IDSIZE (HISAX_MAX_CARDS*8)
+static char HiSaxID[HISAX_IDSIZE] __devinitdata = { 0, };
 
 char *HiSax_id __devinitdata = HiSaxID;
 #ifdef MODULE
 /* Variables for insmod */
-static int type[8] __devinitdata = { 0, };
-static int protocol[8] __devinitdata = { 0, };
-static int io[8] __devinitdata = { 0, };
+static int type[HISAX_MAX_CARDS] __devinitdata = { 0, };
+static int protocol[HISAX_MAX_CARDS] __devinitdata = { 0, };
+static int io[HISAX_MAX_CARDS] __devinitdata = { 0, };
 #undef IO0_IO1
 #ifdef CONFIG_HISAX_16_3
 #define IO0_IO1
@@ -366,25 +367,30 @@
 #define IO0_IO1
 #endif
 #ifdef IO0_IO1
-static int io0[8] __devinitdata = { 0, };
-static int io1[8] __devinitdata = { 0, };
+static int io0[HISAX_MAX_CARDS] __devinitdata = { 0, };
+static int io1[HISAX_MAX_CARDS] __devinitdata = { 0, };
 #endif
-static int irq[8] __devinitdata = { 0, };
-static int mem[8] __devinitdata = { 0, };
+static int irq[HISAX_MAX_CARDS] __devinitdata = { 0, };
+static int mem[HISAX_MAX_CARDS] __devinitdata = { 0, };
 static char *id __devinitdata = HiSaxID;
 
+/* string magic */
+#define h1(s) h2(s)
+#define h2(s) #s
+#define PARM_PARA "1-"h1(HISAX_MAX_CARDS)"i"
+
 MODULE_DESCRIPTION("ISDN4Linux: Driver for passive ISDN cards");
 MODULE_AUTHOR("Karsten Keil");
 MODULE_LICENSE("GPL");
-MODULE_PARM(type, "1-8i");
-MODULE_PARM(protocol, "1-8i");
-MODULE_PARM(io, "1-8i");
-MODULE_PARM(irq, "1-8i");
-MODULE_PARM(mem, "1-8i");
+MODULE_PARM(type, PARM_PARA);
+MODULE_PARM(protocol, PARM_PARA);
+MODULE_PARM(io, PARM_PARA);
+MODULE_PARM(irq, PARM_PARA);
+MODULE_PARM(mem, PARM_PARA);
 MODULE_PARM(id, "s");
 #ifdef IO0_IO1
-MODULE_PARM(io0, "1-8i");
-MODULE_PARM(io1, "1-8i");
+MODULE_PARM(io0, PARM_PARA);
+MODULE_PARM(io1, PARM_PARA);
 #endif
 #endif /* MODULE */
 
@@ -476,12 +482,14 @@
 		i++;
 	}
 	if (str && *str) {
-		strcpy(HiSaxID, str);
-		HiSax_id = HiSaxID;
-	} else {
+		if (strlen(str) < HISAX_IDSIZE)
+			strcpy(HiSaxID, str);
+		else
+			printk(KERN_WARNING "HiSax: ID too long!")
+	} else
 		strcpy(HiSaxID, "HiSax");
-		HiSax_id = HiSaxID;
-	}
+
+	HiSax_id = HiSaxID;
 	return 1;
 }
 
