Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRFLRKW>; Tue, 12 Jun 2001 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbRFLRKM>; Tue, 12 Jun 2001 13:10:12 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:14501 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262719AbRFLRKD>; Tue, 12 Jun 2001 13:10:03 -0400
Date: Tue, 12 Jun 2001 19:09:25 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106121835340.22227-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Jeff Garzik wrote:

> Comments appreciated.

Some general comments first, the others are spread through the code.

- I don't know what the long-term plan is about ethtool vs. MII ioctl's.
If you do plan to replace completely the MII ioctl's, there should be a
way to access _all_ MII registers provided by the PHY, even if you do this
in a restricted way (i.e. for CAP_NET_ADMIN only). There is also useful
info in other registers than the 4 you have in your implementation.
- You are proposing some caching for the MII registers. I suppose that you
would like to have this code also working with whatever caching will be
done for MII access that was recently discussed. Wouldn't this produce
double caching under some circumstances ?

+	int speed;		/* 10, 100, 1000 or -1 (ask hw)		*/

Please note that the comment specifies 1000, while the code in several
places assumes only 2 possibilities: 10 and 100.

+	if (mii->autoneg < 0)
+		autoneg = mii->autoneg = (bmcr & BMCR_ANENABLE) ? 1 : 0;
+	else	autoneg = mii->autoneg;

You don't read anything from the hardware at this point. Why do you want
caching ?

Not related: I know that this comes from David Miller's older work, but
wouldn't be possible to have a more uniform naming scheme ? You have
BMCR_ANENABLE, but you have BMSR_ANEGCAPABLE...

+	if (mii->full_duplex < 0)
+		full_duplex = mii->full_duplex =
+			mii_nway_result(negotiated) & LPA_DUPLEX;
+	else	full_duplex = mii->full_duplex;

If autoneg. is disabled, I don't think that you always get useful info in
'negotiated'. Applies to the next chunk, too.

+	if (mii->speed < 0) {
+		if (negotiated & LPA_100)
+			speed = mii->speed = 100;
+		else
+			speed = mii->speed = 10;
+	} else
+		speed = mii->speed;

That's one of the places where you don't have 1000...

+	ecmd->speed = speed == 100 ? SPEED_100 : SPEED_10;

... and that's the second.

+	ecmd->transceiver = XCVR_INTERNAL;

I didn't understand what XCVR_INTERNAL should mean as opposed to
XCVR_EXTERNAL or whatever. For example: some older 3Com cards use external
transceivers (not on the chip), while newer ones have NWAY capable MII
transceivers on the chip. So, you can have:
	1. chip + MII
	2. NWAY-chip
	3. NWAY-chip + MII
All MII accesses are done through the serial mdio_* protocol. How should
be this handled w.r.t. XCVR_* or is it completely orthogonal?

+	if ((in.phy_address != out.phy_address) ||
+	    (in.transceiver != XCVR_INTERNAL) ||
+	    (in.maxtxpkt != out.maxtxpkt) ||
+	    (in.maxrxpkt != out.maxrxpkt))
+		return -EOPNOTSUPP;

... and here too.

+	if (advert != mii->advertising) {
+		bmcr |= BMCR_ANRESTART;
+		mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, advert);
+		mii->advertising = advert;
+	}
+
+	/* some phys need autoneg dis/enabled separately from other settings */
+	if ((bmcr & BMCR_ANENABLE) && (!(mii->bmcr & BMCR_ANENABLE))) {
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR,
+				mii->bmcr | BMCR_ANENABLE | BMCR_ANRESTART);
+		bmcr &= ~BMCR_ANRESTART;
+	} else if ((!(bmcr & BMCR_ANENABLE)) && (mii->bmcr & BMCR_ANENABLE)) {
+		mii->mdio_write(dev, mii->phy_id, MII_BMCR,
+				mii->bmcr & ~BMCR_ANENABLE);
+	}

This is nice, but I would like to able to restart autonegotiation even
without changing any of the advertised capabilities. If I missed this
possibility, please point me to it...

Nice work!

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De



