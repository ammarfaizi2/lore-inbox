Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRBNXu6>; Wed, 14 Feb 2001 18:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130126AbRBNXut>; Wed, 14 Feb 2001 18:50:49 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:9436 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129709AbRBNXuj>; Wed, 14 Feb 2001 18:50:39 -0500
Message-ID: <3A8B19BF.ED622DE5@inet.com>
Date: Wed, 14 Feb 2001 17:50:23 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>, tsbogend@alpha.franken.de,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Missel <P.Missel@sbs-or.de>
CC: linux-kernel@vger.kernel.org, Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
In-Reply-To: <3A8AFD5B.FE981F4A@inet.com>
Content-Type: multipart/mixed;
 boundary="------------64DDDF78A54D4B27F80E537F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------64DDDF78A54D4B27F80E537F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Eli Carter wrote:
> I'm dealing with an AMD chip that does not have the station address in
> the PROM at the base address, but resides in the "Physical Address
> Registers" in the chip (thanks to the bootloader in my case).  This
> patch makes the driver try those registers if the station address read
> from the PROM is 00:00:00:00:00:00.
> I think others dealing with similar setups may find this helpful.  The
> other lance-derived drivers might benefit from a similar patch, but I
> don't have that hardware for testing.

<aside>
Added Peter since he's given feedback on a past pcnet32 patch.
</aside>

Two patches, one for 2.2.18 (patch-pcnet32-mac22), and one for 2.4.1
(patch-pcnet32-mac24) which should each apply cleanly.

Changes:
- Moved address validity check to a function.  (Should this go somewhere
other drivers can call it?)
- Check the second address and set the address to 00:00:00:00:00:00 if
it fails
- Check the address at open time as well, failing with -EINVAL.

I think that should address Alan's initial feedback.

What else?

TIA,

Eli
--------------------.              Rule of Accuracy: When working toward
Eli Carter          |               the solution of a problem, it always 
eli.carter@inet.com `--------------------- helps if you know the answer.
--------------64DDDF78A54D4B27F80E537F
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-mac24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-mac24"

--- linux/drivers/net/pcnet32.c.2.4.1	Wed Feb 14 16:49:31 2001
+++ linux/drivers/net/pcnet32.c	Wed Feb 14 17:37:23 2001
@@ -283,6 +283,7 @@
     struct net_device *next;
 };
 
+static int  is_valid_ether_addr( char* );
 static int  pcnet32_probe_vlbus(int cards_found);
 static int  pcnet32_probe_pci(struct pci_dev *, const struct pci_device_id *);
 static int  pcnet32_probe1(unsigned long, unsigned char, int, int, struct pci_dev *);
@@ -437,6 +438,18 @@
 
 
 
+/* Check that the ethernet station address is not 00:00:00:00:00:00 and is also
+ * not a multicast address
+ * Return true if the address is valid.
+ */
+int is_valid_ether_addr( char* address )
+{
+    int i,isvalid=0;
+    for( i=0; i<6; i++)
+	isvalid |= address[i]; 
+    return isvalid && !(address[0]&1);
+}
+
 /* only probes for non-PCI devices, the rest are handled by pci_register_driver via pcnet32_probe_pci*/
 static int __init pcnet32_probe_vlbus(int cards_found)
 {
@@ -624,10 +637,33 @@
 
     printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
 
-    /* There is a 16 byte station address PROM at the base address.
-       The first six bytes are the station address. */
-    for (i = 0; i < 6; i++)
-	printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
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
@@ -774,6 +810,10 @@
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
     }
+
+    /* Check for a valid station address */
+    if( !is_valid_ether_addr(dev->dev_addr) )
+	return -EINVAL;
 
     /* Reset the PCNET32 */
     lp->a.reset (ioaddr);

--------------64DDDF78A54D4B27F80E537F
Content-Type: text/plain; charset=us-ascii;
 name="patch-pcnet32-mac22"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcnet32-mac22"

diff -u -r1.1.1.6 pcnet32.c
--- linux/drivers/net/pcnet32.c	2001/01/20 11:10:30	1.1.1.6
+++ linux/drivers/net/pcnet32.c	2001/02/14 23:30:51
@@ -281,6 +281,7 @@
 #endif    
 };
 
+static int is_valid_ether_addr( char* );
 int  pcnet32_probe(struct device *);
 static int  pcnet32_probe1(struct device *, unsigned long, unsigned char, int, int);
 static int  pcnet32_open(struct device *);
@@ -442,6 +443,18 @@
 
 
 
+/* Check that the ethernet station address is not 00:00:00:00:00:00 and is also
+ * not a multicast address
+ * Return true if the address is valid.
+ */
+int is_valid_ether_addr( char* address )
+{
+    int i,isvalid=0;
+    for( i=0; i<6; i++)
+	isvalid |= address[i]; 
+    return isvalid && !(address[0]&1);
+}
+
 int __init pcnet32_probe (struct device *dev)
 {
     unsigned long ioaddr = dev ? dev->base_addr: 0;
@@ -648,10 +661,33 @@
 
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
@@ -796,6 +832,10 @@
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
     }
+
+    /* Check for a valid station address */
+    if( !is_valid_ether_addr(dev->dev_addr) )
+	return -EINVAL;
 
     /* Reset the PCNET32 */
     lp->a.reset (ioaddr);

--------------64DDDF78A54D4B27F80E537F--

