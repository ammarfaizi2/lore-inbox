Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSB0C67>; Tue, 26 Feb 2002 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291756AbSB0C6t>; Tue, 26 Feb 2002 21:58:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291745AbSB0C6a> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 21:58:30 -0500
Date: Tue, 26 Feb 2002 18:56:30 -0800 (PST)
Message-Id: <20020226.185630.104030430.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020226164044.A7726@stud.ntnu.no>
In-Reply-To: <20020226145730.A20268@stud.ntnu.no>
	<20020226.065941.39167730.davem@redhat.com>
	<20020226164044.A7726@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 26 Feb 2002 16:40:44 +0100
   
   tg3.c:v0.90 (Feb 25, 2002)
   DEBUG: read_partno returns -19
   tg3: Problem fetching invariants of chip, aborting.

Great, now add the following patch below and let me know what it does
and prints out now.

If the module still fails to load because of the -EBUSY error (ie. the
"read_partno returns -19" thing happens again), bring
drivers/net/tg3.c into an editor and go to around line 4185 and change
the line that reads:

	while (--limit) {

into:

	while (1) {

And see if it works then.  PLEASE type sync a few times before trying
to load the module in this case as it could very well hang your
machine.

Thanks again for all the testing so far:

--- drivers/net/tg3.c.~2~	Mon Feb 25 17:51:41 2002
+++ drivers/net/tg3.c	Tue Feb 26 18:51:33 2002
@@ -4168,16 +4168,18 @@
 static int __devinit tg3_read_partno(struct tg3 *tp)
 {
 	unsigned char vpd_data[256];
+	unsigned int smallest_limit = ~0U;
 	int i;
 
 	/* Enable seeprom accesses. */
-	tw32(GRC_LOCAL_CTRL, GRC_LCLCTRL_AUTO_SEEPROM);
+	tw32(GRC_LOCAL_CTRL,
+	     tr32(GRC_LOCAL_CTRL) | GRC_LCLCTRL_AUTO_SEEPROM);
 	udelay(100);
 
 	for (i = 0; i < 256; i += 4) {
 		u32 tmp;
 		u16 stat;
-		int limit = 5000;
+		unsigned int limit = 100000;
 
 		pci_write_config_word(tp->pdev, TG3PCI_VPD_ADDR_FLAG, i);
 		while (--limit) {
@@ -4188,6 +4190,8 @@
 		}
 		if (!limit)
 			return -EBUSY;
+		if (limit < smallest_limit)
+			smallest_limit = limit;
 
 		pci_read_config_dword(tp->pdev, TG3PCI_VPD_DATA, &tmp);
 
@@ -4196,6 +4200,8 @@
 		vpd_data[i + 2] = ((tmp >> 16) & 0xff);
 		vpd_data[i + 3] = ((tmp >> 24) & 0xff);
 	}
+
+	printk("DEBUG: smallest_limit is %u\n", smallest_limit);
 
 	/* Now parse and find the part number. */
 	for (i = 0; i < 256; ) {
