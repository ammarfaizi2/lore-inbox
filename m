Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSJ1Sun>; Mon, 28 Oct 2002 13:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSJ1Sum>; Mon, 28 Oct 2002 13:50:42 -0500
Received: from modemcable063.18-202-24.mtl.mc.videotron.ca ([24.202.18.63]:32782
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261433AbSJ1Sul>; Mon, 28 Oct 2002 13:50:41 -0500
Date: Mon, 28 Oct 2002 13:52:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <jdavid@farfalle.com>
Subject: [PATCH][2.5] 3c509 increase udelay in *read_eeprom
Message-ID: <Pine.LNX.4.44.0210281349350.1722-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,
This is David's patch, find his reasoning and patch below.

"... I had to set the udelay() call parameters to 2000 in  read_eeprom() 
and 4000 in id_read_eeprom() to get the system to boot reliably with 2 
3c509's in it. If I didn't set these values high enough, I got an oops 
about 1/3 of the time when I booted....somehow (I'm guessing) it just 
took the cards longer to initialize/respond when there were two of them 
on the bus.

I know the possibility of this (and the fix, setting the values higher) is 
mentioned in Becker's 3c509 instructions, but I wanted to relay my 
experience to you as well. Since AFAIK these subroutines are only called 
at initialization time (we don't need to read the EEPROM after init), what 
would be the harm of setting these values higher - at least 1000 for both, 
say - in the standard driver? Certainly a millisecond or two means nothing 
at boot time, and if it prevents even a few machines from mysteriously 
oopsing when they're started, it's a win overall ..."

Index: linux-2.5.44/drivers/net/3c509.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.44/drivers/net/3c509.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 3c509.c
--- linux-2.5.44/drivers/net/3c509.c	19 Oct 2002 21:12:02 -0000	1.1.1.1
+++ linux-2.5.44/drivers/net/3c509.c	28 Oct 2002 18:49:03 -0000
@@ -51,11 +51,13 @@
 			- Full duplex support
 		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
 			- Additional ethtool features
+		v1.19a 28Oct2002 Davud Ruggiero <jdr@farfalle.com>
+			- Increase *read_eeprom udelay to workaround oops with 2 cards.
 */
 
 #define DRV_NAME	"3c509"
-#define DRV_VERSION	"1.19"
-#define DRV_RELDATE	"16Oct2002"
+#define DRV_VERSION	"1.19a"
+#define DRV_RELDATE	"28Oct2002"
 
 /* A few values that may be tweaked. */
 
@@ -571,7 +573,7 @@
 {
 	outw(EEPROM_READ + index, ioaddr + 10);
 	/* Pause for at least 162 us. for the read to take place. */
-	udelay (500);
+	udelay (2000);
 	return inw(ioaddr + 12);
 }
 
@@ -585,7 +587,7 @@
 	outb(EEPROM_READ + index, id_port);
 
 	/* Pause for at least 162 us. for the read to take place. */
-	udelay (500);
+	udelay (4000);
 	
 	for (bit = 15; bit >= 0; bit--)
 		word = (word << 1) + (inb(id_port) & 0x01);


-- 
function.linuxpower.ca


