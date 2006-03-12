Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWCLPdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWCLPdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWCLPdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:33:14 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:49672 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1751006AbWCLPdN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:33:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 12 Mar 2006 09:34:21 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321DD@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZEpegrpnJZ+OnzSzW0oMzj9J0s+AAEMo2gAExOLwA=
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Bart Samwel" <bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart and I had a private discussion about this.  I was able to prove
that routing stops when "fudged" MAC Addresses on the router don't match
the hardware MAC Addresses.  And routing starts back up again when the I
change the "fudged" MAC Addresses back to match the hardware MAC
Addresses.  

There are lots of Linux router failover implementations.  They all seem
to use gratuitous ARPs instead of a virtual MAC Address and now I see
why - it doesn't look like the kernel completely supports virtual MAC
Addresses.  But I don't think gratuitous ARPs are the right answer -
they are still disruptive in a failover and something somewhere will
break.  If the kernel could do routing with virtual MAC Addresses, we
wouldn't need gratuitous ARP.

There must be a kernel data structure someplace that has the "fudged"
MAC Address.  I wonder how difficult it would be to do a patch to make
routing use this same data structure instead of the hardware MAC
Address?  
 
- Greg Scott



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg Scott
Sent: Friday, March 10, 2006 9:08 PM
To: linux-kernel@vger.kernel.org
Cc: Bart Samwel
Subject: RE: Router stops routing after changing MAC Address

 
> I think you're not testing hotswapping machines with equal MAC 
> addresses here, you're testing hot-changing the MAC address for a 
> gateway IP. The machine on the "right side"
> that the machine on the left side is pinging probably still has the 
> old MAC address for its gateway in it's ARP cache, so the echo reply 
> will be sent to the wrong MAC address. ( Or am I talking nonsense 
> here?)
>
> --Bart

I sometimes wonder if I'm going crazy myself.  :)

My ultimate goal is to hotswap machines with equal MAC Addresses.  I
built up two machines, hotswapped, and pinged to each one - and it all
worked.  Who would have believed they would refuse to forward packets
when I tried to put them into production?  After my installation went
haywire, my little testbed right now has one gateway in the middle and
one system on the right and one on the left.  So, yes, right now I am
hot-changing MAC addresses on this gateway, trying to get closer to the
problem where routers don't route when the MAC Address is different than
the hardware MAC Address.

Anyway, just to be completely anal about this I put the original MAC
Addresses on the middle gateway and set up the system on the right to
ping the middle gateway.  This worked.  With the pings still going, I
fudged the MAC Addresses in the middle gateway.  The echo replies to the
right stopped for about 30 seconds while its ARP cache cleared.  After
about 30 seconds, the echo replies started coming again as expected.
But the left could never ping the right after fudging MAC Addresses on
the middle gateway.  

So far, no matter what, left and right do not see eachother when the
middle has fudged MAC Addresses.  But when middle has hardware MAC
Addresses, left and right see each other just fine.  

I don't see any way the problem could be related to ARP caches.

- Greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
