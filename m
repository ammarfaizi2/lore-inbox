Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130001AbRBOUbU>; Thu, 15 Feb 2001 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbRBOUbN>; Thu, 15 Feb 2001 15:31:13 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:15805 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129528AbRBOUbE>; Thu, 15 Feb 2001 15:31:04 -0500
Message-ID: <3A8C3C85.1164DACF@inet.com>
Date: Thu, 15 Feb 2001 14:31:01 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Richard B. Johnson" <root@chaos.analogic.com>, tsbogend@alpha.franken.de,
        Peter Missel <P.Missel@sbs-or.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
In-Reply-To: <E14TRbL-0000AR-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------9564D0B5D84A1D86212F50FB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9564D0B5D84A1D86212F50FB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> > Peter pointed out that the contents of the CSR12-14 registers are
> > initialized from the EEPROM, so reading the EEPROM is superfluous--we
> > should just read the CSRs and not read the EEPROM.  I think he has a
> > point, so I'll make that change and submit yet another patch pair.
> 
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

Ok, here is the 2.4.1 version.  Note that it is slightly different from
the 2.2.18 version.  This one uses the CSRs and complains if the PROM is
different (but uses the CSRs anyway since those can be overridden by a
bootloader, etc.).

I don't have a 2.4.x tree handy that I can compile at the moment, but I
tested this change in a 2.2.x kernel, so it should be ok.

Is this patch satisfactory?

Eli
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
--------------9564D0B5D84A1D86212F50FB
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-mac24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-mac24"

--- linux/drivers/net/pcnet32.c.2.4.1	Wed Feb 14 16:49:31 2001
+++ linux/drivers/net/pcnet32.c	Thu Feb 15 13:48:05 2001
@@ -624,10 +624,35 @@
 
     printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
 
-    /* There is a 16 byte station address PROM at the base address.
-       The first six bytes are the station address. */
+    /* In most chips, after a chip reset, the ethernet address is read from the
+     * station address PROM at the base address and programmed into the
+     * "Physical Address Registers" CSR12-14.
+     * As a precautionary measure, we read the PROM values and complain if
+     * they disagree with the CSRs.  Either way, we use the CSR values, and
+     * double check that they are valid.
+     */
+    for (i = 0; i < 3; i++) {
+	unsigned int val;
+	val = a->read_csr(ioaddr, i+12) & 0x0ffff;
+	/* There may be endianness issues here. */
+	dev->dev_addr[2*i] = val & 0x0ff;
+	dev->dev_addr[2*i+1] = (val >> 8) & 0x0ff;
+    }
+    {
+	u8 promaddr[6];
+	for (i = 0; i < 6; i++) {
+	    promaddr[i] = inb(ioaddr + i);
+	}
+	if( memcmp( promaddr, dev->dev_addr, 6) )
+	    printk(" warning: PROM address does not match CSR address");
+    }
+    /* if the ethernet address is not valid, force to 00:00:00:00:00:00 */
+    if( !is_valid_ether_addr(dev->dev_addr) )
+	for (i = 0; i < 6; i++)
+	    dev->dev_addr[i]=0;
+
     for (i = 0; i < 6; i++)
-	printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
+	printk(" %2.2x", dev->dev_addr[i] );
 
     if (((chip_version + 1) & 0xfffe) == 0x2624) { /* Version 0x2623 or 0x2624 */
 	i = a->read_csr(ioaddr, 80) & 0x0C00;  /* Check tx_start_pt */
@@ -774,6 +799,10 @@
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
     }
+
+    /* Check for a valid station address */
+    if( !is_valid_ether_addr(dev->dev_addr) )
+	return -EINVAL;
 
     /* Reset the PCNET32 */
     lp->a.reset (ioaddr);
--- linux/include/linux/etherdevice.h.2.4.1	Thu Feb 15 11:25:46 2001
+++ linux/include/linux/etherdevice.h	Thu Feb 15 13:18:20 2001
@@ -45,6 +45,14 @@
 	memcpy (dest->data, src, len);
 }
 
+/* Check that the ethernet address (MAC) is not 00:00:00:00:00:00 and is not
+ * a multicast address.  Return true if the address is valid.
+ */
+static __inline__ int is_valid_ether_addr( u8 *addr )
+{
+	return !(addr[0]&1) && memcmp( addr, "\0\0\0\0\0\0", 6);
+}
+
 #endif
 
 #endif	/* _LINUX_ETHERDEVICE_H */

--------------9564D0B5D84A1D86212F50FB--

