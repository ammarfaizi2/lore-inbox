Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbRE3Aks>; Tue, 29 May 2001 20:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbRE3Akm>; Tue, 29 May 2001 20:40:42 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:64270 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262505AbRE3AkN>; Tue, 29 May 2001 20:40:13 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300041.CAA04507@green.mif.pg.gda.pl>
Subject: [PATCH] net #3
To: alan@lxorguk.ukuu.org.uk (Alan Cox), andrewm@uow.edu.au,
        p_gortmaker@yahoo.com
Date: Wed, 30 May 2001 02:41:09 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes some ISA PnP #ifdefs (enable modular,
disable when non-available) for 3c509 and smc-ultra.

Some other drivers also seem to need fixing (finishing ISA PnP support
inside them).

Andrzej

************************** PATCH 3 *****************************
diff -uNr linux-2.4.5-ac4/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.5-ac4/drivers/net/3c509.c	Wed May 30 01:09:53 2001
+++ linux/drivers/net/3c509.c	Wed May 30 01:10:45 2001
@@ -175,7 +175,7 @@
 };
 #endif /* CONFIG_MCA */
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static struct isapnp_device_id el3_isapnp_adapters[] __initdata = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5090),
@@ -201,8 +201,8 @@
 MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
 
 static u16 el3_isapnp_phys_addr[8][3];
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 static int nopnp;
-#endif /* CONFIG_ISAPNP */
 
 int __init el3_probe(struct net_device *dev)
 {
@@ -212,9 +212,10 @@
 	u16 phys_addr[3];
 	static int current_tag;
 	int mca_slot = -1;
-#ifdef CONFIG_ISAPNP
+	static int printed_version;
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	static int pnp_cards;
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	if (dev) SET_MODULE_OWNER(dev);
 
@@ -318,7 +319,7 @@
 	}
 #endif /* CONFIG_MCA */
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 1)
 		goto no_pnp;
 
@@ -354,7 +355,7 @@
 		}
 	}
 no_pnp:
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
@@ -400,7 +401,7 @@
 		phys_addr[i] = htons(id_read_eeprom(i));
 	}
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 0) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence.
 		   This check is needed in order not to register them twice. */
@@ -420,7 +421,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	{
 		unsigned int iobase = id_read_eeprom(8);
diff -uNr linux-2.4.5-ac4/drivers/net/smc-ultra.c linux/drivers/net/smc-ultra.c
--- linux-2.4.5-ac4/drivers/net/smc-ultra.c	Wed May 30 01:09:53 2001
+++ linux/drivers/net/smc-ultra.c	Wed May 30 01:10:45 2001
@@ -80,7 +80,7 @@
 int ultra_probe(struct net_device *dev);
 static int ultra_probe1(struct net_device *dev, int ioaddr);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static int ultra_probe_isapnp(struct net_device *dev);
 #endif
 
@@ -100,7 +100,7 @@
 							 const unsigned char *buf, const int start_page);
 static int ultra_close_card(struct net_device *dev);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static struct isapnp_device_id ultra_device_ids[] __initdata = {
         {       ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
                 ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
@@ -140,7 +140,7 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	/* Look for any installed ISAPnP cards */
 	if (isapnp_present() && (ultra_probe_isapnp(dev) == 0))
 		return 0;
@@ -279,7 +279,7 @@
 	return retval;
 }
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static int __init ultra_probe_isapnp(struct net_device *dev)
 {
         int i;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
