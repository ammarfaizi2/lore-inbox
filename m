Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbULFSq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbULFSq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbULFSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:45:45 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:41603 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261608AbULFSpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:45:16 -0500
Date: Mon, 6 Dec 2004 18:44:09 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: jamal <hadi@cyberus.ca>
cc: Thomas Spatzier <thomas.spatzier@de.ibm.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch 4/10] s390: network driver.
In-Reply-To: <1102332479.1048.2243.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.61.0412061813220.16016@hibernia.jakma.org>
References: <OFAF17275D.316533A1-ONC1256F5C.0026AFAD-C1256F5C.002877C1@de.ibm.com>
  <Pine.LNX.4.61.0412050605550.21671@hibernia.jakma.org>
 <1102332479.1048.2243.camel@jzny.localdomain>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, jamal wrote:

> Dont post networking related patches on other lists. I havent seen said
> patch, but it seems someone is complaining about some behavior changing?

I missed the beginning of the thread too, but saw Jeff's reply to 
Thomas on netdev. It appears the original patch was to make the s390 
network driver discard packets on link-down.

Jeff had replied to say this was bad, that queues are meant to fill 
and that this was what other drivers (e1000, tg3) did.

> In regards to link down and packets being queued. Agreed this is a 
> little problematic for some apps/transports.

Tis yes. Particularly for apps using raw and UDP+IP_HDRINCL sockets.

This problem came to light when we got reports of ospfd blocking 
because link was down, late in 2.4 with a certain version of the 
(iirc) e100 driver. ospfd uses one single socket for all interfaces, 
and relies on IP_HDRINCL to have the packet routed out right 
interface. However this approach doesnt play well if the socket can 
be blocked completely because of /one/ interface having its link 
down. The behaviour we expected (and got up until now) is to receive 
either ENOBUFS or else, if the kernel accepts the packet write, for 
it to drop it if it can not be sent.

We can work around that by moving to a socket/interface. However it 
still leaves the problem of packets being queued indefinitely while 
the link is down and being sent when link comes back. This is *not* 
good for RIP, IPv4 IRDP and IPv6 RA.

> In the case the netdevice is administratively downed both the qdisc 
> and DMA ring packets are flushed.

What about any packets remaining in the socket buffer? (if that makes 
sense - i dont know enough about internals sadly). Are those queued?

> Newer packets will never be queued

That no longer appears to be the case though. The socket blocks, and 
/some/ packets are queued (presumably those which still were in the 
socket buffer? i dont know exactly..).

> and you should quickly be able to find from your app that 
> the device is down.

We can yes, via rtnetlink - but impossible to guarantee we'll know 
the link is down before we try write a packet.

> In the case of netdevice being operationally down

?

As in 'ip link set dev ... down'?

> - I am hoping this is what the discussion is, having jumped on it -

No, its for link-down, AIUI.

> both queues stay intact. What you can do is certainly from user 
> space admin down/up the device when you receive a netlink carrier 
> off notification.

That seems possible, but quite a hack. Something to work at a socket 
level would possibly be nicer. (Socket being the primary handle our 
application has).

> I am struggling to see whether dropping the packet inside the tx 
> path once it is operationaly down is so blasphemous ... need to get 
> caffeine first.

As long as reliable transports have some other transport specific 
queue, shouldnt be a problem. For UDP and raw no reliability or 
guarantees are expected by applications (least shouldnt be), and 
queueing some packets on link-down interferes with application-layer 
expectations.

> cheers,
> jamal

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The UPS doesn't have a battery backup.
