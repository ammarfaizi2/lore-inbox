Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285316AbRLXUpH>; Mon, 24 Dec 2001 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285317AbRLXUo6>; Mon, 24 Dec 2001 15:44:58 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:33493 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S285316AbRLXUoo>;
	Mon, 24 Dec 2001 15:44:44 -0500
Date: Mon, 24 Dec 2001 20:44:37 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <1062462662.1009226676@[195.224.237.69]>
In-Reply-To: <20011224211726.H2461@lug-owl.de>
In-Reply-To: <20011224211726.H2461@lug-owl.de>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That would give a different result: "functional TCP connections" or
> "non-functional TCP connections". Mine are between that. If data gets
> sent in small chunks, everything is fine, but if it's a larger
> transfer (more than one ethernet frame may transport???), write()
> stalls (or non-blocking write returns), but data is kept in
> Send-Q rather than being sent down to the client.

Just to check the completely obvious:

Difficult / impossible to tell without a tcpdump, but last time I
saw something like this, one end was silently dropping packets
exactly equal to the MTU size (or up to 3 bytes smaller), but
transmitting all other packets (in this instance it was a bizarre
802.11 problem).

What happens is that small files get through, as do files sufficiently
small the TCP window hasn't grown properly, as do interactive sessions
(frequently) but large ftp's appear to die; in fact if you leave them
long enough they recover after a long stall.

This is far easier to diagnose if both devices are on the same segment
(remember it can be an L1/L2 device in the way that does the drop
though).

If you have an L3 device (router etc.) in the middle, you can get
a similar effect if the device does not fragment data correctly
(for instance the Cisco into ip tunnels bug - now fixed I think),
or, if you are using PMTU discovery (probably), if some evil device,
or the end nodes, are filtering out ICMP (or doing something else
which breaks PMTU discovery, such as some types of address filtering
if there is NAT in the way).

If you run tcpdump on both boxes, then for each packet transmitted
you should either see a received packet the other end, or an ICMP
reply (immediately); if you see a long pause, and get a reassembly
failed message come back, or a retransmit, you will know it's this.

I'd recommend testing tcpspray or something simple before looking
at the gory internals of ssh buffer handling (openssh seems cleaner).
I'd also recommend, if you are in an environment that can stand
it, putting the two machines on a common L2 network, close together,
and removing all filters (iptables etc.) and checking that works.

--
Alex Bligh
