Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313946AbSEAThE>; Wed, 1 May 2002 15:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313947AbSEAThD>; Wed, 1 May 2002 15:37:03 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:35538 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S313946AbSEAThC>;
	Wed, 1 May 2002 15:37:02 -0400
Date: Wed, 1 May 2002 15:37:02 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Andi Kleen <ak@suse.de>
Cc: Bryan Rittmeyer <bryan@ixiacom.com>, <warchild@spoofed.org>,
        <linux-kernel@vger.kernel.org>
Subject: Dirty memory? (WAS Re: remote memory reading using arp?)
In-Reply-To: <20020429173144.A4044@wotan.suse.de>
Message-ID: <Pine.LNX.4.33L2.0205011517060.26604-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002, Andi Kleen wrote:

> On Mon, Apr 29, 2002 at 11:24:04AM -0400, Calin A. Culianu wrote:
> > On 28 Apr 2002, Andi Kleen wrote:
> >
> > > Bryan Rittmeyer <bryan@ixiacom.com> writes:
> > >
> > > > It's not the ARP layer that's causing the padding... Ethernet has a
> > > > minimum transmit size of 64 bytes (everything below that is disgarded
> > > > by hardware as a fragment), so the network device driver or
> > > > the hardware itself will pad any Linux skb smaller than 60 bytes up to
> > > > that size (so that it's 64 bytes after appending CRC32). Apparently, in
> > > > some cases that's done by just transmitting whatever uninitialized
> > > > memory follows skb->data, which, after the system has been running
> > > > for a while, may be inside a page previously used by userspace.
> > >
> > > The driver should be fixed in that case. I would consider it a driver
> > > bug. The cost of clearing the tail should be minimal, it is at most
> >
> > Yes, I wholeheartedly agree.  Also, the notion that it's userspace's
> > responsibility to clear memory before exiting is preposterous.  That would
> > involve just about every piece of software ever made to be rewritten (you
> > could change glibc to clear memory on free()s but what about the stack?).
>
> It actually requires more changes. The skbuff allocator needs to
> be fixed too to ensure a 64 bytes minimum length of the skb.
> (or alternatively if you don't want to penalize non ethernet protocols
> read minlen from a dev-> field similar to hard_header_len and compute it
> in the caller, but that's likely overkill)

Well, that sounds pretty elegant.  After all, it makes sense for the
caller to ensure the data field in his skbuff is at least as big as the
(MTU? is this the field we want in struct net_device?) for his dev...

>
> But should be done.

I am glad you think so.  More generally, once can make the argument that
to be 100% secure, one needs to revisit a lot of the kernel memory
allocations (not just in the networking code) and see if the following two
criteria are met:  any of the memory allocated could potentially be/remain
'dirty' for a while && there is a possibility that the contents of that
memory could make their way into 'untrusted' hands.  Things like giving
the dirty memory to userspace or sending portions of it down the network
wire are examples of placing it in untrusted hands.

I am not sure if this is a can of worms worth opening.  While it would be
nice for the kernel to reliably provide guarantees about memory and its
'cleanliness' and privateness (after all this is one third the reason for
memory protection in the first place!), it may be a lot of trouble
performancewise....  however it still is an interesting problem to look
at...

I wonder if any other operating systems have addressed the issue of memory
allocators and the possibility that the memory they return may contain
sensitive data?

-Calin

>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

