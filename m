Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRKZLKA>; Mon, 26 Nov 2001 06:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280612AbRKZLJu>; Mon, 26 Nov 2001 06:09:50 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:7173 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S280620AbRKZLJc>;
	Mon, 26 Nov 2001 06:09:32 -0500
Date: Mon, 26 Nov 2001 13:12:44 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: <pjordan@whitehorse.blackwire.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
In-Reply-To: <20011125181921.A16765@panama>
Message-ID: <Pine.LNX.4.33.0111261212330.3166-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sun, 25 Nov 2001 pjordan@whitehorse.blackwire.com wrote:

> > THA. Why to do duplicate address detection with SIP loaded with TIP?
> > There is already a way to do DAD: with SIP=0. May be the authors don't
> > know this solution? SIP=0 is used exactly for this purpose, not to
>
> Could you point me to some documentation on this method, if you know
> where some is ?

	You already mentioned it, DHCP SHOULD use SIP=0.0.0.0.

> > election process, something like VRRP. Or may be to configure the
>
> VRRP ?

	RFC2338. It guarantees unique IP but tries to keep the MAC.
It has other purposes.

> I am primarily concerned with not having to maintain a 'personal'
> kernel patch to get DHCP relaying to work for G4's.  I doubt
> writing Apple would get any responses :(

	Hm

>  I agree this MUST is overkill.  but then also
>  'what is we want to send a normal arp packet ?'

	Can you explain? I don't understand the Q

> > 	IMO, the clients that do duplicate address detection shouldn't
> > drop replies that have THA != Destination Hardware Address. What is
> > that? A security measure? Linux does not check THA at all. And DAD
>
> I believe this is common behaviour for non-promiscuous interfaces .. ?

	No, the ARP reply is destined directly to the target MAC but
with ARP data SIP==TIP and SHA==THA, i.e. THA!=target MAC

> > 	If your fix works for "PowerPC Open Firmware" then this
> > stack performs extra checks that I'm not sure they are specified
> > somewhere and are needed at all. May be I'm missing some standard?
>
> Who can we ask for an answer as to why this might be done ?

	If the maintainers don't read this thread then contact them
directly. I'm not sure there is a standard for duplicate address
detection. For now ARP is used to do the detection but without
protocol adapted from all vendors I'm not sure it will be race-free.
There are other client-server oriented protocols where the server
guarantees that the given IP is unique. I don't see an easy solution for
DAD for other purposes, i.e. when two hosts try to use same IP without
obtaining it from some authority. May be this is the reason iproute2 to
come with script (user space solution) to configure the IP addresses.
In this case the gap for race is small.

> Maybe the right fix then is to set DHA to all ones. ffffffffffff. ?

	You can try to feed the arp_send call that you change with
dest_hw=NULL and to see whether it works. If it works you will have
a second solution. In any case you need the maintainers' opinion
because it seems nobody recommends anything about the ARP replies,
i.e. for THA when SIP==TIP.

	You are not sure it will not break something else (answering your
next posting). You can also look at RARP (RFC903) where THA==Target MAC
is already a requirement but the request is SIP=0 and TIP=0 (similar
but not related to DAD). RFC2131 states that the client SHOULD perform
DAD for the suggested address from DHCP. Later: "may issue an ARP request".
It seems Linux doesn not like these recommendations.

> Regards,
>
> Peter

Regards

--
Julian Anastasov <ja@ssi.bg>

