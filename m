Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270750AbTHFMrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTHFMrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:47:17 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:55794 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S270750AbTHFMrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:47:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: ebiederm@xmission.com (Eric W. Biederman),
       Werner Almesberger <werner@almesberger.net>
Subject: Re: TOE brain dump
Date: Wed, 6 Aug 2003 07:46:33 -0500
X-Mailer: KMail [version 1.2]
Cc: Jeff Garzik <jgarzik@pobox.com>, Nivedita Singhvi <niv@us.ibm.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030802140444.E5798@almesberger.net> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org>
In-Reply-To: <m1u18wuinm.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <03080607463300.08387@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 12:19, Eric W. Biederman wrote:
> Werner Almesberger <werner@almesberger.net> writes:
> > Eric W. Biederman wrote:
> > > The optimized for low latency cases seem to have a strong
> > > market in clusters.
> >
> > Clusters have captive, no, _desperate_ customers ;-) And it
> > seems that people are just as happy putting MPI as their
> > transport on top of all those link-layer technologies.
>
> MPI is not a transport.  It an interface like the Berkeley sockets
> layer.  The semantics it wants right now are usually mapped to
> TCP/IP when used on an IP network.  Though I suspect SCTP might
> be a better fit.
>
> But right now nothing in the IP stack is a particularly good fit.
>
> Right now there is a very strong feeling among most of the people
> using and developing on clusters that by and large what they are doing
> is not of interest to the general kernel community, and so has no
> chance of going in.   So you see hack piled on top of hack piled on
> top of hack.
>
> Mostly I think the that is less true, at least if they can stand the
> process of severe code review and cleaning up their code.  If we can
> put in code to scale the kernel to 64 processors.  NIC drivers for
> fast interconnects and a few similar tweaks can't hurt either.
>
> But of course to get through the peer review process people need
> to understand what they are doing.
>
> > > There is one place in low latency communications that I can think
> > > of where TCP/IP is not the proper solution.  For low latency
> > > communication the checksum is at the wrong end of the packet.
> >
> > That's one of the few things ATM's AAL5 got right. But in the end,
> > I think it doesn't really matter. At 1 Gbps, an MTU-sized packet
> > flies by within 13 us. At 10 Gbps, it's only 1.3 us. At that point,
> > you may well treat it as an atomic unit.
>
> So store and forward of packets in a 3 layer switch hierarchy, at 1.3 us
> per copy. 1.3us to the NIC + 1.3us to the first switch chip + 1.3us to the
> second switch chip + 1.3us to the top level switch chip + 1.3us to a middle
> layer switch chip + 1.3us to the receiving NIC + 1.3us the receiver.
>
> 1.3us * 7 = 9.1us to deliver a packet to the other side.  That is
> still quite painful.  Right now I can get better latencies over any of
> the cluster interconnects.  I think 5 us is the current low end, with
> the high end being about 1 us.

I think you are off here since the second and third layer should not recompute
checksums other than for the header (if they even did that). Most of the
switches I used (mind, not configured) were wire speed. Only header checksums
had recomputes, and I understood it was only for routing.

> Quite often in MPI when a message is sent the program cannot continue
> until the reply is received.  Possibly this is a fundamental problem
> with the application programming model, encouraging applications to
> be latency sensitive.  But it is a well established API and
> programming paradigm so it has to be lived with.
>
> All of this is pretty much the reverse of the TOE case.  Things are
> latency sensitive because real work needs to be done.  And the more
> latency you have the slower that work gets done.
>
> A lot of the NICs which are used for MPI tend to be smart for two
> reasons.  1) So they can do source routing. 2) So they can safely
> export some of their interface to user space, so in the fast path
> they can bypass the kernel.

And bypass any security checks required. A single rogue MPI application
using such an interface can/will bring the cluster down.

Now this is not as much of a problem since many clusters use a standalone
internal network, AND are single application clusters. These clusters
tend to be relatively small (32 - 64 nodes? perhaps 16-32 is better. The
clusters I've worked with have always been large 128-300 nodes, so I'm
not a good judge of "small").

This is immediately broken when you schedule two or more batch jobs on
a cluster in parallel.

It is also broken if the two jobs require different security contexts.
