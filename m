Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQKCERx>; Thu, 2 Nov 2000 23:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129073AbQKCERd>; Thu, 2 Nov 2000 23:17:33 -0500
Received: from web5203.mail.yahoo.com ([216.115.106.97]:26897 "HELO
	web5203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129049AbQKCER0>; Thu, 2 Nov 2000 23:17:26 -0500
Message-ID: <20001103041719.19613.qmail@web5203.mail.yahoo.com>
Date: Thu, 2 Nov 2000 20:17:19 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:

> Using an IP packet of 255.255.255.255 doesn't mean
> it's a broadcast
> packet. It is going to your default gateway because
> it is outside
> your netmask, which guarantees that it is not a
> broadcast.

1) No, it's still a broadcast packet when it goes out.
 That's the behavior of the current code.  The packet
isn't redirected to the gateway, it retains its
255.255.255.255 address when heading out the other
interface.  (Other computers on the subnet connected
to that interface see it, even though their address
isn't 255.255.255.255 and it doesn't match the address
or broadcast address of any of their interfaces.)

I just re-confirmed this.  On 192.168.0.3 I moved the
default gateway to 192.168.0.99 (a non-existent
machine, but told it to still go out eth0), ran the
255.255.255.255 broadcaster on .3, ran a listener on
192.168.0.1, and the listener heard the packets from
the broadcaster (and confirmed their source address,
192.168.0.3).  The broadcast address on both
interfaces (.3 and .1) is 192.168.0.255, with netmask
255.255.255.0.

So once again: when sending to 255.255.255.255,
Broadcast packets are spit out the gateway's interface
(AS broadcast packets), but not out the other
interface(s).  The behavior I expected is the
broadcast packets getting sent out ALL the interfaces
this machine had.  (Most gateways won't FORWARD
broadcast packets, which is why this doesn't flood the
whole internet.  This is also WHY gateways have to go
out of their way not to forward broadcast packets,
because there IS a way of specifying a broadcast
address larger than a single subnet.)

2) Windows does it.  (That's no defense of the
practice, but it is at least circumstantial evidence
that the fact linux is at least partially supporting
it is not just some strange accident.)

3) The support that's in there now has explicit code
implementing it.  If it has no special meaning, why
does linux/net/ipv4/route.c treat "0xFFFFFFFF"
specially?  Grep for it.  Sample code snippet (from
route.c):

	if (key.dst = 0xFFFFFFFF)
		res.type = RTN_BROADCAST;

There's a half-dozen or more of those in there (2.2.16
on this box, I could check 2.2.18pre if you like but I
don't expect a difference)...

> To use a broadcast of 255.255.255.255, your netmask
> would have
> to be 0.0.0.0, which would gurantee that you have no
> default
> route.

I'm not making this up.  There are a lot of precedents
of it being used.  Look at cisco:

http://www.ieng.com/univercd/cc/td/doc/product/software/ios113ed/113ed_cr/np1_r/1ripadr.htm#xtocid587510

And of course bootp/dhcp use it for their queries when
they don't know WHO they are:

http://ctdp.tripod.com/os/linux/usersguide/linux_ugdhcp.html

I always thought it was the the global broadcast
address, propogated to all NICs.  That's what it USED
to be, but I've been using it so long (and so
intermittently) I don't remember what documentation
that originally came from.

Yes, it could be a bad habit and maybe I should stop. 
But if so, I'd like to see where that's in writing.
(Documented somewhere.  Anywhere.  Alan Cox saying
"this is so" is plenty authoritative enough for me. 
Documentation counts as resolving the issue...)

> As an example, we 'own' a network from:
> 
> 204.178.40.1 to 204.178.47.255.
> 
> This means that the network address is 204.178.40.0,
> the netmask
> is 255.255.248.0, and the broadcast address is
> 204.178.47.255
> 
> Anything outside the LAN, which means anything that
> won't 'fit'
> inside the netmask goes out the default route.
> That's how it
> works.

I know how that works.  But the fact remains that
machines that aren't 255.255.255.255 know to receive
that address.  Both Linux machines and windows
machines.  The switching hub propogates it and the
stack receives it.

The behavior it has right now DOES come very close to
what I expect it to do, and way in the past (on a
mixed network of OS/2, windows, and macintoshes, I
suspect, don't remember who was server and who was
client, it was in java) using 255.255.255.255 did
exactly what I wanted it to do.  I wasn't network
administrator on those boxes though, so I dunno if
this was an OS default or the way the NICs were
configured.  (Come to think of it, I don't remember if
any of the boxes I was using HAD more than one NIC, it
was a while ago.  They probably didn't.)

It's just not doing it here.  I'm wondering if not
doing it here is documented and something the network
guys intend to keep, or if the half-support in there
now is going to be extended to full support.

> When you set a broadcast address, you are simply
> plugging in
> an IP, within your network, that is not otherwise in
> use.

That's the subnet broadcast, sure.  But I remember
something about global broadcast addresses from way
back in college.  Maybe I imagined it, but I know I
got tested on it.

> This means that when a HARDWARE address of all bits
> set is
> being sent out your Ethernet controller (as a
> destination),
> the IP address within the packet will be whatever
> you set it
> to be with : `ifconfig eth0 .... broadcast
> 204.178.47.255`.
>  I could use  ... broadcast 204.178.40.0 and, in
> fact,
> in the 'olden' days, that's what was used.

And here I thought the IP stack translated the
broadcastness down to the ethernet layer, where the
MAC address was what actually steered when
transporting packets from one machine to another
across a length of cat 5 (anybody mentioning OSI
models will be subjected to the "7 layer burrito"
page, assuming I can find a mirror of it that's still
up), and that there IS a MAC broadcast address (or
flag bit or some such).

Which could be why the IP stack needs to have a
broadcast flag set for the packets when it feeds them
to the interface...

> All machines on Ethernet LANs accept broadcast
> packets,
> multicast packets, and packets with a destination of
> their
> HARDWARE address. This is all done in HARDWARE! Your

Strangely, I was under the impression that the IP
stack is the layer of software that tells that
hardware (or tells the drivers for that hardware) what
to do.  Again, I seem to be imagining all sorts of
strange things, thanks for clearing up the confusion.

> controller
> does not receive everything on the LAN. If it did,
> you'd be
> so bogged down getting ethernet interrupts and
> dumping the
> data on the floor, that you would have few CPU
> cycles to
> do any actual work.

Which would be why the MAC level addressing has a way
of designating packets broadcast, or addressing them
to a specific machine's address, generally supplied by
the vendor in an EPROM or some such.  Which is also
what gives things such as switching hubs information
to go on...  (Again, I vaguely remember this from
someplace, Perhaps from last month, when I taught the
networking chapter out of the textbook to my students
in the "intro to Unix" course I teach tuesday nights
at ACC...)

> When a machine receives a hardware broadcast packet,
> it may
> not even look at the destination address in the
> packet. That's
> why your broadcast address is a "throw-away". The
> receiver is
> only concerned with the sender's IP address, usually
> to
> resolve an address (ARP).

Okay, enlighten me.  Is the hardware looking at the
MAC address and status bits of the passing frames, or
is it grabbing and inspecting each frame to see if the
TCP/IP headers in the data section of the frame
indicate it should be interested?

Have you ever seen a network that has more than one
(non-overlapping) IP subnet working through the same
ethernet hub?  Those are fun.  (And an area where your
stack shouldn't be lazy about simply accepting
broadcast packets without at least glancing at their
source address, at least according to the IBM guys
fiddling with the OS/2 TCP/IP stack back when I was
working on the install software for OS/2 4.0. :)

> Cheers,
> Dick Johnson

Rob

__________________________________________________
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
http://experts.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
