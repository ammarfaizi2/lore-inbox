Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRFLRld>; Tue, 12 Jun 2001 13:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbRFLRlX>; Tue, 12 Jun 2001 13:41:23 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64144 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262747AbRFLRlO>;
	Tue, 12 Jun 2001 13:41:14 -0400
Message-ID: <3B265416.58941C3C@mandrakesoft.com>
Date: Tue, 12 Jun 2001 13:40:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <Pine.LNX.4.33.0106121835340.22227-100000@kenzo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> On Sun, 10 Jun 2001, Jeff Garzik wrote:
> - I don't know what the long-term plan is about ethtool vs. MII ioctl's.
> If you do plan to replace completely the MII ioctl's, there should be a
> way to access _all_ MII registers provided by the PHY, even if you do this
> in a restricted way (i.e. for CAP_NET_ADMIN only). There is also useful
> info in other registers than the 4 you have in your implementation.

What are you doing that you need to access all registers from userspace?

On to your larger question, ethtool versus MII ioctls.   That is an
issue that weighs heavily on me.  Right now we have quite a bit of
deployed code using MII ioctls, and there is a gigabit MII standard; so,
Becker's argument is that each driver should provide a set of MII
ioctls, emulating behavior when hardware isn't exactly per spec.  (yes,
right now they are SIOCDEVPRIVATE, but that can be easily changed to
SIOCDEVMIIxxx)

David's argument is for ethtool, which originally comes out of the sparc
port (see include/asm-sparc/ethtool.h in older trees), and has been
around for a while, but doesn't enjoy the massive deployment that the
MII ioctls enjoy.  We have control over the ethtool API, and we can
correct its deficiencies, whereas any MII spec deficiencies must be
worked out inside the driver.  Further, there is the question of "how
much MII to implement" -- currently the MII-ioctl-based net drivers all
implement -basic- MII, but I guarantee that you will find
per-driver(per-chip) differences in the MII implementation... which is a
flaw in the MII ioctl implementation in the driver, regardless of how
the chip is designed.  There are completeness flaws in more than one MII
ioctl implementation.  Several drivers will return zeroes for the MII id
registers, for example.  The ethtool API doesn't have that problem.

For 2.4, my conclusion is:  for drivers that already implement MII
ioctls as SIOCDEVPRIVATE, continue to support those ioctls.  In
addition, support ethtool.  For drivers without support for either, just
add ethtool support.  The patch being discussed will cut down on
duplicate code for both cases.

Further, for the userland ethtool program, support for MII ioctls will
be added soon, so that there will be no need for additional mii-tool or
mii-diag tools.

For 2.5?  I don't know.  I am not a visionary.  I defer that to Linus
and David and Donald and Jamal and Alexey and...  I am mainly a
maintainer and merge monkey, only implementing new APIs when the needs
are blindingly obvious.


> - You are proposing some caching for the MII registers. I suppose that you
> would like to have this code also working with whatever caching will be
> done for MII access that was recently discussed. Wouldn't this produce
> double caching under some circumstances ?

You misunderstood the code.  The "caching" here is whatever is -already-
being done by the driver.  Many Becker-style drivers cache the
advertising value.  If such a driver uses the ethtool MII code, that is
one less MII read that needs to occur.

If the driver author wishes to cache more stuff, they have to do so in
the obvious way.  struct ethtool_mii_info is only used for helper
functions which are only used inside netdrv_ioctl().


> +       int speed;              /* 10, 100, 1000 or -1 (ask hw)         */
> 
> Please note that the comment specifies 1000, while the code in several
> places assumes only 2 possibilities: 10 and 100.

planning for the future :)  Yes, the code only supports 10/100, as I
mentioned in my introductory message.


> +       if (mii->autoneg < 0)
> +               autoneg = mii->autoneg = (bmcr & BMCR_ANENABLE) ? 1 : 0;
> +       else    autoneg = mii->autoneg;
> 
> You don't read anything from the hardware at this point. Why do you want
> caching ?

I don't understand your question.  Of course we have read BMCR from the
hardware at that point, read the code...


> Not related: I know that this comes from David Miller's older work, but
> wouldn't be possible to have a more uniform naming scheme ? You have
> BMCR_ANENABLE, but you have BMSR_ANEGCAPABLE...

capable != enable.. I prefer them different, so I am therefore
unmotivated to change anything ;-)


> +       if (mii->full_duplex < 0)
> +               full_duplex = mii->full_duplex =
> +                       mii_nway_result(negotiated) & LPA_DUPLEX;
> +       else    full_duplex = mii->full_duplex;
> 
> If autoneg. is disabled, I don't think that you always get useful info in
> 'negotiated'. Applies to the next chunk, too.
> 
> +       if (mii->speed < 0) {
> +               if (negotiated & LPA_100)
> +                       speed = mii->speed = 100;
> +               else
> +                       speed = mii->speed = 10;
> +       } else
> +               speed = mii->speed;

interesting point, thanks.


> +       ecmd->transceiver = XCVR_INTERNAL;
> 
> I didn't understand what XCVR_INTERNAL should mean as opposed to
> XCVR_EXTERNAL or whatever.

It is really up to interpretation of the individual driver author (or in
this case mii.c author), because the net core doesn't know nor care
about XCVR_xxx.


> +       if (advert != mii->advertising) {
> +               bmcr |= BMCR_ANRESTART;
> +               mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, advert);
> +               mii->advertising = advert;
> +       }
> +
> +       /* some phys need autoneg dis/enabled separately from other settings */
> +       if ((bmcr & BMCR_ANENABLE) && (!(mii->bmcr & BMCR_ANENABLE))) {
> +               mii->mdio_write(dev, mii->phy_id, MII_BMCR,
> +                               mii->bmcr | BMCR_ANENABLE | BMCR_ANRESTART);
> +               bmcr &= ~BMCR_ANRESTART;
> +       } else if ((!(bmcr & BMCR_ANENABLE)) && (mii->bmcr & BMCR_ANENABLE)) {
> +               mii->mdio_write(dev, mii->phy_id, MII_BMCR,
> +                               mii->bmcr & ~BMCR_ANENABLE);
> +       }
> 
> This is nice, but I would like to able to restart autonegotiation even
> without changing any of the advertised capabilities. If I missed this
> possibility, please point me to it...

no, that is a capability which needs to be added to ethtool. 
ETHTOOL_RENEG or ETHTOOL_ANRESTART or something.  Basically kick the
link state machine, whether such a state machine is in the driver or in
the MII phy.  That's the one big thing that mii-tool can do that ethtool
cannot, AFAICS.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
