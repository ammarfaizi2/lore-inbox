Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264218AbRFMUZL>; Wed, 13 Jun 2001 16:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264219AbRFMUZB>; Wed, 13 Jun 2001 16:25:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53893 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264218AbRFMUY4>;
	Wed, 13 Jun 2001 16:24:56 -0400
Message-ID: <3B27CC15.2B92E71A@mandrakesoft.com>
Date: Wed, 13 Jun 2001 16:24:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <Pine.LNX.4.10.10106131202280.9327-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> I was on vacation, and thus didn't have the opportunity to comment earlier.

Thanks a bunch for your comments here.


> On Tue, 12 Jun 2001, Jeff Garzik wrote:
> 
> > > - You are proposing some caching for the MII registers. I suppose that you
> > > would like to have this code also working with whatever caching will be
> > > done for MII access that was recently discussed. Wouldn't this produce
> > > double caching under some circumstances ?
> >
> > You misunderstood the code.  The "caching" here is whatever is -already-
> > being done by the driver.  Many Becker-style drivers cache the
> > advertising value.  If such a driver uses the ethtool MII code, that is
> > one less MII read that needs to occur.
> 
> That's not the way I read the code.  It appears to cache various MII
> management registers.

I still think there is a misunderstanding here, brought about my short
explanation and lack of docs..

The key here is the lifetime of the cache.  Without extra work on the
part of the driver author, the data in struct ethtool_mii_info only
exists for a single ioctl call.  ethtool_mii_info is a container, not a
data cache.  So, if you already have MII register cached somewhere, like
advertising, or you perform MII reads before calling
ethtool_mii_[gs]set, then those values are "cached" in the sense that
mii.c will not re-read the register values.

Since MII reads are not the quickest operations in the world, I
preferred to be flexible in allowing what will occur before and after
the ethtool_mii_[gs]set call.


> Caching almost any MII register, except the ID registers, may be
> invalid.

Agreed.  I even said this in an MII thread on lkml a couple weeks ago
;-)


> Caching and ioctl() rate-limiting are both a problem for a program I use
> frequently.  It monitors the transceiver to report the timing and state
> transitions of autonegotiation.  It internally handles polling rate
> limiting by backing off the poll rate when nothing is happening.  But
> when something happens, it polls every timer tick for the next 30
> ticks.

Unfortunately that is at loggerheads with the potential for a bunch of
people to soak the system with unpriveleged MII reads via ioctl.  That
is the core problem, and caching or rate-limiting is only a suggested
solution.

I could forget about rate-limiting if we required CAP_NET_ADMIN and/or
CAP_RAW_IO for all these ioctls, but that might cause complaints too..


> > David's argument is for ethtool, which originally comes out of the sparc
> > port (see include/asm-sparc/ethtool.h in older trees), and has been
> > around for a while, but doesn't enjoy the massive deployment that the
> > MII ioctls enjoy.  We have control over the ethtool API, and we can
> > correct its deficiencies, whereas any MII spec deficiencies must be
> > worked out inside the driver.
> 
> You should first understand what MII management registers provide before
> deciding that you can do better.  There are some design uglinesses,
> but it was put together by people that lived and breathed transceivers.
> It has been proven over six or seven years or use with no incompatible
> changes to the original software interface definition.
> 
> >...
> > Further, for the userland ethtool program, support for MII ioctls will
> > be added soon, so that there will be no need for additional mii-tool or
> > mii-diag tools.
> 
> This could be easily reversed: the additional ethtool program was not
> needed in the first place.
> 
> > > This is nice, but I would like to able to restart autonegotiation even
> > > without changing any of the advertised capabilities. If I missed this
> > > possibility, please point me to it...
> >
> > no, that is a capability which needs to be added to ethtool.
> > ETHTOOL_RENEG or ETHTOOL_ANRESTART or something.  Basically kick the
> > link state machine, whether such a state machine is in the driver or in
> > the MII phy.  That's the one big thing that mii-tool can do that ethtool
> > cannot, AFAICS.
> 
> An additional capability of the MII ioctl() is that it permits sending
> "next page" extended information to the link partner.

[move this down here]
> This message covers
>    Why caching MII values doesn't work.
[responded above]
>    Why extended MII values are useful.
Ok, thanks, agreed.

About the larger issue of why ethtool exists, I wonder about things
like:  how do the MII ioctls cover things like switching transceivers? 
supporting aui/10b2?  supporting sym phys?

ethtool is not just about 10/100 media.  It's a general software
diagnostics utility and tuning tool for your ethernet driver.  The same
kernel interface and the same userland program will allow me to
associate an ethernet interface with a driver and bus location, adjust
media settings, adjust interrupt mitigation settings, or perhaps even
perform a driver-specific duty.

I am very much convinced that the extended MII ioctls are useful, and
would even support codifying them in sockios.h, using the SIOCMII* names
you are already using.

However I see the MII ioctls as a tuning tool for a specific (though
large) subset of hardware.  I am still not comfortable with considering
the MII ioctls as the standard for communication between the kernel and
userland...

Tangent, to close on a more concrete technical note.  The MII ioctls in
their current form are not completely portable.  For DaveM and others
doing 32-bit userland on 64-bit kernel, you have to pass through ioctl
translation layer.  Not only will the SIOCMIIxxx ioctls need to be made
official, but the structure which has so far been implicitly defined
(u16* data) in the ioctls would need to be explicitly defined, in some
central location.

Regards,

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
