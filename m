Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280803AbRKYKLo>; Sun, 25 Nov 2001 05:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKYKLf>; Sun, 25 Nov 2001 05:11:35 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:2821 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S280803AbRKYKLZ>;
	Sun, 25 Nov 2001 05:11:25 -0500
Date: Sun, 25 Nov 2001 12:10:11 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: <pjordan@whitehorse.blackwire.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
Message-ID: <Pine.LNX.4.33.0111251117310.823-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

pjordan@whitehorse.blackwire.com wrote:

>        16.bit Opcode                  = 2 (Reply)
>        48.bit Sender Ethernet Address = Hardware address of interface
>        32.bit Sender IP Address       = Local IP address
>        48.bit Target Ethernet Address = Sender Addr in Request packet
>        32.bit Target IP Address       = Local IP Address

	It seems in this experimental draft we see that the symmetry
is broken. The reply is from SIP to TIP and both are "Local IP address"
but the SHA and THA are different. When in replies SIP==TIP this is
something like we reply ourselfs. IMO, the same should be for SHA and
THA. Why to do duplicate address detection with SIP loaded with TIP?
There is already a way to do DAD: with SIP=0. May be the authors don't
know this solution? SIP=0 is used exactly for this purpose, not to
disturb the other hosts that already know TIP by some MAC. In this
draft I was not able to understand how DAD is performed. Of course,
with any mechanism used there is a race where two host can do DAD,
then nobody replies and then the both decide to configure the IPs.
But then who will agree to remove its IP? Someone would require
election process, something like VRRP. Or may be to configure the
IP (but not to advertise it if other hosts ask, i.e. passive mode),
to do DAD with SIP 0, to wait 1-2 seconds (or short random time) and
during that time to listen for remote hosts doing DAD and if
there are no other hosts that do DAD to advertise the IP. I agree that
after the IP is configured gratuitous ARP can be sent (and it is used in
setups where the IP is moved between the hosts to update the cached
values in remote caches) but I'm not sure the proposed scheme to remove
the duplicated IP is the best we can see, how you feel it?:

[
 (iii) If a host receives an ARP reply with both sender IP address
      and the target IP address fields match one of its interfaces,
      it MUST turn off the interface to stop using this address.
      It May log or display warning messages to indicate the error.
]

	What happens if we don't want to do it? Also, think for
shared IP addresses (same IP on many hosts, not advertised with
ARP from all hosts but still configured on some interface).

> So again, how does the snippet of code at the top of this message from arp.c
> in any way follow this scheme.  It looks for arp packets from 0.0.0.0
> not packets with 'target and sender IP address are the same'.

	IMO, the clients that do duplicate address detection shouldn't
drop replies that have THA != Destination Hardware Address. What is
that? A security measure? Linux does not check THA at all. And DAD
should be performed with SIP=0, why with SIP==TIP and when detection
is detected (and the remote caches damaged) the TIP to be unconfigured?
SIP=0 is the only way not to disturb the others because both the
requests and the replies with SIP!=0 can damage the caches (because
they are broadcasts destined to ff:ff:ff:ff:ff:ff).

	If your fix works for "PowerPC Open Firmware" then this
stack performs extra checks that I'm not sure they are specified
somewhere and are needed at all. May be I'm missing some standard?

Regards

--
Julian Anastasov <ja@ssi.bg>

