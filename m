Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264202AbRFORXb>; Fri, 15 Jun 2001 13:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFORXS>; Fri, 15 Jun 2001 13:23:18 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:12771 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S264202AbRFORXG>; Fri, 15 Jun 2001 13:23:06 -0400
Date: Fri, 15 Jun 2001 19:22:44 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Donald Becker <becker@scyld.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B27CC15.2B92E71A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106151822030.13655-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Jeff Garzik wrote:

> > Caching and ioctl() rate-limiting are both a problem for a program I use
> > frequently.
>
> Unfortunately that is at loggerheads with the potential for a bunch of
> people to soak the system with unpriveleged MII reads via ioctl.
>
> I could forget about rate-limiting if we required CAP_NET_ADMIN and/or
> CAP_RAW_IO for all these ioctls, but that might cause complaints too..

In the last thread, I proposed that caching/rate-limiting should apply
only to unpriviledged users. This way applications like Don's would still
run (but require to be run as root) and normal users would not DoS it.
I was thinking of something like this (caching applied to 3c59x):

static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
...
        switch(cmd) {
        case SIOCDEVPRIVATE:            /* Get the address of the PHY in use. */
                data[0] = phy;
		break;
        case SIOCDEVPRIVATE+1:          /* Read the specified MII register. */
		reg = data[1] & 0x1f;
		if (capable(CAP_NET_ADMIN) || (vp->cache.to[reg] + MII_CACHE_TIMEOUT < jiffies)) {
	                EL3WINDOW(4);
	                data[3] = mdio_read(dev, data[0] & 0x1f, reg);
			vp->cache.val[reg] = data[3];
			vp->cache.to[reg] = jiffies;
		} else {
			data[3] = vp->cache.val[reg];
		}
                retval = 0;
                break;
	case ...

where MII_CACHE_TIMEOUT is a constant here, but should be something
modifiable through /proc. I've choosen a resolution of HZ for cached reads
as it's easily accesible. The example is obviously simplified, it only
handles one transceiver; if there can be more active at the same time,
each should have it's own cache.

> About the larger issue of why ethtool exists, I wonder about things
> like:  how do the MII ioctls cover things like switching transceivers?
> supporting aui/10b2?  supporting sym phys?

AFAIK, MII ioctl's are right now only allowing access to MII registers.
Switching transceivers is a tough job, that's why it's generally done in
init()/open(). If you mean by "switching" just a "set this transceiver for
use", this might be possible to do, but if you want to check if a
transceiver is available and then "set for use", this can't be done
easily. Some transceivers can't return any info and the general way of
probing them is by trying to send/receive something - which opens the
window for nice races with the Tx/Rx parts which can be active at that
time. That's why my impression is that changing transceivers can only
be safely done at init()/open().
AUI cannot be probed, so you have to send/receive something. Furthemore, I
don't think that the AUI interface tells you anything about what's
connected to it, so you have to blindly activate it and hope that it
works. 10base2 might give link beat, but otherwise AUI considerations
apply. AFAIK, Sym phys are easier to emulate (isn't tulip already doing
this ?).

>  The same
> kernel interface and the same userland program will allow me to
> associate an ethernet interface with a driver and bus location, adjust
> media settings, adjust interrupt mitigation settings, or perhaps even
> perform a driver-specific duty.

So far, Don's work proved very well thought. There's a mii-diag which
deals with media settings for MII-capable NICs and there are diag tools
for each chipset (vortex-diag, tulip-diag, etc.) which deal with
driver-specific duties.

[ I don't have any relationship with Don. In fact, you can see on the
vortex list that we disagreed many times. ]

I wouldn't object to making mii-diag able to more generally deal with
media settings (probably by provinding MII-like interfaces for NICs that
don't have MII). But the other way around of trying to do driver-specific
duties from _one_ tool seems a bit to hard for me.
AFAIK, associating ethernet interfaces with drivers and bus locations has
no standard right now, but I agree that is a need. So, if everybody
agrees, the ethtool way can be stated as the standard.
Again AFAIK, interrupt mitigation has no standard right now, in fact only
few drivers support it. So the fact that is available from ethtool is not
really relevant to me (before you ask, 3c59x supported hardware doesn't
have hardware Rx interrupt mitigation). If Jamal's work for general
interrupt mitigation will be included, then I surely see the need for a
tool to control it. As it will be a core functionality, one tool will do
it, there's no driver dependency.

> However I see the MII ioctls as a tuning tool for a specific (though
> large) subset of hardware.  I am still not comfortable with considering
> the MII ioctls as the standard for communication between the kernel and
> userland...

The low level stuff should be the same in both cases (MII-like and
ethtool). Is what you add on top of it that makes it MII-like or ethtool.
Or am I missing something ?

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De



