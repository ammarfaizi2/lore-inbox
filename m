Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbRGPL7Z>; Mon, 16 Jul 2001 07:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbRGPL7P>; Mon, 16 Jul 2001 07:59:15 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:10956 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267317AbRGPL64>;
	Mon, 16 Jul 2001 07:58:56 -0400
Date: Mon, 16 Jul 2001 13:58:49 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200107161158.NAA09324@harpo.it.uu.se>
To: laughing@shared-source.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Compiling 2.4.6-ac4 (x86, CONFIG_PCI) I get:

gcc -D__KERNEL__ -I/tmp/linux-2.4.6-ac4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o quirks.o quirks.c
quirks.c:112: warning: `/*' within comment
quirks.c: In function `quirk_vialatency':
quirks.c:145: warning: passing arg 3 of `pci_write_config_byte' makes integer from pointer without a cast
...
gcc -D__KERNEL__ -I/tmp/linux-2.4.6-ac4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o bluesmoke.o bluesmoke.c
bluesmoke.c:241: warning: initialization from incompatible pointer type

Of these three warnings, the second (drivers/pci/quirks.c:pci_write_config_byte)
indicates a real bug (passing a pointer to int instead of the int itself).
The patch below fixes this bug and silences the other two warnings.

/Mikael


--- linux-2.4.6-ac4/arch/i386/kernel/bluesmoke.c.~1~	Mon Jul 16 13:10:04 2001
+++ linux-2.4.6-ac4/arch/i386/kernel/bluesmoke.c	Mon Jul 16 13:25:01 2001
@@ -233,7 +233,7 @@
 	}
 }
 
-static int __init mcheck_disable(char *str, int *unused)
+static int __init mcheck_disable(char *str)
 {
 	mce_disabled = 1;
 	return 0;
--- linux-2.4.6-ac4/drivers/pci/quirks.c.~1~	Mon Jul 16 13:10:06 2001
+++ linux-2.4.6-ac4/drivers/pci/quirks.c	Mon Jul 16 13:21:40 2001
@@ -108,7 +108,7 @@
 	if(p!=NULL)
 	{
 		pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
-		/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis
+		/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
 		/* Check for buggy part revisions */
 		if (rev < 0x40 && rev > 0x42) 
 			return;
@@ -142,7 +142,7 @@
 	   "Master priority rotation on every PCI master grant */
 	busarb &= ~(1<<5);
 	busarb |= (1<<4);
-	pci_write_config_byte(dev, 0x76, &busarb);
+	pci_write_config_byte(dev, 0x76, busarb);
 	printk(KERN_INFO "Applying VIA southbridge workaround.\n");
 }
 
