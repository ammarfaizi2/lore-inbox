Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132823AbRAKTAD>; Thu, 11 Jan 2001 14:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRAKS7y>; Thu, 11 Jan 2001 13:59:54 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:13042 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S132798AbRAKS7j>; Thu, 11 Jan 2001 13:59:39 -0500
Date: Thu, 11 Jan 2001 15:12:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lance.c: check kmalloc return and get rid of check_region
Message-ID: <20010111151212.L5473@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010111144829.J5473@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111144829.J5473@conectiva.com.br>; from acme@conectiva.com.br on Thu, Jan 11, 2001 at 02:48:29PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac6/drivers/net/lance.c	Wed Jan 10 22:31:42 2001
+++ linux-2.4.0-ac6.acme/drivers/net/lance.c	Thu Jan 11 15:08:06 2001
@@ -33,6 +33,9 @@
     
     Forward ported v1.14 to 2.1.129, merged the PCI and misc changes from
     the 2.1 version of the old driver - Alan Cox
+
+    Get rid of check_region, check kmalloc return in lance_probe1
+    Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 11/01/2001
 */
 
 static const char *version = "lance.c:v1.15ac 1999/11/13 dplatt@3do.com, becker@cesdis.gsfc.nasa.gov\n";
@@ -352,17 +355,27 @@
 
 	for (port = lance_portlist; *port; port++) {
 		int ioaddr = *port;
+		struct resource *r = request_region(ioaddr, LANCE_TOTAL_SIZE,
+							"lance-probe");
 
-		if ( check_region(ioaddr, LANCE_TOTAL_SIZE) == 0) {
+		if (r) {
 			/* Detect "normal" 0x57 0x57 and the NI6510EB 0x52 0x44
 			   signatures w/ minimal I/O reads */
 			char offset15, offset14 = inb(ioaddr + 14);
 			
 			if ((offset14 == 0x52 || offset14 == 0x57) &&
-				((offset15 = inb(ioaddr + 15)) == 0x57 || offset15 == 0x44)) {
+				((offset15 = inb(ioaddr + 15)) == 0x57 ||
+				 offset15 == 0x44)) {
 				result = lance_probe1(dev, ioaddr, 0, 0);
-				if ( !result ) return 0;
+				if (!result) {
+					struct lance_private *lp = dev->priv;
+					int ver = lp->chip_version;
+
+					r->name = chip_table[ver].name;
+					return 0;
+				}
 			}
+			release_resource(r);
 		}
 	}
 	return -ENODEV;
@@ -444,12 +457,10 @@
 		printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
 
 	dev->base_addr = ioaddr;
-	request_region(ioaddr, LANCE_TOTAL_SIZE, chip_table[lance_version].name);
-
 	/* Make certain the data structures used by the LANCE are aligned and DMAble. */
 		
 	lp = (struct lance_private *)(((unsigned long)kmalloc(sizeof(*lp)+7,
-										   GFP_DMA | GFP_KERNEL)+7) & ~7);
+					   GFP_DMA | GFP_KERNEL)+7) & ~7);
 	if(lp==NULL)
 		return -ENODEV;
 	if (lance_debug > 6) printk(" (#0x%05lx)", (unsigned long)lp);
@@ -457,11 +468,16 @@
 	dev->priv = lp;
 	lp->name = chipname;
 	lp->rx_buffs = (unsigned long)kmalloc(PKT_BUF_SZ*RX_RING_SIZE,
+
+	if (!lp->rx_buffs)
+		goto out_lp;
 										  GFP_DMA | GFP_KERNEL);
-	if (lance_need_isa_bounce_buffers)
+	if (lance_need_isa_bounce_buffers) {
 		lp->tx_bounce_buffs = kmalloc(PKT_BUF_SZ*TX_RING_SIZE,
-									  GFP_DMA | GFP_KERNEL);
-	else
+						  GFP_DMA | GFP_KERNEL);
+		if (!lp->tx_bounce_buffs)
+			goto out_rx;
+	} else
 		lp->tx_bounce_buffs = NULL;
 
 	lp->chip_version = lance_version;
@@ -628,6 +644,9 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	return 0;
+out_rx:	kfree(lp->rx_buffs);
+out_lp:	kfree(lp);
+	return -ENOMEM;
 }
 
 static int
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
