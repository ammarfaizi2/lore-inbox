Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264118AbRFMQtM>; Wed, 13 Jun 2001 12:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264128AbRFMQtC>; Wed, 13 Jun 2001 12:49:02 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:46325 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S264118AbRFMQs4>;
	Wed, 13 Jun 2001 12:48:56 -0400
Date: Wed, 13 Jun 2001 12:56:57 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B265416.58941C3C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10106131202280.9327-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was on vacation, and thus didn't have the opportunity to comment earlier.

This message covers
   Why caching MII values doesn't work.
   Why extended MII values are useful.

On Tue, 12 Jun 2001, Jeff Garzik wrote:

> > - You are proposing some caching for the MII registers. I suppose that you
> > would like to have this code also working with whatever caching will be
> > done for MII access that was recently discussed. Wouldn't this produce
> > double caching under some circumstances ?
> 
> You misunderstood the code.  The "caching" here is whatever is -already-
> being done by the driver.  Many Becker-style drivers cache the
> advertising value.  If such a driver uses the ethtool MII code, that is
> one less MII read that needs to occur.

That's not the way I read the code.  It appears to cache various MII
management registers.

Caching almost any MII register, except the ID registers, may be
invalid.  My drivers record values written to MII registers (note 1), but
always does an actual read.

Here is a quick summary of the basic mode registers

 MII Reg   Function     When it changes
  0  Control register -- May return the current autonegotiated status.
  1  Status register  -- Changes with link status and other events.
 2&3 ID registers     -- Should never change
  4 Advertised value  -- may change with a transceiver reset
  5 Link partner      -- changes with negotiation, and "next page" feature

(1) The drivers record the autonegotiation advertised value, and
recently have been updated to allow writes to the control register to
force the speed and duplex.

Caching and ioctl() rate-limiting are both a problem for a program I use
frequently.  It monitors the transceiver to report the timing and state
transitions of autonegotiation.  It internally handles polling rate
limiting by backing off the poll rate when nothing is happening.  But
when something happens, it polls every timer tick for the next 30
ticks.

> Bogdan Costescu wrote:
> > On Sun, 10 Jun 2001, Jeff Garzik wrote:
> > - I don't know what the long-term plan is about ethtool vs. MII ioctl's.
> > If you do plan to replace completely the MII ioctl's, there should be a
> > way to access _all_ MII registers provided by the PHY, even if you do this
> > in a restricted way (i.e. for CAP_NET_ADMIN only). There is also useful
> > info in other registers than the 4 you have in your implementation.
> 
> What are you doing that you need to access all registers from userspace?

That's an easy one: "next page" information, diagnostics, status
reports, and extended configuration.

Much useful information is reported by certain MII transceivers.  People
that care select transceivers that provide the extended information.

Diagnostic reports
   The approximate distance to the first major impedence mismatch on the
   cable.
Signal status reports.
   Signal level -- estimate if the cable is to long or flawed.
   Signal to noise -- estimate the reliability of the link.
   Near-end cross-talk level.
   Reversed receive polarity.

Operational errors
   Symbol coding error count
   Symbol sequence error count
   Decoder/PLL slip indication.

Some examples of extended configuration are
   Increasing or decreasing the transmit level.
   Setting a lowered recieve threshold to allow marginal non-noisy links
     to work.
   Using symbol coding over fiber.
   Changing the information reported on the LED outputs

> Becker's argument is that each driver should provide a set of MII
> ioctls, emulating behavior when hardware isn't exactly per spec.  (yes,
> right now they are SIOCDEVPRIVATE, but that can be easily changed to
> SIOCDEVMIIxxx)

My driver sources converted to using specific names, which are currently
mapped as follows
#ifndef SIOCGMIIPHY
#define SIOCGMIIPHY (SIOCDEVPRIVATE)	/* Get the PHY in use. */
#define SIOCGMIIREG (SIOCDEVPRIVATE+1)	/* Read a PHY register. */
#define SIOCSMIIREG (SIOCDEVPRIVATE+2)	/* Write a PHY register. */
#define SIOCGPARAMS (SIOCDEVPRIVATE+3)	/* Read operational parameters. */
#define SIOCSPARAMS (SIOCDEVPRIVATE+4)	/* Set operational parameters. */


> David's argument is for ethtool, which originally comes out of the sparc
> port (see include/asm-sparc/ethtool.h in older trees), and has been
> around for a while, but doesn't enjoy the massive deployment that the
> MII ioctls enjoy.  We have control over the ethtool API, and we can
> correct its deficiencies, whereas any MII spec deficiencies must be
> worked out inside the driver.

You should first understand what MII management registers provide before
deciding that you can do better.  There are some design uglinesses,
but it was put together by people that lived and breathed transceivers.
It has been proven over six or seven years or use with no incompatible
changes to the original software interface definition.

>...
> the chip is designed.  There are completeness flaws in more than one MII
> ioctl implementation.  Several drivers will return zeroes for the MII id
> registers, for example.  The ethtool API doesn't have that problem.

Returning zeros for the MII ID registers is accepted industry practice
for integrated transceivers.  We could have the driver substitute a
specific ID, but this isn't an actual problem.

> Further, for the userland ethtool program, support for MII ioctls will
> be added soon, so that there will be no need for additional mii-tool or
> mii-diag tools.

This could be easily reversed: the additional ethtool program was not
needed in the first place.

> > This is nice, but I would like to able to restart autonegotiation even
> > without changing any of the advertised capabilities. If I missed this
> > possibility, please point me to it...
> 
> no, that is a capability which needs to be added to ethtool. 
> ETHTOOL_RENEG or ETHTOOL_ANRESTART or something.  Basically kick the
> link state machine, whether such a state machine is in the driver or in
> the MII phy.  That's the one big thing that mii-tool can do that ethtool
> cannot, AFAICS.

An additional capability of the MII ioctl() is that it permits sending
"next page" extended information to the link partner.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

