Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277286AbRJEALN>; Thu, 4 Oct 2001 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277280AbRJEALH>; Thu, 4 Oct 2001 20:11:07 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13523 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277284AbRJEAKn>;
	Thu, 4 Oct 2001 20:10:43 -0400
Date: Thu, 4 Oct 2001 17:11:08 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] ir240_various_cleanup-2.diff
Message-ID: <20011004171108.E3290@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_various_cleanup-2.diff :
----------------------------
	o [CORRECT] Remove a comment that Dag found offensive
	o [CORRECT] Remove unused variable (spurious warning)
	o [CORRECT] Typo in nsc-ircc.c
	o [FEATURE] Enable alternate IO address in smc-ircc.c


diff -u -p linux/net/irda/irlap_event.d0.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d0.c	Fri Sep 28 11:51:16 2001
+++ linux/net/irda/irlap_event.c	Fri Sep 28 11:51:33 2001
@@ -701,7 +701,21 @@ static int irlap_state_conn(struct irlap
 		 * We are allowed to send two frames, but this may increase
 		 * the connect latency, so lets not do it for now.
 		 */
-		/* What the hell is this ? - Jean II */
+		/* This is full of good intentions, but doesn't work in
+		 * practice.
+		 * After sending the first UA response, we switch the
+		 * dongle to the negociated speed, which is usually
+		 * different than 9600 kb/s.
+		 * From there, there is two solutions :
+		 * 1) The other end has received the first UA response :
+		 * it will set up the connection, move to state LAP_NRM_P,
+		 * and will ignore and drop the second UA response.
+		 * Actually, it's even worse : the other side will almost
+		 * immediately send a RR that will likely collide with the
+		 * UA response (depending on negociated turnaround).
+		 * 2) The other end has not received the first UA response,
+		 * will stay at 9600 and will never see the second UA response.
+		 * Jean II */
 		irlap_send_ua_response_frame(self, &self->qos_rx);
 #endif
 
diff -u -p linux/net/irda/irias_object.d0.c linux/net/irda/irias_object.c
--- linux/net/irda/irias_object.d0.c	Fri Sep 28 11:41:36 2001
+++ linux/net/irda/irias_object.c	Fri Sep 28 11:42:09 2001
@@ -435,8 +435,6 @@ struct ias_value *irias_new_integer_valu
 struct ias_value *irias_new_string_value(char *string)
 {
 	struct ias_value *value;
-	int len;
-	char *new_str;
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
diff -u -p linux/drivers/net/irda/nsc-ircc.d0.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d0.c	Fri Sep 28 11:43:42 2001
+++ linux/drivers/net/irda/nsc-ircc.c	Fri Sep 28 11:44:26 2001
@@ -112,7 +112,7 @@ static char *dongle_types[] = {
 	"Reserved",
 	"Reserved",
 	"HP HSDL-1100/HSDL-2100",
-	"HP HSDL-1100/HSDL-2100"
+	"HP HSDL-1100/HSDL-2100",
 	"Supports SIR Mode only",
 	"No dongle connected",
 };
diff -u -p linux/drivers/net/irda/smc-ircc.d0b.c linux/drivers/net/irda/smc-ircc.c
--- linux/drivers/net/irda/smc-ircc.d0b.c	Thu Oct  4 15:57:42 2001
+++ linux/drivers/net/irda/smc-ircc.c	Thu Oct  4 16:10:22 2001
@@ -127,7 +127,7 @@ static smc_chip_t __initdata fdc_chips_p
 	{ "37M707",	KEY55_1|SIR|SERx4,	0x42, 0x00 },
 	{ "37M81X",	KEY55_1|SIR|SERx4,	0x4d, 0x00 },
 	{ "37N958FR",	KEY55_1|FIR|SERx4,	0x09, 0x04 },
-	{ "37N972",	KEY55_1|FIR|SERx4,	0x0a, 0x00 },
+	{ "37N971",	KEY55_1|FIR|SERx4,	0x0a, 0x00 },
 	{ "37N972",	KEY55_1|FIR|SERx4,	0x0b, 0x00 },
 	{ NULL }
 };
@@ -158,6 +158,7 @@ static int ircc_irq=255;
 static int ircc_dma=255;
 static int ircc_fir=0;
 static int ircc_sir=0;
+static int ircc_cfg=0;
 
 static unsigned short	dev_count=0;
 
@@ -393,6 +394,13 @@ int __init ircc_init(void)
 		return -ENODEV;
 	}
 
+	/* try user provided configuration register base address */
+	if (ircc_cfg>0) {
+	        MESSAGE(" Overriding configuration address 0x%04x\n", ircc_cfg);
+		if (!smc_superio_fdc(ircc_cfg))
+			ret=0;
+	}
+
 	/* Trys to open for all the SMC chipsets we know about */
 
 	IRDA_DEBUG(0, __FUNCTION__ 
@@ -402,6 +410,8 @@ int __init ircc_init(void)
 		ret=0;
 	if (!smc_superio_fdc(0x370))
 		ret=0;
+	if (!smc_superio_fdc(0xe0))
+		ret=0;
 	if (!smc_superio_lpc(0x2e))
 		ret=0;
 	if (!smc_superio_lpc(0x4e))
@@ -1229,5 +1239,7 @@ MODULE_PARM(ircc_fir, "1-4i");
 MODULE_PARM_DESC(ircc_fir, "FIR Base Address");
 MODULE_PARM(ircc_sir, "1-4i");
 MODULE_PARM_DESC(ircc_sir, "SIR Base Address");
+MODULE_PARM(ircc_cfg, "1-4i");
+MODULE_PARM_DESC(ircc_cfg, "Configuration register base address");
 
 #endif /* MODULE */
