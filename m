Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRBRKmr>; Sun, 18 Feb 2001 05:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRBRKmi>; Sun, 18 Feb 2001 05:42:38 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:9096 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S132674AbRBRKmS>;
	Sun, 18 Feb 2001 05:42:18 -0500
Message-Id: <l0313034cb6b549ad70fa@[192.168.239.101]>
In-Reply-To: <200102180823.f1I8Nqr16293@gate.dodgy.net.au>
In-Reply-To: <l0313034bb6b52c1d7efa@[192.168.239.101]> from "Jonathan
 Morton" at Feb 18, 2001 07:38:15 AM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 18 Feb 2001 10:41:54 +0000
To: Darren Tucker <dtucker@zip.com.au>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: re. too long mac address for --mac-source netfilter option
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >1) I know that some of the the MAC addresses given by tcpdump are
>> >invalid. Is this a bug? In what?
>>
>> Nope.  The addresses (with mostly zeroes) are like IP addressses with many
>> zeroes or '255' - they handle concepts like "broadcast" or "me".
>
>Huh? It's a vanilla unicast IP datagram over ethernet. Not broadcast or
>multicast. It should have the MAC addresses of the source and destination
>devices. (In fact, it does, since I've just fired up SMS network monitor
>on my work laptop and sniffed it.)
>
>It's like the destination address in the ethernet frame is being stomped
>before being handed to tcpdump

Or, it hasn't acquired it yet because it hasn't passed through the Ethernet
hardware.  So it'll read as the generic MAC address for "me" (0:0:0:0:0:1)
until it actually goes on the wire and comes back off again.  This is
almost certainly what's happening in the outgoing packet.

In the case of the reply packet, which is an ICMP error message, the source
MAC address is all zeroes - this may simply be an indication saying "this
packet could have come from anywhere, please don't reply".  The packet
causing the ICMP error message is detailed within the ICMP message itself,
and the host where the error originated is detailed in the IP header.

.... runs some tests on own hardware ....

OK, now I'm confused.  I'm watching tcpdump of some perfectly ordinary
stuff going on between a 2.2.16 machine (helium, using eepro) and a 2.4.1
box (lithium, using via-rhine).  Here's an NTP exchange:

10:01:51.113583 < 0:50:ba:aa:77:88 0:0:0:0:0:1 ip 90:
lithium.chromatix.org.uk.ntp > helium.chromatix.org.uk.ntp: v4 client strat
4
poll 6 prec -17 dist 0.019088 disp 0.036071 ref
helium.chromatix.org.uk@3191479248.131119996 orig 3191479248.135523006 rec
-0.004402999 xmt +62.985828995 (DF) (ttl 64, id 0)
                         4500 004c 0000 4000 4011 da7b c0a8 ef6b
                         c0a8 ef68 007b 007b 0038 1076 2304 06ef
                         0000 04e3 0000 093c c0a8 ef68 be3a 1bd0
                         2191 148f be3a 1bd0 22b1 a2a4 be3a 1bd0
                         2191 148f be3a 1c0f 1f10 ecb7

This packet is incoming to helium, and it shows the MAC address of lithium
along with the so-called "me" address I mentioned.

10:01:51.123585 > 0:0:0:0:0:0 0:aa:0:aa:7a:86 ip 90:
helium.chromatix.org.uk.ntp > lithium.chromatix.org.uk.ntp: v4 server strat
3 p
oll 6 prec -16 dist 0.015533 disp 0.026077 ref
dns.lancs.ac.uk@3191478910.586125016 orig 3191479311.121352002 rec
+0.002871999 xmt +0.003857000 (ttl 64, id 42171)
                         4500 004c a4bb 0000 4011 75c0 c0a8 ef68
                         c0a8 ef6b 007b 007b 0038 621a 2403 06f0
                         0000 03fa 0000 06ad 9458 0804 be3a 1a7e
                         960c 49ba be3a 1c0f 1f10 ecb7 be3a 1c0f
                         1fcd 24e1 be3a 1c0f 200d b270

This one is outgoing, and it contains helium's *OWN* MAC address, and the
all-zeroes one.  I'm fairly sure NTP doesn't use broadcast, at least in my
configuration.

10:08:24.365128 M 0:0:94:61:aa:83 1:0:0:0:0:0 0004 50: snap atalkarp aarp
len 28 op 256 htype 256 ptype 0x9b80 halen 6 palen 4
                         aaaa 0300 0000 80f3 0001 809b 0604 0001
                         0000 9461 aa83 00ff 00a3 0000 0000 0000
                         00ff 00ad

This is an interesting one - it's a multicast packet from one of my Macs,
performing some obscure AppleTalk thing (AARP == AppleTalk Address
Resolution Protocol, so it's really not that obscure).  Notice the
pseudo-MAC is different here than in the incoming NTP packet.  The real
MAC, in the first MAC field, is that of the Mac sending the AARP query
(turns out to be the Quadra, after searching through the control panels on
the several Macs I have).

.... reconsiders situation ....

Looks like it could either be a bug, or an obscure feature which neither of
us have noticed yet.  From the tcpdump manpage: "On ethernets, the source
and destination addresses, protocol and packet length are printed."  This
may well be the case, but it doesn't match up with what's showing up in the
above traces, or in yours either.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


