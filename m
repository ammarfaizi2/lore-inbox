Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135685AbRDSOn2>; Thu, 19 Apr 2001 10:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135684AbRDSOnT>; Thu, 19 Apr 2001 10:43:19 -0400
Received: from [203.117.131.2] ([203.117.131.2]:53241 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S135674AbRDSOnB>; Thu, 19 Apr 2001 10:43:01 -0400
From: "Michael Clark" <michael@metaparadigm.com>
To: "Manfred Bartz" <md-linux-kernel@logi.cc>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>
Subject: RE: Real Time Traffic Flow Measurement - anybody working on it?
Date: Thu, 19 Apr 2001 22:45:29 +0800
Message-ID: <HBEEKENFCJOPCENEDAGHOEAECCAA.michael@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010419041557.26172.qmail@logi.cc>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't say i'm actively working on it but I've emailed Nevil to see if
he knows of any RTFM work that is being done on Linux.

Although here's some observations:

Userspace pcap meters (such as NeTreMet) can measure traffic IP stack
doesn't even see (useful for a probe on a span port for instance) -
can also meter other protocols.

An obvious kernel improvement for userspace meters like NeTraMet would
be to give libpcap's pcap_read a kernel interface that can return more
than one packet at a time (the libpcap interface has this capability).
The current linux libpcap implementation incurs a read syscall per
packet.

An additional feature for network devices that could support it (not
sure if this is feasible) would be to switch to an 'interrupt when
packet buffer full' when in promiscuous mode.

A libpcap comment lists a bug in packet socket that means you need to
read the entire packet to get the packet length (which I assume means
meters like NeTraMet are forced to set the snaplen really high) -
which is a performance penalty if your just want to read headers but
also need the packet length.

from libpcap-0.6.2/pcap-linux.c

        /*
         * XXX: According to the kernel source we should get the real
         * packet len if calling recvfrom with MSG_TRUNC set. It does
         * not seem to work here :(, but it is supported by this code
         * anyway.
         * To be honest the code RELIES on that feature so this is
really
         * broken with 2.2.x kernels.
         * I spend a day to figure out what's going on and I found out
         * that the following is happening:
         *
         * The packet comes from a random interface and the packet_rcv
         * hook is called with a clone of the packet. That code
inserts
         * the packet into the receive queue of the packet socket.
         * If a filter is attached to that socket that filter is run
         * first - and there lies the problem. The default filter
always
         * cuts the packet at the snaplen:
         *
         * # tcpdump -d
         * (000) ret      #68
         *
         * So the packet filter cuts down the packet. The recvfrom
call
         * says "hey, it's only 68 bytes, it fits into the buffer"
with
         * the result that we don't get the real packet length. This
         * is valid at least until kernel 2.2.17pre6.
         *
         * We currently handle this by making a copy of the filter
         * program, fixing all "ret" instructions with non-zero
         * operands to have an operand of 65535 so that the filter
         * doesn't truncate the packet, and supplying that modified
         * filter to the kernel.
         */

~mc

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
> Manfred Bartz
> Sent: Thursday, 19 April 2001 12:16 p.m.
> To: linux-kernel@vger.kernel.org
> Subject: Real Time Traffic Flow Measurement - anybody working on it?
>
>
> Through the stimulating discussion we had under ``IP Acounting
> Idea for 2.5'', it appears that a separate Traffic Flow Measure-
> ment and Accounting sub-system would be useful. See:
>         <http://logi.cc/linux/CounterReset/>
>
> If anybody is working on Real Time Traffic Flow Measurement (RTFM)
> please reply.
>
> I would also like to know if there are any objections to providing
> a RTFM interface in the kernel (as an optional module).
>
> FYI:
>
> Considerable work has already been done on RTFM in general and
> for other systems:
>         <http://www2.auckland.ac.nz/net//Internet/rtfm/>
>         <http://www.caida.org/>
>
> Relevant RFCs include: 2720 ... 2724
>
> Thanks
> --
> Manfred Bartz
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

