Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbRENSge>; Mon, 14 May 2001 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbRENSgZ>; Mon, 14 May 2001 14:36:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44218 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262370AbRENSgP>;
	Mon, 14 May 2001 14:36:15 -0400
Message-ID: <3B002595.76399CE4@mandrakesoft.com>
Date: Mon, 14 May 2001 14:36:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mads Martin =?iso-8859-1?Q?J=F8rgensen?= <mmj@suse.com>
Cc: "H . J . Lu" <hjl@lucon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH 2.4.4.ac9: Tulip net driver fixes
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com> <20010514112216.A25436@lucon.org> <20010514112407.E781@suse.com>
Content-Type: multipart/mixed;
 boundary="------------2314BA1007B2BF85E3CDD4D7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2314BA1007B2BF85E3CDD4D7
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Mads Martin Jørgensen wrote:
> 
> * H . J . Lu <hjl@lucon.org> [May 14. 2001 11:22]:
> > On Sat, May 12, 2001 at 03:25:34PM -0400, Jeff Garzik wrote:
> > > Attached is a patch against 2.4.4-ac8 which includes several fixes to
> > > the Tulip driver.  This should fix the reported PNIC problems, as well
> > > as problems with forcing media on MII phys and several other bugs.
> >
> > Your patch doesn't apply to 2.4.4-ac8 cleanly:
> 
> No, I noticed that too. But the 1.1.6 from
> http://sourceforge.net/projects/tulip/ works fine here.

Attached is a patch against 2.4.4-ac9 which includes the changes found
in tulip-devel 1.1.6...   (tulip-devel is sort of a misnomer; right now
it's really just a staging and testing point for fixes which go straight
into the tulip-stable series)

I just checked against ac9 and it applies cleanly here.

Note after I re-test with a bunch of net cards, tulip-devel 1.1.7 should
be out today or tomorrow.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------2314BA1007B2BF85E3CDD4D7
Content-Type: text/plain; charset=us-ascii;
 name="tulip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip.patch"

diff -urN linux.ac9/drivers/net/tulip/ChangeLog linux.tulip/drivers/net/tulip/ChangeLog
--- linux.ac9/drivers/net/tulip/ChangeLog	Mon May 14 13:50:59 2001
+++ linux.tulip/drivers/net/tulip/ChangeLog	Mon May 14 14:28:49 2001
@@ -1,3 +1,49 @@
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* tulip_core (tulip_init_one): Do not call
+	unregister_netdev in error cleanup.  Remnant of old
+	usage of init_etherdev.
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* media.c (tulip_find_mii): Simple write the updated BMCR
+	twice, as it seems the best thing to do for both broken and
+	sane chips.
+	If the mii_advert value, as read from MII_ADVERTISE, is zero,
+	then generate a value we should advertise from the capability
+	bits in BMSR.
+	Fill in tp->advertising for all cases.
+	Just to be safe, clear all unwanted bits.
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* tulip_core.c (private_ioctl):  Fill in tp->advertising
+	when advertising value is changed by the user.
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* tulip_core.c: Mark Comet chips as needed the updated MWI
+	csr0 configuration.
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* media.c, tulip_core.c:  Move MII scan into
+	from inlined inside tulip_init_one to new function
+	tulip_find_mii in media.c.
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* media.c (tulip_check_duplex):
+	Only restart Rx/Tx engines if they are active
+	(and csr6 changes)
+
+2001-05-12  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* tulip_core.c (tulip_mwi_config):
+	Clamp values read from PCI cache line size register to
+	values acceptable to tulip chip.  Done for safety and
+	-almost- certainly unneeded.
+
 2001-05-11  Jeff Garzik  <jgarzik@mandrakesoft.com>
 
 	* tulip_core.c (tulip_init_one):
@@ -93,15 +139,15 @@
 
 2001-05-09  Jeff Garzik  <jgarzik@mandrakesoft.com>
 
-        * 21142.c (t21142_lnk_change): Pass arg startup==1
-        to tulip_select_media, in order to force csr13 to be
-        zeroed out prior to going to full duplex mode.  Fixes
-        autonegotiation on a quad-port Znyx card.
-        (from Stephen Dengler)
+	* 21142.c (t21142_lnk_change): Pass arg startup==1
+	to tulip_select_media, in order to force csr13 to be
+	zeroed out prior to going to full duplex mode.  Fixes
+	autonegotiation on a quad-port Znyx card.
+	(from Stephen Dengler)
 
 2001-05-09  Russell King  <rmk@arm.linux.org.uk>
 
-        * interrupt.c: Better PCI bus error reporting.
+	* interrupt.c: Better PCI bus error reporting.
 
 2001-04-03  Jeff Garzik  <jgarzik@mandrakesoft.com>
 
@@ -134,7 +180,7 @@
 	  the following defines existed.  These defines were never used
 	  by normal users in practice: TULIP_FULL_DUPLEX,
 	  TULIP_DEFAULT_MEDIA, and TULIP_NO_MEDIA_SWITCH.
-	  
+
 	* tulip.h, eeprom.c: Move EE_* constants from tulip.h to eeprom.c.
 	* tulip.h, media.c: Move MDIO_* constants from tulip.h to media.c.
 
diff -urN linux.ac9/drivers/net/tulip/media.c linux.tulip/drivers/net/tulip/media.c
--- linux.ac9/drivers/net/tulip/media.c	Mon May 14 13:50:59 2001
+++ linux.tulip/drivers/net/tulip/media.c	Mon May 14 14:28:49 2001
@@ -16,6 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/mii.h>
+#include <linux/init.h>
+#include <linux/delay.h>
 #include "tulip.h"
 
 
@@ -409,6 +411,7 @@
   */
 int tulip_check_duplex(struct net_device *dev)
 {
+	long ioaddr = dev->base_addr;
 	struct tulip_private *tp = dev->priv;
 	unsigned int bmsr, lpa, negotiated, new_csr6;
 
@@ -439,7 +442,10 @@
 	else		     new_csr6 &= ~FullDuplex;
 
 	if (new_csr6 != tp->csr6) {
-		tulip_restart_rxtx(tp, new_csr6);
+		if (inl(ioaddr + CSR6) & (csr6_st | csr6_sr))
+			tulip_restart_rxtx(tp, new_csr6);
+		else
+			outl(new_csr6, ioaddr + CSR6);
 		tp->csr6 = new_csr6;
 
 		if (tulip_debug > 0)
@@ -451,4 +457,111 @@
 	}
 
 	return 0;
+}
+
+void __devinit tulip_find_mii (struct net_device *dev, int board_idx)
+{
+	struct tulip_private *tp = dev->priv;
+	int phyn, phy_idx = 0;
+	int mii_reg0;
+	int mii_advert;
+	unsigned int to_advert, new_bmcr, ane_switch;
+
+	/* Find the connected MII xcvrs.
+	   Doing this in open() would allow detecting external xcvrs later,
+	   but takes much time. */
+	for (phyn = 1; phyn <= 32 && phy_idx < sizeof (tp->phys); phyn++) {
+		int phy = phyn & 0x1f;
+		int mii_status = tulip_mdio_read (dev, phy, MII_BMSR);
+		if ((mii_status & 0x8301) == 0x8001 ||
+		    ((mii_status & BMSR_100BASE4) == 0
+		     && (mii_status & 0x7800) != 0)) {
+			/* preserve Becker logic, gain indentation level */
+		} else {
+			continue;
+		}
+
+		mii_reg0 = tulip_mdio_read (dev, phy, MII_BMCR);
+		mii_advert = tulip_mdio_read (dev, phy, MII_ADVERTISE);
+		ane_switch = 0;
+
+		/* if not advertising at all, gen an
+		 * advertising value from the capability
+		 * bits in BMSR
+		 */
+		if ((mii_advert & ADVERTISE_ALL) == 0) {
+			unsigned int tmpadv = tulip_mdio_read (dev, phy, MII_BMSR);
+			mii_advert = ((tmpadv >> 6) & 0x3e0) | 1;
+		}
+
+		if (tp->mii_advertise) {
+			tp->advertising[phy_idx] =
+			to_advert = tp->mii_advertise;
+		} else if (tp->advertising[phy_idx]) {
+			to_advert = tp->advertising[phy_idx];
+		} else {
+			tp->advertising[phy_idx] =
+			tp->mii_advertise =
+			to_advert = mii_advert;
+		}
+
+		tp->phys[phy_idx++] = phy;
+
+		printk (KERN_INFO "tulip%d:  MII transceiver #%d "
+			"config %4.4x status %4.4x advertising %4.4x.\n",
+			board_idx, phy, mii_reg0, mii_status, mii_advert);
+
+		/* Fixup for DLink with miswired PHY. */
+		if (mii_advert != to_advert) {
+			printk (KERN_DEBUG "tulip%d:  Advertising %4.4x on PHY %d,"
+				" previously advertising %4.4x.\n",
+				board_idx, to_advert, phy, mii_advert);
+			tulip_mdio_write (dev, phy, 4, to_advert);
+		}
+
+		/* Enable autonegotiation: some boards default to off. */
+		if (tp->default_port == 0) {
+			new_bmcr = mii_reg0 | BMCR_ANENABLE;
+			if (new_bmcr != mii_reg0) {
+				new_bmcr |= BMCR_ANRESTART;
+				ane_switch = 1;
+			}
+		}
+		/* ...or disable nway, if forcing media */
+		else {
+			new_bmcr = mii_reg0 & ~BMCR_ANENABLE;
+			if (new_bmcr != mii_reg0)
+				ane_switch = 1;
+		}
+
+		/* clear out bits we never want at this point */
+		new_bmcr &= ~(BMCR_CTST | BMCR_FULLDPLX | BMCR_ISOLATE |
+			      BMCR_PDOWN | BMCR_SPEED100 | BMCR_LOOPBACK |
+			      BMCR_RESET);
+
+		if (tp->full_duplex)
+			new_bmcr |= BMCR_FULLDPLX;
+		if (tulip_media_cap[tp->default_port] & MediaIs100)
+			new_bmcr |= BMCR_SPEED100;
+
+		if (new_bmcr != mii_reg0) {
+			/* some phys need the ANE switch to
+			 * happen before forced media settings
+			 * will "take."  However, we write the
+			 * same value twice in order not to
+			 * confuse the sane phys.
+			 */
+			if (ane_switch) {
+				tulip_mdio_write (dev, phy, MII_BMCR, new_bmcr);
+				udelay (10);
+			}
+			tulip_mdio_write (dev, phy, MII_BMCR, new_bmcr);
+		}
+	}
+	tp->mii_cnt = phy_idx;
+	if (tp->mtable && tp->mtable->has_mii && phy_idx == 0) {
+		printk (KERN_INFO "tulip%d: ***WARNING***: No MII transceiver found!\n",
+			board_idx);
+		tp->phys[0] = 1;
+	}
 }
diff -urN linux.ac9/drivers/net/tulip/tulip.h linux.tulip/drivers/net/tulip/tulip.h
--- linux.ac9/drivers/net/tulip/tulip.h	Mon May 14 13:50:59 2001
+++ linux.tulip/drivers/net/tulip/tulip.h	Mon May 14 14:28:49 2001
@@ -404,6 +417,7 @@
 void tulip_mdio_write(struct net_device *dev, int phy_id, int location, int value);
 void tulip_select_media(struct net_device *dev, int startup);
 int tulip_check_duplex(struct net_device *dev);
+void tulip_find_mii (struct net_device *dev, int board_idx);
 
 /* pnic.c */
 void pnic_do_nway(struct net_device *dev);
diff -urN linux.ac9/drivers/net/tulip/tulip_core.c linux.tulip/drivers/net/tulip/tulip_core.c
--- linux.ac9/drivers/net/tulip/tulip_core.c	Mon May 14 13:50:59 2001
+++ linux.tulip/drivers/net/tulip/tulip_core.c	Mon May 14 14:28:49 2001
@@ -24,7 +24,7 @@
 #include <asm/unaligned.h>
 
 static char version[] __devinitdata =
-	"Linux Tulip driver version 0.9.14g (May 11, 2001)\n";
+	"Linux Tulip driver version 0.9.14h (May 12, 2001)\n";
 
 
 /* A few user-configurable values. */
@@ -824,7 +824,8 @@
 	struct tulip_private *tp = dev->priv;
 	long ioaddr = dev->base_addr;
 	u16 *data = (u16 *) & rq->ifr_data;
-	int phy = tp->phys[0] & 0x1f;
+	const unsigned int phy_idx = 0;
+	int phy = tp->phys[phy_idx] & 0x1f;
 	unsigned int regnum = data[1];
 
 	switch (cmd) {
@@ -886,7 +887,10 @@
 				if (tp->full_duplex_lock)
 					tp->full_duplex = (value & 0x0100) ? 1 : 0;
 				break;
-			case 4: tp->mii_advertise = data[2]; break;
+			case 4:
+				tp->advertising[phy_idx] =
+				tp->mii_advertise = data[2];
+				break;
 			}
 		}
 		if (data[0] == 32 && (tp->flags & HAS_NWAY)) {
@@ -1167,6 +1171,19 @@
 	if (!pci_cacheline || (tp->chip_id == DC21143 && tp->revision == 65))
 		mwi = 0;
 
+	/* re-clamp cache line values to ones supported by tulip */
+	/* From this point forward, 'pci_cacheline' is really
+	 * the value used for csr0 cache alignment and
+	 * csr0 programmable burst length
+	 */
+	switch (pci_cacheline) {
+	case 0:
+	case 8:
+	case 16:
+	case 32: break;
+	default: pci_cacheline = TULIP_MIN_CACHE_LINE; break;
+	}
+
 	/* set or disable MWI in the standard PCI command bit.
 	 * Check for the case where  mwi is desired but not available
 	 */
@@ -1497,7 +1521,6 @@
 	if ((tp->flags & ALWAYS_CHECK_MII) ||
 		(tp->mtable  &&  tp->mtable->has_mii) ||
 		( ! tp->mtable  &&  (tp->flags & HAS_MII))) {
-		int phyn, phy_idx = 0;
 		if (tp->mtable  &&  tp->mtable->has_mii) {
 			for (i = 0; i < tp->mtable->leafcount; i++)
 				if (tp->mtable->mleaf[i].media == 11) {
@@ -1508,69 +1531,11 @@
 					break;
 				}
 		}
-		/* Find the connected MII xcvrs.
-		   Doing this in open() would allow detecting external xcvrs later,
-		   but takes much time. */
-		for (phyn = 1; phyn <= 32 && phy_idx < sizeof(tp->phys); phyn++) {
-			int phy = phyn & 0x1f;
-			int mii_status = tulip_mdio_read(dev, phy, 1);
-			if ((mii_status & 0x8301) == 0x8001 ||
-				((mii_status & 0x8000) == 0  && (mii_status & 0x7800) != 0)) {
-				int mii_reg0 = tulip_mdio_read(dev, phy, 0);
-				int mii_advert = tulip_mdio_read(dev, phy, 4);
-				unsigned int to_advert, new_bmcr;
-
-				if (tp->mii_advertise)
-					to_advert = tp->mii_advertise;
-				else if (tp->advertising[phy_idx])
-					to_advert = tp->advertising[phy_idx];
-				else
-					tp->mii_advertise = to_advert = mii_advert;
-
-				tp->phys[phy_idx++] = phy;
-
-				printk(KERN_INFO "tulip%d:  MII transceiver #%d "
-					   "config %4.4x status %4.4x advertising %4.4x.\n",
-					   board_idx, phy, mii_reg0, mii_status, mii_advert);
-				/* Fixup for DLink with miswired PHY. */
-				if (mii_advert != to_advert) {
-					printk(KERN_DEBUG "tulip%d:  Advertising %4.4x on PHY %d,"
-						   " previously advertising %4.4x.\n",
-						   board_idx, to_advert, phy, mii_advert);
-					tulip_mdio_write(dev, phy, 4, to_advert);
-				}
-
-				/* Enable autonegotiation: some boards default to off. */
-				if (tp->default_port == 0) {
-					new_bmcr = mii_reg0 | BMCR_ANENABLE;
-					if (new_bmcr != mii_reg0)
-						new_bmcr |= BMCR_ANRESTART;
-				}
-				/* ...or disable nway, if forcing media */
-				else
-					new_bmcr = mii_reg0 & ~BMCR_ANENABLE;
-
-				if (new_bmcr != mii_reg0)
-					tulip_mdio_write(dev, phy, MII_BMCR, new_bmcr);
 
-				if (tp->full_duplex) new_bmcr |= BMCR_FULLDPLX;
-				else		     new_bmcr &= ~BMCR_FULLDPLX;
-				if (tulip_media_cap[tp->default_port] & MediaIs100)
-					new_bmcr |= BMCR_SPEED100;
-				else    new_bmcr &= ~BMCR_SPEED100;
-
-				if (new_bmcr != mii_reg0) {
-					udelay(10);
-					tulip_mdio_write(dev, phy, MII_BMCR, new_bmcr);
-				}
-			}
-		}
-		tp->mii_cnt = phy_idx;
-		if (tp->mtable  &&  tp->mtable->has_mii  &&  phy_idx == 0) {
-			printk(KERN_INFO "tulip%d: ***WARNING***: No MII transceiver found!\n",
-			       board_idx);
-			tp->phys[0] = 1;
-		}
+		/* Find the connected MII xcvrs.
+		   Doing this in open() would allow detecting external xcvrs
+		   later, but takes much time. */
+		tulip_find_mii (dev, board_idx);
 	}
 
 	/* The Tulip-specific entries in the device structure. */

--------------2314BA1007B2BF85E3CDD4D7--

