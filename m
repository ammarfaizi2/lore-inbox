Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUKXC57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUKXC57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUKXC57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:57:59 -0500
Received: from mail.inter-page.com ([207.42.84.180]:52238 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261697AbUKXC5z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:57:55 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Karel Kulhavy'" <clock@twibright.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Running Ethernet without ARP
Date: Tue, 23 Nov 2004 18:57:44 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAcgJJ8xN8z0OjbhB04wuPGAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041123140025.GA32447@beton.cybernet.src>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Skipping the question of _why_ you would want to do this for a moment.

_IF_ you connect two and only two devices, then each machine can use the "anything I
didn't send is for me" metric and you can send hand-crafted packets to the hardware
(MAC) broadcast address.  This is the overly-short version of how things like the arp
request works in the first place.  "All the other adapters" will get the packet and
process it.  [In the case of ARP, only the machine owning the IP address responds, so
we all learn the IP/MAC address binding.]

If you intend this link to carry IP packets then you'll have to see to making sure
that all the IP stuff still works out right.  If not, the "optimization" of removing
ARP will just lead to more CPU load (or something) while the nonsensical IP headers
are processed for the bad packets.  Again you could use the IP broadcast address and
the "I didn't send it, so it's for me" logic.

To some extent, doing the IP broadcasting makes the ARP stuff factor out "for free"
in that you don't ever have to ARP request/respond when using the (sub)net broadcast
address for the "locally attached" network segment.

So that gets you back to what you require/mean by the link "working".  If you have
intimate control over the exact nature of the data being transmitted (e.g. this isn't
a general IP service/router experience) then you can do all sorts of stuff to meet
highly specialized designs.  [e.g. I have worked "component based" measuring
equipment that linked the components via Ethernet chipsets/hardware but didn't do
anything remotely like IP.]  In the routing case you cannot (usefully) rewrite the IP
header without building a point-to-point tunnel between the two machines, which would
cost you more than ARPing anyway. 

So that also begs the question of why ARP is so undesirable?  It isn't that expensive
and without hand-coded MAC address limiting peer tables, it is no more/less secure
than the wire anyway.

The short version is that there is no "free or nearly free" way to do this for a
_generalized_ application.  You would be looking at a lot of work.  For very specific
applications (from-scratch work) you may be able to coerce your design into a simple
pattern like IP or MAC broadcasting.

The link-without-ARP requirement (with no access to one machine and blind
interoperability) sounds an awful lot like some of the odd requirements for
not-secure-to-secure network bridging from some of the government contracts I've run
across.  If you are trying to do the whole no-round-trip bridge [e.g. "provable"
one-way, fiber link with only one connector, blind transfer, public-to-secure bridge]
stuff for a particular set of data or protocols (SNMP Trap promotion being a big
perennial culprit for government monitoring at security boundaries 8-) put the/a
receiver endpoint/processor on the public machine, wrap the *entire* packet into
MAC-level broadcast packet (e.g. your own one-sided broadcast protocol) and assert it
on the one-way adapter using the raw packet interface.  At the secure end, crack
"your" protocol packets, do the security cooking as necessary (rewrite the trap
source etc), and then forward the resulting packet like it were normal.  (been there,
done that, /sigh)

That was a lot of guessing, but hope that helps.

Rob White,
Casabyte, Inc.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Karel Kulhavy
 man netdevice says:
"IFF_NOARP	No arp protocol, L2 deswtination address not set".
Is it possible to run ptp Ethernet link between two Linux routers this
way? I would like to run the link with two constraints:
1) no ARP protocol used
2) The link should continue to work even if root access to one computer is
inaccessible and the NIC in the other one is replaced without changing it's MAC
(for example because it doesn't support MAC change)


