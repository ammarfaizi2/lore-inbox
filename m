Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRKXWCc>; Sat, 24 Nov 2001 17:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280361AbRKXWCO>; Sat, 24 Nov 2001 17:02:14 -0500
Received: from [199.247.156.30] ([199.247.156.30]:7357 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id <S280343AbRKXWBz>; Sat, 24 Nov 2001 17:01:55 -0500
From: pjordan@whitehorse.blackwire.com
Date: Sat, 24 Nov 2001 13:56:34 -0800
To: linux-kernel@vger.kernel.org
Subject: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
Message-ID: <20011124135634.A10478@panama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

The following lines from arp.c refer to somethign in RFC2131 as an excuse for
sending out a malformed arp packet.

        /* Special case: IPv4 duplicate address detection packet (RFC2131) */
        if (sip == 0) {
                if (arp->ar_op == __constant_htons(ARPOP_REQUEST) &&
                    inet_addr_type(tip) == RTN_LOCAL)
                        arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_addr);
                goto out;
        }


In practice, when using a dhcp relay agent, and a client
(PowerPC Open Firmware in this example) sends a "gratutitous arp"

'arp who-has' from 0.0.0.0 to 192.168.2.1 for example,
the above lines of code send an arp reply that does not have the mac address
of the interface that made the 'arp who-has' and thus this interface
is not able to see the reply.  This means that now 192.168.2.1
is invisible to this machine and it can communicate with it.

Asjusting the above line to :
    arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);

fixes the problem and normal communication can occur.
This of course makes this paragraph completely irrelevant.

Furthemre the following section from RFC2131 makes NO reference
to sending an arp packet with such a malformed structure.
"must fill in its own hardware address as the sender's hardware address"
is not strange behaviour, and DOES NOT refer to what a machine should
do when it RECEIVES an arp request packet from IP 0.0.0.0, but refers to
what a machine should do when it SENDS a gratuitous arp packet, one that
is not a response to an 'arp who-has' but IS an 'arp who-has'.

RFC2131 snippet BEGIN

     The client SHOULD perform a check on the
   suggested address to ensure that the address is not already in use.  For
   example, if the client is on a network that supports ARP, the client may
   issue an ARP request for the suggested request.  When broadcasting an ARP
   request for the suggested address, the client must fill in its own hardware
   address as the sender's hardware address, and 0 as the sender's IP address,
   to avoid confusing ARP caches in other hosts on the same subnet.  If the
   network address appears to be in use, the client MUST send a DHCPDECLINE
   message to the server.  The client SHOULD broadcast an ARP reply to announce
   the client's new IP address and clear any outdated ARP cache entries in
   hosts on the client's subnet.

RFC2131 snippet END


Furthermore,

In http://alternic.net/drafts/drafts-j-k/draft-jou-duplicate-ip-address-01.html

Which Updates RFC 826


We see reference to the gratuitous arp packet reception and the proper reply.

BEGIN snippet

   (ii) If a host receives an ARP request packet in which the
      Target IP address and the Sender IP address are the same and it
      matches one of its interface addresses, it then implies
      IP address duplication happens. The host MUST send a link layer
      broadcast ARP reply as defined below. The host MAY also log or
      display warning messages to indicate the detection of IP address
      duplication.

       48.bit Destination Address     = 0xffffffffffff (broadcast)
       48.bit Source Address          = Hardware adderss of interface
       16.bit Frame type              = 0x806 (ARP)
       ----------------------
       16.bit Hardware type           = 0x1 (Ethernet)
       16.bit Protocol Type           = 0x800 (IP)
        8.bit Hardware Address size   = 6
        8.bit Protocol Address size   = 4
       16.bit Opcode                  = 2 (Reply)
       48.bit Sender Ethernet Address = Hardware address of interface
       32.bit Sender IP Address       = Local IP address
       48.bit Target Ethernet Address = Sender Addr in Request packet
       32.bit Target IP Address       = Local IP Address

END snippet

So here yes we see sender and target IP and ethernet addresses being
sent out as the local addresses, but note that the first two lines refer to

   (ii) If a host receives an ARP request packet in which the
      Target IP address and the Sender IP address are the same and it

So again, how does the snippet of code at the top of this message from arp.c
in any way follow this scheme.  It looks for arp packets from 0.0.0.0
not packets with 'target and sender IP address are the same'.



So, can we have this apparently stupid error fixed please.
.. or can someone show the stupidity in my reasoning.

Kind regards,

Peter
