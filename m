Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSKQXlf>; Sun, 17 Nov 2002 18:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSKQXlf>; Sun, 17 Nov 2002 18:41:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40786 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267008AbSKQXlc>; Sun, 17 Nov 2002 18:41:32 -0500
To: David Lang <david.lang@digitalinsight.com>
Cc: Brad Hards <bhards@bigpond.net.au>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <Pine.LNX.4.44.0211171359050.10200-100000@dlang.diginsite.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 16:48:09 -0700
In-Reply-To: <Pine.LNX.4.44.0211171359050.10200-100000@dlang.diginsite.com>
Message-ID: <m1of8n3ghy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> On Mon, 18 Nov 2002, Brad Hards wrote:
> 
> > On Mon, 18 Nov 2002 08:32, David Lang wrote:
> > > a couple quick questions from an end-user
> > >
> > > 1. will an interface be dedicated to this use, or will it share an
> > > interface with other traffic.
> > I imagined that it would have to be shared. The world is not a PC, and you
> > can't trivially add extra connectivtity to that embedded ARM board...
> 
> I can see that, it will add more complexity thought

There are only three cases I can see supporting.
- Transmit a kernel message
- Process a MAGIC-SYSRQ packet
- Remote GDB.

For transmitting a kernel message, sharing the nic is really not more
complicated.  It simply preempts the normal driver transmits it's
packet and then goes away.

For processing a MAGIC-SYSRQ that is almost certainly going to be
interrupt driven just a special debug path that can safely execute
inside of the interrupt handler.  For conditions that make the box
unpingable this likely will not help, but very will at that point.

For a remote GDB transmitting a packet is the same as for kernel
messages.  If a packet is expected it just waits on the nic throwing
out the rest of the packets until the one it is expecting comes in.
And if it isn't particularly expecting a packet it can work just like
the MAGIC-SYSRQ case.

So while there is some small additional complexity to sharing the link
I do not think it is significant.  But just because you can share the
link does not mean you have to.
 
> > <snip>
> > > as someone managing 60 or so remote boxes, this sounds really nice, if it
> > > can be made to work securely.
> > OK, I'm confused again. Do you want remote, or to you want link-local?
> 
> I want link-local. as has been discused once you have two boxes in one
> location link-local is good enough and I always deploy boxes in HA
> pairs

I am still trying to hammer down the protocol enough to suit me.
IPv4 Link local IP addresses are not generally appropriate, because 
claim-and-defend is potentially a pain.  IPv6 link-local addresses
look better as everything can be configured statically.  Ideally
everything can be kept simple enough that retransmissions do not need
to at all.  Nor extraneous traffic processing like arp.

Configuration needed:
Interface:         (This should default to none)
Local-ip address:  (For ipv6 we can default to the link-local address
                    derived from the MAC address)
Remote-ip address: (By default this should probably be a multi-cast IP
                    address, derived from the local-ip address)

The important things:
- The ability to have everything hard coded, so you can find the
  network console/network gdb session.

- A trivial implementation that can fire and forget packets.  No
  retransmit should be needed on the machine being debugged.  This is
  over a mostly reliable interface so that should not be a problem.

- A setup that does not loose a connection when you reboot a machine.
  This rules out TCP.

- The ability to have good defaults so you can setup a cluster without
  manual configuration.

The way I envision it, on the debugged machine:
- Transmit:
  TTL=1 to some address (ideally this would be a multicast ip)
- Receive:
  verify TTL=255 ip on the same subnet.  Packet is not fragmented.
  Dest IP is my local ip (Ipv6 link-local ip?)

It will be a little bit before I scratch this itch but I have a good
feeling about how to do it now.

Eric
