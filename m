Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTHFS72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270877AbTHFS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:59:28 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:16371 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S270875AbTHFS7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:59:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: TOE brain dump
Date: Wed, 6 Aug 2003 13:58:59 -0500
X-Mailer: KMail [version 1.2]
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030802140444.E5798@almesberger.net> <03080607463300.08387@tabby> <20030806112556.C26920@hexapodia.org>
In-Reply-To: <20030806112556.C26920@hexapodia.org>
MIME-Version: 1.0
Message-Id: <03080613585900.09086@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 11:25, Andy Isaacson wrote:
> On Wed, Aug 06, 2003 at 07:46:33AM -0500, Jesse Pollard wrote:
> > On Tuesday 05 August 2003 12:19, Eric W. Biederman wrote:
> > > So store and forward of packets in a 3 layer switch hierarchy, at 1.3
> > > us per copy. 1.3us to the NIC + 1.3us to the first switch chip + 1.3us
> > > to the second switch chip + 1.3us to the top level switch chip + 1.3us
> > > to a middle layer switch chip + 1.3us to the receiving NIC + 1.3us the
> > > receiver.
> > >
> > > 1.3us * 7 = 9.1us to deliver a packet to the other side.  That is
> > > still quite painful.  Right now I can get better latencies over any of
> > > the cluster interconnects.  I think 5 us is the current low end, with
> > > the high end being about 1 us.
> >
> > I think you are off here since the second and third layer should not
> > recompute checksums other than for the header (if they even did that).
> > Most of the switches I used (mind, not configured) were wire speed. Only
> > header checksums had recomputes, and I understood it was only for
> > routing.
>
> The switches may be "wire speed" but that doesn't help the latency any.
> AFAIK all GigE switches are store-and-forward, which automatically costs
> you the full 1.3us for each link hop.  (I didn't check Eric's numbers,
> so I don't know that 1.3us is the right value, but it sounds right.)
> Also I think you might be confused about what Eric meant by "3 layer
> switch hierarchy"; he's referring to a tree topology network with
> layer-one switches connecting hosts, layer-two switches connecting
> layer-one switches, and layer-three switches connecting layer-two
> switches.  This means that your worst-case node-to-node latency has 6
> wire hops with 7 "read the entire packet into memory" operations,
> depending on how you count the initiating node's generation of the
> packet.

If it reads the packet into memory before starting transmission, it isn't
"wire speed". It is a router.

> [snip]
>
> > > Quite often in MPI when a message is sent the program cannot continue
> > > until the reply is received.  Possibly this is a fundamental problem
> > > with the application programming model, encouraging applications to
> > > be latency sensitive.  But it is a well established API and
> > > programming paradigm so it has to be lived with.
>
> This is true, in HPC.  Some of the problem is the APIs encouraging such
> behavior; another part of the problem is that sometimes, the problem has
> fundamental latency dependencies that cannot be programmed around.
>
> > > A lot of the NICs which are used for MPI tend to be smart for two
> > > reasons.  1) So they can do source routing. 2) So they can safely
> > > export some of their interface to user space, so in the fast path
> > > they can bypass the kernel.
> >
> > And bypass any security checks required. A single rogue MPI application
> > using such an interface can/will bring the cluster down.
>
> This is just false.  Kernel bypass (done properly) has no negative
> effect on system stability, either on-node or on-network.  By "done
> properly" I mean that the NIC has mappings programmed into it by the
> kernel at app-startup time, and properly bounds-checks all remote DMA,
> and has a method for verifying that incoming packets are not rogue or
> corrupt.  (Of course a rogue *kernel* can probably interfere with other
> *applications* on the network it's connected to, by inserting malicious
> packets into the datastream, but even that is soluble with cookies or
> routing checks.  However, I don't believe any systems try to defend
> against rogue nodes today.)

Just because the packet gets transfered to a buffer correctly does not
mean that buffer is the one it should have been sent to. If it didn't
have this problem, then there would be no kernel TCP/IP interaction. Just
open the ethernet device and start writing/reading. Ooops. known security
failure.

>
> I believe that Myrinet's hardware has the capability to meet the "kernel
> bypass done properly" requirement I state above; I make no claim that
> their GM implementation actually meets the requirement (although I think
> it might).  It's pretty likely that QSW's Elan hardware can, too, but I
> know even less about that.

since the routing is done is user mode, as part of the library, it can be
used to directly affect processes NOT owned by the user. This bypasses
the kernel security checks by definition. Already known to happen with
raw myrinet, so there is a kernel layer on top of it to shield it (or
at least try to). If there is no kernel involvement, then there can be
no restrictions on what can be passed down the line to the device. Now
some of the modifications for myrinet were to use normal TCP/IP to establish
source/destination header information, then bypass any packet handshake, but
force EACH packet to include the pre-established source/destination header 
info. This is equivalent to UDP, but without any checksums, and sometimes
can bypass part of the kernel cache. Unfortunately, it also means that
sometimes incoming data is NOT destined for the user, and must be 
erased/copied before the final destination is achieved. This introduces leaks 
due to the race condition caused by the transfer to the wrong buffer.

You can't DMA directly to a users buffer, because you MUST verify the header
before the data... and you can't do that until the buffer is in memory...
So bypassing the kernel generates security failures.

This is already a problem in fibre channel devices, and in other network
devices. Anytime you bypass the kernel security you also void any 
restrictions on the network, and any hosts it is attached to.
