Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129326AbRBOTQ4>; Thu, 15 Feb 2001 14:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRBOTQq>; Thu, 15 Feb 2001 14:16:46 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:23733 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129326AbRBOTQi>; Thu, 15 Feb 2001 14:16:38 -0500
Message-ID: <3A8C2B0F.A9EC2300@inet.com>
Date: Thu, 15 Feb 2001 13:16:31 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Richard B. Johnson" <root@chaos.analogic.com>, tsbogend@alpha.franken.de,
        Peter Missel <P.Missel@sbs-or.de>, linux-kernel@vger.kernel.org,
        eli.carter@inet.com
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
In-Reply-To: <E14TRbL-0000AR-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------96C2D79B143A8AE41EA32F9C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------96C2D79B143A8AE41EA32F9C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> I'd rather keep the existing initialisation behaviour of using the eeprom
> for 2.2. There are also some power management cases where I am not sure
> the values are restored on the pcnet/pci.
> 
> For 2.2 conservatism is the key. For 2.4 by all means default to CSR12-14 and
> print a warning if they dont match the eeprom value and we'll see what it
> shows
> 
> > Alan, do you want me to put your inline version in <linux/etherdevice.h>
> > while I'm at it, or what?
> 
> Sure

Here is the 2.2.18 patch... I'll send the 2.4.1 patch shortly.

This one still uses the PROM since we are going for least change in
initialization.
is_valid_ether_addr() is static inline in <linux/etherdevice.h>

Is this one satisfactory?

Eli
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
--------------96C2D79B143A8AE41EA32F9C
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-mac22"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-mac22"

--- linux/drivers/net/pcnet32.c	2001/01/20 11:10:30	1.1.1.6
+++ linux/drivers/net/pcnet32.c	2001/02/15 19:08:55
@@ -648,10 +648,33 @@
 
     printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
 
-    /* There is a 16 byte station address PROM at the base address.
-     The first six bytes are the station address. */
-    for (i = 0; i < 6; i++)
-      printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
+    /* In most chips, there is a station address PROM at the base address.
+     * However, if that does not have a valid address, try the "Physical
+     * Address Registers" CSR12-CSR14
+     */
+    {
+	/* There is a 16 byte station address PROM at the base address.
+	 The first six bytes are the station address. */
+	for (i = 0; i < 6; i++) {
+	    dev->dev_addr[i] = inb(ioaddr + i);
+	}
+	if( !is_valid_ether_addr(dev->dev_addr) ) {
+	    /* also double check this station address */
+	    for (i = 0; i < 3; i++) {
+		unsigned int val;
+		val = a->read_csr(ioaddr, i+12) & 0x0ffff;
+		/* There may be endianness issues here. */
+		dev->dev_addr[2*i] = val & 0x0ff;
+		dev->dev_addr[2*i+1] = (val >> 8) & 0x0ff;
+	    }
+	    /* if this is not valid either, force to 00:00:00:00:00:00 */
+	    if( !is_valid_ether_addr(dev->dev_addr) )
+		for (i = 0; i < 6; i++)
+		    dev->dev_addr[i]=0;
+	}
+	for (i = 0; i < 6; i++)
+	    printk(" %2.2x", dev->dev_addr[i] );
+    }
 
     if (((chip_version + 1) & 0xfffe) == 0x2624) { /* Version 0x2623 or 0x2624 */
         i = a->read_csr(ioaddr, 80) & 0x0C00;  /* Check tx_start_pt */
@@ -796,6 +819,10 @@
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
     }
+
+    /* Check for a valid station address */
+    if( !is_valid_ether_addr(dev->dev_addr) )
+	return -EINVAL;
 
     /* Reset the PCNET32 */
     lp->a.reset (ioaddr);
--- linux/include/linux/etherdevice.h	2001/01/19 19:25:31	1.1.1.1
+++ linux/include/linux/etherdevice.h	2001/02/15 19:08:55
@@ -51,6 +51,14 @@
 				unsigned char *src, int length, int base);
 #endif
 
+/* Check that the ethernet address (MAC) is not 00:00:00:00:00:00 and is not
+ * a multicast address.  Return true if the address is valid.
+ */
+static __inline__ int is_valid_ether_addr( u8 *addr )
+{
+    return !(addr[0]&1) && memcmp( addr, "\0\0\0\0\0\0", 6);
+}
+
 #endif
 
 #endif	/* _LINUX_ETHERDEVICE_H */

--------------96C2D79B143A8AE41EA32F9C--

