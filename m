Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTHFQ0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTHFQ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:26:03 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:45209 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S269950AbTHFQZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:25:58 -0400
Date: Wed, 6 Aug 2003 11:25:56 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806112556.C26920@hexapodia.org>
References: <20030802140444.E5798@almesberger.net> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org> <03080607463300.08387@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <03080607463300.08387@tabby>; from jesse@cats-chateau.net on Wed, Aug 06, 2003 at 07:46:33AM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 07:46:33AM -0500, Jesse Pollard wrote:
> On Tuesday 05 August 2003 12:19, Eric W. Biederman wrote:
> > So store and forward of packets in a 3 layer switch hierarchy, at 1.3 us
> > per copy. 1.3us to the NIC + 1.3us to the first switch chip + 1.3us to the
> > second switch chip + 1.3us to the top level switch chip + 1.3us to a middle
> > layer switch chip + 1.3us to the receiving NIC + 1.3us the receiver.
> >
> > 1.3us * 7 = 9.1us to deliver a packet to the other side.  That is
> > still quite painful.  Right now I can get better latencies over any of
> > the cluster interconnects.  I think 5 us is the current low end, with
> > the high end being about 1 us.
> 
> I think you are off here since the second and third layer should not recompute
> checksums other than for the header (if they even did that). Most of the
> switches I used (mind, not configured) were wire speed. Only header checksums
> had recomputes, and I understood it was only for routing.

The switches may be "wire speed" but that doesn't help the latency any.
AFAIK all GigE switches are store-and-forward, which automatically costs
you the full 1.3us for each link hop.  (I didn't check Eric's numbers,
so I don't know that 1.3us is the right value, but it sounds right.)
Also I think you might be confused about what Eric meant by "3 layer
switch hierarchy"; he's referring to a tree topology network with
layer-one switches connecting hosts, layer-two switches connecting
layer-one switches, and layer-three switches connecting layer-two
switches.  This means that your worst-case node-to-node latency has 6
wire hops with 7 "read the entire packet into memory" operations,
depending on how you count the initiating node's generation of the
packet.

[snip]
> > Quite often in MPI when a message is sent the program cannot continue
> > until the reply is received.  Possibly this is a fundamental problem
> > with the application programming model, encouraging applications to
> > be latency sensitive.  But it is a well established API and
> > programming paradigm so it has to be lived with.

This is true, in HPC.  Some of the problem is the APIs encouraging such
behavior; another part of the problem is that sometimes, the problem has
fundamental latency dependencies that cannot be programmed around.

> > A lot of the NICs which are used for MPI tend to be smart for two
> > reasons.  1) So they can do source routing. 2) So they can safely
> > export some of their interface to user space, so in the fast path
> > they can bypass the kernel.
> 
> And bypass any security checks required. A single rogue MPI application
> using such an interface can/will bring the cluster down.

This is just false.  Kernel bypass (done properly) has no negative
effect on system stability, either on-node or on-network.  By "done
properly" I mean that the NIC has mappings programmed into it by the
kernel at app-startup time, and properly bounds-checks all remote DMA,
and has a method for verifying that incoming packets are not rogue or
corrupt.  (Of course a rogue *kernel* can probably interfere with other
*applications* on the network it's connected to, by inserting malicious
packets into the datastream, but even that is soluble with cookies or
routing checks.  However, I don't believe any systems try to defend
against rogue nodes today.)

I believe that Myrinet's hardware has the capability to meet the "kernel
bypass done properly" requirement I state above; I make no claim that
their GM implementation actually meets the requirement (although I think
it might).  It's pretty likely that QSW's Elan hardware can, too, but I
know even less about that.

-andy
