Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJKPx3>; Thu, 11 Oct 2001 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276215AbRJKPxU>; Thu, 11 Oct 2001 11:53:20 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:29621 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S272818AbRJKPxM>; Thu, 11 Oct 2001 11:53:12 -0400
Date: Thu, 11 Oct 2001 16:53:38 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Shiva Raman Pandey <shiva@sasken.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: NetFilter: Problem in adding additional header using NetFilter
In-Reply-To: <9q4ddj$bo3$1@ncc-z.sasken.com>
Message-ID: <Pine.SOL.4.33.0110111645410.18253-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Shiva Raman Pandey wrote:

> For example, say ping command, packet length = 84 bytes, IP header length =
> 20 bytes, ICMP header length = 8bytes and my BT header length = 5 bytes
> so I made the new packet of length 20+5+20+(84-20) = 109 bytes and called
> the function set_verdict, with data_len = 109, and this 109 bytes long
> payload.
> Now at the recieving machine I should get the 109 bytes long packet, but in
> fact IP_QUEUE is giving the packet of 84 bytes only, that are in fact first
> 84 bytes of the 109 bytes long packet.
> Note - I have not touched the checksum fields.
>
> So, my questions are :
> 1) When I am sending 109 bytes, why I am getting only 84 bytes?

You are copying the IP header from an 84 byte packet, so the size is set
to 84 => the IP stack only reads the first 84 bytes.

> 2) I tried changing the payload[3] (ie, packet length field) to 109, in that
> case the packet never reaches the destination, why?

You changed the size field, but didn't recalculate the checksum. The
destination would then reject this packet as having a corrupted header.

> 3) Is this problem due to checksum?

Yes, I think so. That, and the rest of the header.

> 4) Is there any way using netfilter, I can get the packet from ethernet
> directly, that will suit my actual design? or any other easy way?

If you want to send packets over Ethernet, you are implementing your own
protocol. Alternatively, you can tunnel your BlueTooth packets over IP, as
you have been doing (but remember to fix the header fields this time!)

Also, you don't need a second copy of the IP header; one will do. At the
transmission end, insert your BT header between the IP header and payload,
changing the fields in the IP header accordingly (including protocol; with
your BT header in place, it is no longer a TCP/UDP/ICMP packet). At the
receiving end, I take it you want to pass the original packet over
Bluetooth? In which case, swap the headers round (and change the fields in
the IP header back the way they were to start with).

You may need more space after the BT header to store the fields you
displace from the IP header.

> 5) How can I verify that the sending machine is actually sending 109 bytes(I
> mean not reducing it to 84)?

A packet sniffer should help here...


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

