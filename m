Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbRFBTLK>; Sat, 2 Jun 2001 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbRFBTLA>; Sat, 2 Jun 2001 15:11:00 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:30929 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262665AbRFBTKw>; Sat, 2 Jun 2001 15:10:52 -0400
Date: Sat, 2 Jun 2001 21:10:44 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Frazer <mark@somanetworks.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: MII access (was [PATCH] support for Cobalt Networks (x86 only)
 systems)
In-Reply-To: <E156E3K-0001sJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106022016020.22912-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ As this is becoming more and more MII specific, I changed the subject ]

On Sat, 2 Jun 2001, Alan Cox wrote:

> > This only answered the first part of the question: when. How do you pass
> > the "how long" info ?
> > Does the same applies for the MII ioctl case ?
>
> The mtime tells you exactly that.

Alan, please consider this situation:

One application needs to poll link status with 1 second resolution. On a
system where caching is done with an unknown cache expiring time, this
application is sometimes fed incorrect data. So, you need a way to tell
for how long this situation lasts. If you have a proc/ioctl interface for
setting cache expiring time, this same interface can then be used for
reading back this info. This application can then check that this value is
lower than 1 second and if not, notify the user that it cannot run.

As this thread started as a general hardware access problem, would only
_one_ value for all these cases be sufficient ? Or each case should have
its own timeout ? Anyway, for MII, accessing the status at sub-second
intervals might be a legit one, so what measuring units should be used?

> I disagree. A non priviledged app should not be able to poke around in MII
> registers anyway. So you only have to cache the generic state of the link.

At the beginning of this thread, Jeff said "calling the ioctls without
priveleges is quite useful". Now if you say that there is no such case,
the whole problem could simply be solved by checking for the appropriate
priviledges.

I just realized another thing, important (IMHO) if a normal user is still
allowed to access MII: the drivers (checked for 3c59x, eepro100, tulip) do
not verify that the value passed for register number is within the allowed
range and use it as:

        int read_cmd = (0xf6 << 10) | ((phy_id & 0x1f) << 5) | location;

(phy_id is the MII address and location is the register number).

There is also no check that the MII address specified is actually in use
by the driver, but this is used with mii-diag to query a MII which was not
correctly identified (maybe this should be allowed for CAP_NET_ADMIN only ?)

>From one of Don Becker pages:
"MII transceivers have 32 management registers. The first 16 are reserved
for standard-defined uses, and the remaining one are available for
chip-specific features. Only the first seven registers are currently
defined."

Usually, the transceivers return garbage if you read from locations you
are not supposed to (overwritting phy_ad).  But if you begin overwritting
the READ command (0xf6 above)... Something like this should do:

        int read_cmd = (0xf6 << 10) | ((phy_id & 0x1f) << 5) | (location & 0x1f);

> You don't need timers.

Too tired to think straight yesterday... You're right. And if you alloc
32*sizeof(int) (you want to keep jiffies, right ?) per netdevice, I think
that it could even be done outside the driver. Hmm, most of my
previous arguments are no longer valid 8-(

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

