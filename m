Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135859AbRELAty>; Fri, 11 May 2001 20:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143441AbRELAto>; Fri, 11 May 2001 20:49:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:8091 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135859AbRELAta>;
	Fri, 11 May 2001 20:49:30 -0400
Message-ID: <3AFC8896.47AA1481@mandrakesoft.com>
Date: Fri, 11 May 2001 20:49:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        " Mads Martin =?iso-8859-1?Q?J=F8rgensen?=" <mmj@suse.com>
Subject: Re: 2.4.4-ac8 doesn't work with Lite-On 82c168 PNIC rev 32
In-Reply-To: <20010511165749.B12289@lucon.org>
Content-Type: multipart/mixed;
 boundary="------------1004EE8B60ED47C4331FED5A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1004EE8B60ED47C4331FED5A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Does this patch, against ac8, help with the PNIC problem?
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------1004EE8B60ED47C4331FED5A
Content-Type: text/plain; charset=us-ascii;
 name="tulip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip.patch"

Index: drivers/net/tulip/media.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/tulip/media.c,v
retrieving revision 1.1.1.30
diff -u -r1.1.1.30 media.c
--- drivers/net/tulip/media.c	2001/05/11 23:58:47	1.1.1.30
+++ drivers/net/tulip/media.c	2001/05/12 00:47:16
@@ -255,7 +255,7 @@
 		case 1: case 3: {
 			int phy_num = p[0];
 			int init_length = p[1];
-			u16 *misc_info;
+			u16 *misc_info, tmp_info;
 
 			dev->if_port = 11;
 			new_csr6 = 0x020E0000;
@@ -282,8 +282,10 @@
 				for (i = 0; i < init_length; i++)
 					outl(init_sequence[i], ioaddr + CSR12);
 			}
-			tp->advertising[phy_num] = get_u16(&misc_info[1]) | 1;
-			if (startup < 2) {
+			tmp_info = get_u16(&misc_info[1]);
+			if (tmp_info)
+				tp->advertising[phy_num] = tmp_info | 1;
+			if (tmp_info && startup < 2) {
 				if (tp->mii_advertise == 0)
 					tp->mii_advertise = tp->advertising[phy_num];
 				if (tulip_debug > 1)
Index: drivers/net/tulip/tulip_core.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/tulip/tulip_core.c,v
retrieving revision 1.1.1.43
diff -u -r1.1.1.43 tulip_core.c
--- drivers/net/tulip/tulip_core.c	2001/05/11 23:58:48	1.1.1.43
+++ drivers/net/tulip/tulip_core.c	2001/05/12 00:47:17
@@ -20,10 +20,11 @@
 #include <linux/init.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
+#include <linux/mii.h>
 #include <asm/unaligned.h>
 
 static char version[] __devinitdata =
-	"Linux Tulip driver version 0.9.14f (May 10, 2001)\n";
+	"Linux Tulip driver version 0.9.15cvs (April XX, 2001)\n";
 
 
 /* A few user-configurable values. */
@@ -1434,7 +1435,7 @@
 				((mii_status & 0x8000) == 0  && (mii_status & 0x7800) != 0)) {
 				int mii_reg0 = tulip_mdio_read(dev, phy, 0);
 				int mii_advert = tulip_mdio_read(dev, phy, 4);
-				int to_advert;
+				unsigned int to_advert, new_bmcr;
 
 				if (tp->mii_advertise)
 					to_advert = tp->mii_advertise;
@@ -1455,10 +1456,30 @@
 						   board_idx, to_advert, phy, mii_advert);
 					tulip_mdio_write(dev, phy, 4, to_advert);
 				}
+
 				/* Enable autonegotiation: some boards default to off. */
-				tulip_mdio_write(dev, phy, 0, mii_reg0 |
-						   (tp->full_duplex ? 0x1100 : 0x1000) |
-						   (tulip_media_cap[tp->default_port]&MediaIs100 ? 0x2000:0));
+				if (tp->default_port == 0) {
+					new_bmcr = mii_reg0 | BMCR_ANENABLE;
+					if (new_bmcr != mii_reg0)
+						new_bmcr |= BMCR_ANRESTART;
+				}
+				/* ...or disable nway, if forcing media */
+				else
+					new_bmcr = mii_reg0 & ~BMCR_ANENABLE;
+
+				if (new_bmcr != mii_reg0)
+					tulip_mdio_write(dev, phy, MII_BMCR, new_bmcr);
+
+				if (tp->full_duplex) new_bmcr |= BMCR_FULLDPLX;
+				else		     new_bmcr &= ~BMCR_FULLDPLX;
+				if (tulip_media_cap[tp->default_port] & MediaIs100)
+					new_bmcr |= BMCR_SPEED100;
+				else    new_bmcr &= ~BMCR_SPEED100;
+
+				if (new_bmcr != mii_reg0) {
+					udelay(10);
+					tulip_mdio_write(dev, phy, MII_BMCR, new_bmcr);
+				}
 			}
 		}
 		tp->mii_cnt = phy_idx;

--------------1004EE8B60ED47C4331FED5A--

