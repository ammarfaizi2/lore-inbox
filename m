Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRKZCZR>; Sun, 25 Nov 2001 21:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281420AbRKZCZI>; Sun, 25 Nov 2001 21:25:08 -0500
Received: from [199.247.156.30] ([199.247.156.30]:3262 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id <S281416AbRKZCYy>; Sun, 25 Nov 2001 21:24:54 -0500
From: pjordan@whitehorse.blackwire.com
Date: Sun, 25 Nov 2001 18:19:21 -0800
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
Message-ID: <20011125181921.A16765@panama>
In-Reply-To: <Pine.LNX.4.33.0111251117310.823-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111251117310.823-100000@u.domain.uli>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Hello,

hi.

> >        16.bit Opcode                  = 2 (Reply)
> >        48.bit Sender Ethernet Address = Hardware address of interface
> >        32.bit Sender IP Address       = Local IP address
> >        48.bit Target Ethernet Address = Sender Addr in Request packet
> >        32.bit Target IP Address       = Local IP Address

> THA. Why to do duplicate address detection with SIP loaded with TIP?
> There is already a way to do DAD: with SIP=0. May be the authors don't
> know this solution? SIP=0 is used exactly for this purpose, not to

Could you point me to some documentation on this method, if you know
where some is ?

> election process, something like VRRP. Or may be to configure the

VRRP ?

> values in remote caches) but I'm not sure the proposed scheme to remove
> the duplicated IP is the best we can see, how you feel it?:

I would have to study the problem in more depth to give a good answer,
I am primarily concerned with not having to maintain a 'personal'
kernel patch to get DHCP relaying to work for G4's.  I doubt
writing Apple would get any responses :(

> [
>  (iii) If a host receives an ARP reply with both sender IP address
>       and the target IP address fields match one of its interfaces,
>       it MUST turn off the interface to stop using this address.
>       It May log or display warning messages to indicate the error.
> ]
> 
> 	What happens if we don't want to do it? Also, think for
> shared IP addresses (same IP on many hosts, not advertised with
> ARP from all hosts but still configured on some interface).

 I agree this MUST is overkill.  but then also
 'what is we want to send a normal arp packet ?'
 
> 	IMO, the clients that do duplicate address detection shouldn't
> drop replies that have THA != Destination Hardware Address. What is
> that? A security measure? Linux does not check THA at all. And DAD

I believe this is common behaviour for non-promiscuous interfaces .. ?
I agree it would be nicer if it didn't drop it but it does, and
DHCP relaying is a perfectly valid thing to do, so the current
code breaks this (for the G4 OF, possibly for other platforms as well).


> Should be performed with SIP=0, why with SIP==TIP and when detection
> is detected (and the remote caches damaged) the TIP to be unconfigured?
> SIP=0 is the only way not to disturb the others because both the
> requests and the replies with SIP!=0 can damage the caches (because
> they are broadcasts destined to ff:ff:ff:ff:ff:ff).

 Indeed that experimental document does not address arp cache corruption
 at all.  Presumably hosts would have to ignore packets
 that have SIP and TIP the same unless it is what they are using...
 
> 	If your fix works for "PowerPC Open Firmware" then this
> stack performs extra checks that I'm not sure they are specified
> somewhere and are needed at all. May be I'm missing some standard?

Who can we ask for an answer as to why this might be done ?

Hmm. http://www.freesoft.org/CIE/RFC/826/6.htm

Shows a pseudo-code that indicates a check should
be performed to see if THA is "ours" and if not, discard the packet

-- BEGIN snippet --

When an address resolution packet is received, the receiving Ethernet module gives the packet to the Address Resolution module which goes through an
algorithm similar to the following. Negative conditionals indicate an end of processing and a discarding of the packet. 

?Do I have the hardware type in ar$hrd?
Yes: (almost definitely)
  [optionally check the hardware length ar$hln]
  ?Do I speak the protocol in ar$pro?
  Yes:
    [optionally check the protocol length ar$pln]
    Merge_flag := false
    If the pair  is
        already in my translation table, update the sender
        hardware address field of the entry with the new
        information in the packet and set Merge_flag to true. 
    ?Am I the target protocol address?
    Yes:

-- END snippet --


Maybe the right fix then is to set DHA to all ones. ffffffffffff. ?

Regards,

Peter
