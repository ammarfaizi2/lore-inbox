Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRFRRbX>; Mon, 18 Jun 2001 13:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRFRRbN>; Mon, 18 Jun 2001 13:31:13 -0400
Received: from dweeb.lbl.gov ([128.3.1.28]:38528 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S261942AbRFRRbB>;
	Mon, 18 Jun 2001 13:31:01 -0400
Message-ID: <3B2E3AB3.993AAF00@lbl.gov>
Date: Mon, 18 Jun 2001 10:30:27 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: PALFFY Daniel <dpalffy@kkt.bme.hu>
CC: Guus Sliepen <guus@warande3094.warande.uu.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for ifenslave.c
In-Reply-To: <Pine.LNX.4.21.0106181249140.18271-100000@iris.kkt.bme.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PALFFY Daniel wrote:
> 
> On Thu, 14 Jun 2001, Thomas Davis wrote:
> 
> > Guus, there isn't a really official version of it..
> >
> > At http://pdsf.nersc.gov/linux/ifenslave.c is the last version I
> > produced, that works with bonding in v2.2 and v2.4 kernels.
> 
> > Guus Sliepen wrote:
> > >
> > > Hello,
> > >
> > > The Ethernet bonding module is useless without ifenslave.c. I'm making a Debian
> > > package for it, and I have tried to find the "offical" distribution of this
> > > small program. I could not find an authorative source, instead a lot of copies
> > > and patched versions are scattered around the Internet (I maintain a patched
> > > version myself too).
> > >
> > > I would like to combine all the useful extra features and patches into this
> > > Debian package, so if you know of a patched version or maintain one yourself,
> > > please send it to me.
> 
> The only bonding driver and ifenslave that worked for me was the patched
> version from http://sourceforge.net/projects/bonding . It runs fine over a
> quad starfire card, with vlans over it (ben's patch). You might consider
> packaging the ifenslave from that patch, and packaging the bonding driver
> as a kernel patch...
> 

Yea, and that ifenslave won't work with redhat's network setup files,
which has been in place for years.  Notice I'm not on that page?  I
considered it a forked version.  It also does things I talked to becker
about, that is not nice to the system (MII polling as often it does is
bad.)

When I created the first 2.2 bonding patch, I didn't want to have to
rewrite redhat's already in place ifenslave support (from the 2.0.xx
kernel patch).  The ifenslave listed on that page is broken in that
regard.

The original ifenslave bonded a device to a master that was already up
and running;  the master device was used also a xmit device  (so it
routed packets, and sometimes transmitted them).  So, if the master
device died, the slave(s) died with it.  Not good.  Redhat config files
assumed the master was up and running, and you can add a slave to it
without any problems.  The slave device also picks up it's mac address
from the master device.

The version I created, the master device does nothing but route packets
to slaves.  This has a simple problem - no known mac hardware address. 
(ie, it's 0:0:0:0:0:0:0:0) That's bad.  To set a hardware mac address,
you need to down, change the hw mac, and re-up the device.  But,
redhat's scripts already assume the master is up and running, and
downing the master to setup the mac hw means all IP routing information
is lost.  So I added the BOND_SETHWADDR, which allows ifenslave to add a
mac address to the bond master without killing any IP routing
information.  But that's not totally correct either, since adding a mac
hw address can screw up the arp tables (it appears not to, but that's
just plain lucky).

So, in summary, bonding is hack, I strongly dis-agree with what is at
http://sourceforge.net/projects/bonding, but my hands are currently tied
on doing much about it (I could, but I could suffer from consequences)

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
