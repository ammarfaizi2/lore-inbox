Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbULFLaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbULFLaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULFLaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:30:01 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:6302 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261503AbULFL2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:28:05 -0500
Subject: Re: [patch 4/10] s390: network driver.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Paul Jakma <paul@clubi.ie>
Cc: Thomas Spatzier <thomas.spatzier@de.ibm.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0412050605550.21671@hibernia.jakma.org>
References: <OFAF17275D.316533A1-ONC1256F5C.0026AFAD-C1256F5C.002877C1@de.ibm.com>
	 <Pine.LNX.4.61.0412050605550.21671@hibernia.jakma.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102332479.1048.2243.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Dec 2004 06:27:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 01:25, Paul Jakma wrote:
[..]
> Anyway, we do, I think, need some way to deal with the 
> sending-stale-packet-on-link-back problem. Either a way to flush this 
> driver queue or else a guarantee that writes to sockets whose 
> protocol makes no reliability guarantee will either return ENOBUFS or 
> drop the packet.
> 
> Otherwise we will start getting reports of "Quagga on Linux sent an 
> ancient {RIP,IRDP,RA} packet when we fixed a switch problem, and it 
> caused an outage for a section of our network due to bad routes", I 
> think.
> 
> Some comment or advice would be useful. (Am I kill-filed by all of 
> netdev? feels like it).

Dont post networking related patches on other lists. I havent seen said
patch, but it seems someone is complaining about some behavior changing?

In regards to link down and packets being queued.
Agreed this is a little problematic for some apps/transports. TCP is
definetely not one of them. TCP in Linux actually is told if the drop is
local. This way it can make better judgement (and not unnecesarily
adjust windows for example).
SCTP AFAIK is the only transport that provides its apps opportunity to
obsolete messages already sent. I am not sure how well implemented or
whtether it is implemented at all. Someone working on SCTP could
comment.

In the case the netdevice is administratively downed both the qdisc and
DMA ring packets are flushed. Newer packets will never be queued and
you should quickly be able to find from your app that the device is
down.
In the case of netdevice being operationally down - I am hoping this is
what the discussion is, having jumped on it - both queues stay intact.
What you can do is certainly from user space admin down/up the device
when you receive a netlink carrier off notification.
I am struggling to see whether dropping the packet inside the tx path
once it is operationaly down is so blasphemous ... need to get caffeine
first.

cheers,
jamal



