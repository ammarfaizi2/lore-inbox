Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBNVv2>; Wed, 14 Feb 2001 16:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRBNVvT>; Wed, 14 Feb 2001 16:51:19 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:53967 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129243AbRBNVvL>; Wed, 14 Feb 2001 16:51:11 -0500
Message-ID: <3A8AFD5B.FE981F4A@inet.com>
Date: Wed, 14 Feb 2001 15:49:15 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>, tsbogend@alpha.franken.de,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Eli Carter <eli.carter@inet.com>
Subject: [PATCH] pcnet32.c: MAC address may be in CSR registers
Content-Type: multipart/mixed;
 boundary="------------5226C666C17FF9F02667ED83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5226C666C17FF9F02667ED83
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

<aside>
Thomas Bogendoerfer is listed as maintainer. 
Richard, I know you've done some work with this driver so I thought you
might be interested.
Alan, I'd like to see this find its way into the official version(s), so
feedback would be appreciated if you don't apply it.  (In your copious
spare time, of course. ;) )
</aside>

I'm dealing with an AMD chip that does not have the station address in
the PROM at the base address, but resides in the "Physical Address
Registers" in the chip (thanks to the bootloader in my case).  This
patch makes the driver try those registers if the station address read
from the PROM is 00:00:00:00:00:00.
I think others dealing with similar setups may find this helpful.  The
other lance-derived drivers might benefit from a similar patch, but I
don't have that hardware for testing.

(The diff is against 2.2.18 and applies cleanly.)

If this is not acceptible or could be improved, please reply with
feedback.

TIA,

Eli 
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
--------------5226C666C17FF9F02667ED83
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-mac"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-mac"

diff -u -r1.1.1.6 pcnet32.c
--- linux/drivers/net/pcnet32.c	2001/01/20 11:10:30	1.1.1.6
+++ linux/drivers/net/pcnet32.c	2001/02/14 21:43:28
@@ -648,10 +648,32 @@
 
     printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
 
-    /* There is a 16 byte station address PROM at the base address.
-     The first six bytes are the station address. */
-    for (i = 0; i < 6; i++)
-      printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
+    /* In most chips, there is a station address PROM at the base address.
+     * However, if that does not have a valid address, try the "Physical
+     * Address Registers" CSR12-CSR14
+     * Currently, we only check for 00:00:00:00:00:00 as invalid.
+     */
+    {
+    int valid_station=0;
+	/* There is a 16 byte station address PROM at the base address.
+	 The first six bytes are the station address. */
+	for (i = 0; i < 6; i++) {
+	    unsigned int addr = inb(ioaddr + i);
+	    valid_station |= addr;
+	    dev->dev_addr[i] = addr;
+	}
+	if( !valid_station ) {
+	    for (i = 0; i < 3; i++) {
+		unsigned int v;
+		v = a->read_csr(ioaddr, i+12);
+		/* There may be endianness issues here. */
+		dev->dev_addr[2*i] = v & 0x0ff;
+		dev->dev_addr[2*i+1] = (v >> 8) & 0x0ff;
+	    }
+	}
+	for (i = 0; i < 6; i++)
+	    printk(" %2.2x", dev->dev_addr[i] );
+    }
 
     if (((chip_version + 1) & 0xfffe) == 0x2624) { /* Version 0x2623 or 0x2624 */
         i = a->read_csr(ioaddr, 80) & 0x0C00;  /* Check tx_start_pt */

--------------5226C666C17FF9F02667ED83--

