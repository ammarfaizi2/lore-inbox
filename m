Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266562AbRGDW2D>; Wed, 4 Jul 2001 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbRGDW1m>; Wed, 4 Jul 2001 18:27:42 -0400
Received: from mail.mesatop.com ([208.164.122.9]:12037 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S266562AbRGDW1f>;
	Wed, 4 Jul 2001 18:27:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.6-ac1 fix error in drivers/parport/parport_pc.c
Date: Wed, 4 Jul 2001 16:20:02 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01070416200200.01208@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error building 2.4.6-ac1.

drivers/parport/driver.o: In function `parport_pc_find_ports':
drivers/parport/driver.o(.text.init+0x3f2): undefined reference to `init_pnp040x'
drivers/parport/driver.o(.text.init+0x400): undefined reference to `pnpbios_find_device'
drivers/parport/driver.o(.text.init+0x412): undefined reference to `init_pnp040x'
drivers/parport/driver.o(.text.init+0x420): undefined reference to `pnpbios_find_device'
make: *** [vmlinux] Error 1

My access to lkml archives is temporarily gone (marc.theaimsgroup.com is down
and other archive sites aren't very current), so please forgive me if someone else 
has already posted this fix.

Here is a patch which may be correct.  It worked for me.
Steven

--- linux-2.4.6-ac1/drivers/parport/parport_pc.c.original       Wed Jul  4 15:22:28 2001
+++ linux/drivers/parport/parport_pc.c  Wed Jul  4 15:26:03 2001
@@ -2828,12 +2828,14 @@
        detect_and_report_smsc ();
 #endif
 
+#if defined (CONFIG_PNPBIOS) || defined (CONFIG_PNPBIOS_MODULE)
        dev=NULL;
        while ((dev=pnpbios_find_device("PNP0400",dev)))
                count+=init_pnp040x(dev);
        dev=NULL;
         while ((dev=pnpbios_find_device("PNP0401",dev)))
                 count+=init_pnp040x(dev);
+#endif
 
        /* Onboard SuperIO chipsets that show themselves on the PCI bus. */
        count += parport_pc_init_superio (autoirq, autodma);
