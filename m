Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263202AbTCMXUL>; Thu, 13 Mar 2003 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263197AbTCMXUL>; Thu, 13 Mar 2003 18:20:11 -0500
Received: from 66-23-198-2.clients.speedfactory.net ([66.23.198.2]:4992 "EHLO
	hp.outpostsentinel.com") by vger.kernel.org with ESMTP
	id <S263200AbTCMXT7>; Thu, 13 Mar 2003 18:19:59 -0500
Subject: RE: RS485 communication
From: Chris Fowler <cfowler@outpostsentinel.com>
To: Robert White <rwhite@casabyte.com>
Cc: Ed Vance <EdV@macrolink.com>, "'Linux PPP'" <linuxppp@indiainfo.com>,
       linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
References: <PEEPIDHAKMCGHDBJLHKGGECKCDAA.rwhite@casabyte.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Mar 2003 18:30:39 -0500
Message-Id: <1047598241.5292.2.camel@hp.outpostsentinel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you saying that for him to to use PPPD that he will have to write a
program that will run on a master and tell all the slave nodes when they
can transmit their data.  In this case it would be ppp data.  Hopfully
in block sizes that are at least the size of the MTU ppp is running.

Chris

On Thu, 2003-03-13 at 17:54, Robert White wrote:
> I would tend to agree.  The 485 bus is very like an extremely limited
> version of the raw level communication access an Ethernet card gives to you
> to the Ethernet wiring.  (Remember that conceptually an Ethernet is a
> closed-circuit radio where any peer can transmit if it sees the circuit is
> idle.  This is the "carrier sense" and "collision detect" parts of the
> standard.)  The 485 bus is trickier though because there is no "carrier
> sense" so each slave device must be told when it is, exactly, that it can
> transmit.
> 
> If you are going to use RS485 you are going to have to have a management
> layer on the participating boxes so that each party knows when it is "their
> turn."  That means you are going to need to write essentially a multiplexing
> driver that exposes a bunch of endpoints and manages the link.  (This would
> conceptually a kin to the way /dev/hda has /dev/hda1-4 for the partitions.
> This is also almost exactly what a TCP socket really accomplishes over an
> Ethernet.)  Each endpoint would need to act as an independent, buffered
> serial port.
> 
> If all the boxen are full featured computers (running Linux), you will also
> need to make sure that they all know who the master is and this will lead to
> needing a complete encapsulation protocol and some configuration settings.
> If all the slave devices are obviously slaves (e.g. one computer and a bunch
> of modems) then the multiplexor will need to conform to whatever is already
> programmed into those devices.
> 
> Regardless, the resulting configuration as seen on your Linux box would
> probably end up looking something like the following:
> 
> [485 device]
>     ""
> [Multiplexor Program]
>     ""
> [Some Number of PTYs]
>     ""
> [one PPP Daemon per PTY]
> 
> Each slave device would need a DeMultiplexor and a PPP daemon instance on a
> single PTY.
> 
> I recommend you *DO NOT* try to create a mesh.  (e.g. each of ten hosts
> running a complete multiplexor with nine PPP daemons to talk directly to the
> other hosts.)  You will still need a RS485 Master and all the traffic will
> have to at least marginally involve that master.  It is better, if the
> slaves must intercommunicate, to have the host running the master
> multiplexor act as an IP router.
> 
> Remember that PPP is a "point to point" protocol not a "multipoint" protocol
> (like the hardware layer of an Ethernet) so it can't directly support a
> multipoint architecture.
> 
> ASIDE:
> I know all this not because I am an expert on RS485 but because at a
> previous job the manufacturing staff decided to save $8US per box by
> installing an embedded RS485 controller chip instead of an embedded Ethernet
> controller chip.  We paid for that $8US several thousand fold.  If you are
> not stuck with a specific and constrained hardware problem it *WILL* be
> cheaper and less time consuming to use an Ethernet.  Even if you *are*
> talking to a bunch of modems or something, it will *STILL* be
> better/cheaper/less hassle to buy multi-port terminal servers and wire the
> target devices up to it/them individually.  RS485 has specific value for
> data collection tasks but it is not your friend for anything that looks even
> remotely like IP traffic (e.g. anything you would run or require PPP).  Once
> the third box is installed you will get less than Token Ring version 1
> protocol performance characteristics and it will be over a MUCH slower
> media.
> 
> Don't be "penny wise and pound (1.8 dollar 8-) foolish."
> END ASIDE
> 
> Rob.
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ed Vance
> Sent: Thursday, March 13, 2003 8:56 AM
> To: 'Linux PPP'
> Cc: linux-serial@vger.kernel.org; 'linux-kernel'
> Subject: RE: RS485 communicatio
> 
> 
> On Wed, Mar 12, 2003 at 10:15 PM, linuxppp@indiainfo.com wrote:
> > Hi all,
> > am currently working on PPP over serial interface (RS485) in
> > linux 2.4.2-2. I believe RS485 half duplex system and hence
> > only one can transmit at a time. And for RS485 we basicaly
> > use Master-Slave or Primary-Secondary kind of communication.
> > I don't know how to achieve the same using PPP since i need
> > to have max of 10 nodes connected via serial interface. I
> > tested with two nodes using PPP daemon it works fine.
> > Following are the commands i issued
> >
> > In PPP server:
> > $usr/sbin/pppd -detach crtscts 10.10.10.100:10.10.10.101
> > 115200 /dev/ttyS0 &
> >
> > In PPP client side :
> > $/usr/sbin/pppd call ppp-start
> > where ppp-start file is copied into directory /etc/ppp/peers/
> > that had the following
> >
> > -detach /dev/ttyS0 115200 crtscts
> > noauth
> >
> > This point to point communication worked fine with RS485
> > interface. If i had to connect one more node what i need to
> > do. Please clarify with the following
> >
> > i) Whether the existing pppd takes care of the RS485 with
> > multi node , if so how do i manage giving commands
> > ii) If there is no direct support how do i go ahead. Is there
> > any other layer 2 protocol allows me to acheive TCP/IP
> > communicattion over RS485 which is my ultimatum.
> >
> > I will be grateful if anybody of them could help me with my
> > current problem.
> >
> 
> I believe Point-to-Point Protocol only supports point-to-point symmetric
> links. Don't think there is any multi-point support in the protocol. IIRC,
> PPP also requires a full duplex link, which is not available on an RS-485
> link with more than two stations, even if it is a 4-wire link.
> 
> I don't know of an easy way around this fundamental limitation.
> 
> Maybe somebody on the kernel list has a suggestion.
> 
> Cheers
> 
> ----------------------------------------------------------------
> Ed Vance              edv (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


