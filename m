Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270871AbTHFTkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTHFTkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:40:10 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:64329 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S270871AbTHFTj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:39:58 -0400
Date: Wed, 6 Aug 2003 14:39:56 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806143956.B15543@hexapodia.org>
References: <20030802140444.E5798@almesberger.net> <03080607463300.08387@tabby> <20030806112556.C26920@hexapodia.org> <03080613585900.09086@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <03080613585900.09086@tabby>; from jesse@cats-chateau.net on Wed, Aug 06, 2003 at 01:58:59PM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 01:58:59PM -0500, Jesse Pollard wrote:
> On Wednesday 06 August 2003 11:25, Andy Isaacson wrote:
> > The switches may be "wire speed" but that doesn't help the latency any.
> > AFAIK all GigE switches are store-and-forward, which automatically costs
> > you the full 1.3us for each link hop.  (I didn't check Eric's numbers,
> > so I don't know that 1.3us is the right value, but it sounds right.)
> > Also I think you might be confused about what Eric meant by "3 layer
> > switch hierarchy"; he's referring to a tree topology network with
> > layer-one switches connecting hosts, layer-two switches connecting
> > layer-one switches, and layer-three switches connecting layer-two
> > switches.  This means that your worst-case node-to-node latency has 6
> > wire hops with 7 "read the entire packet into memory" operations,
> > depending on how you count the initiating node's generation of the
> > packet.
> 
> If it reads the packet into memory before starting transmission, it isn't
> "wire speed". It is a router.

[Please read an implied "I might be totally off base here, since I've
 never designed an Ethernet switch" disclaimer into this paragraph.]

This statement is completely false.  Ethernet switches *do* read the
packet into memory before starting transmission.  This must be so,
because an Ethernet switch does not propagate runts, jabber frames, or
frames with an incorrect ethernet crc.  If the switch starts
transmission before it's received the last bit, it is provably
impossible for it to avoid propagating crc-failing-frames; ergo,
switches must have the entire packet on hand before starting
transmission.

> > > > A lot of the NICs which are used for MPI tend to be smart for two
> > > > reasons.  1) So they can do source routing. 2) So they can safely
> > > > export some of their interface to user space, so in the fast path
> > > > they can bypass the kernel.
> > >
> > > And bypass any security checks required. A single rogue MPI application
> > > using such an interface can/will bring the cluster down.
> >
> > This is just false.  Kernel bypass (done properly) has no negative
> > effect on system stability, either on-node or on-network.  By "done
> > properly" I mean that the NIC has mappings programmed into it by the
> > kernel at app-startup time, and properly bounds-checks all remote DMA,
> > and has a method for verifying that incoming packets are not rogue or
> > corrupt.  (Of course a rogue *kernel* can probably interfere with other
> > *applications* on the network it's connected to, by inserting malicious
> > packets into the datastream, but even that is soluble with cookies or
> > routing checks.  However, I don't believe any systems try to defend
> > against rogue nodes today.)
> 
> Just because the packet gets transfered to a buffer correctly does not
> mean that buffer is the one it should have been sent to. If it didn't
> have this problem, then there would be no kernel TCP/IP interaction. Just
> open the ethernet device and start writing/reading. Ooops. known security
> failure.

You're ignoring the fact that there's a complete, programmable RISC CPU
on the Myrinet card which is running code (the MCP, Myrinet Control
Program) installed into it by the kernel.  The kernel tells the MCP to
allow access to a given app (by mapping a page of PCI IO addresses into
the user's virtual address space), and the MCP checks the user's DMA
requests for validity.  The user cannot generate arbitrary Myrinet
routing requests, cannot write to arbitrary addresses, cannot send
messages to hosts not in his allowed lists, et cetera.  We do know that
the buffer is the one it should have been sent to, because the MCP on
the sending end verified that it was an allowed destination host, and
the MCP on the receiving end verified that the destination address was
valid.  Myrinet Inc even offers a SDK allowing you to write your own
MCP, if you so desire, and various research projects have done precisely
that.

Demonstrating that dumb Ethernet cards cannot be smart does not
demonstrate that smart FooNet cards cannot be smart.  (s/FooNet/$x/ as
desired.)

> > I believe that Myrinet's hardware has the capability to meet the "kernel
> > bypass done properly" requirement I state above; I make no claim that
> > their GM implementation actually meets the requirement (although I think
> > it might).  It's pretty likely that QSW's Elan hardware can, too, but I
> > know even less about that.
> 
> since the routing is done is user mode, as part of the library, it can be
> used to directly affect processes NOT owned by the user.  This
> bypasses the kernel security checks by definition.

The routing is done on the MCP, not in a library.  (Or at least, it
could be -- I don't know offhand how GM1 and GM2 work.)  This is not an
insoluble problem.

> Already known to happen with raw myrinet, so there is a kernel layer
> on top of it to shield it (or at least try to).

Perhaps that's the case with GM1 (I don't know) but it is not a
fundamental flaw of the hardware or the network.

> If there is no kernel involvement, then there can be no restrictions
> on what can be passed down the line to the device.

The MCP provides the necessary checking.

> Now some of the modifications for myrinet were to use normal TCP/IP to
> establish source/destination header information, then bypass any
> packet handshake, but force EACH packet to include the pre-established
> source/destination header info.

I don't know what you're talking about here; perhaps this was some early
"TCP over Myrinet" thing.  Currently on a host with GM1 running, the
myri0 interface shows up as an almost-normal Ethernet interface, and
most of the relevant networking ioctls work just fine.  I can even
tcpdump it.

On a related topic, there is a Myrinet line card with a GigE port
available.  I haven't looked into the software end deeply, but
apparently you just stick a standard Myrinet route to that switch port
on the front of the Myrinet frame, append an Ethernet frame, and your
Myrinet host can send GigE packets without bother.  I don't know how
incoming ethernet packets are routed, alas -- presumably a Myrinet route
is encoded in the MAC somehow.

> This is equivalent to UDP, but without any checksums, and sometimes
> can bypass part of the kernel cache. Unfortunately, it also means that
> sometimes incoming data is NOT destined for the user, and must be 
> erased/copied before the final destination is achieved. This introduces leaks 
> due to the race condition caused by the transfer to the wrong buffer.
> 
> You can't DMA directly to a users buffer, because you MUST verify the header
> before the data... and you can't do that until the buffer is in memory...
> So bypassing the kernel generates security failures.

Again, the security problems are solved by having the MCP check the
necessary conditions.  You bring up a good point WRT error resilience,
though -- I don't know how Myrinet handles media bit errors.

You *can* DMA directly to a user's buffer, because the necessary header
information was checked on the MCP before the bits even touch the PCI
bus.

> This is already a problem in fibre channel devices, and in other network
> devices. Anytime you bypass the kernel security you also void any 
> restrictions on the network, and any hosts it is attached to.

Sufficiently advanced HBA hardware and software solve this problem.
Please pick another windmill to tilt at.  (Like the error one; I need to
find out what the answer to that is.)

-andy
