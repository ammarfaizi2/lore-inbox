Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUHUH2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUHUH2w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHUH2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:28:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16392 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268877AbUHUH2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:28:40 -0400
Date: Sat, 21 Aug 2004 09:10:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Josan Kadett <corporate@superonline.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Message-ID: <20040821071035.GG1456@alpha.home.local>
References: <S268848AbUHUFP2/20040821051528Z+1662@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S268848AbUHUFP2/20040821051528Z+1662@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Have you tried to reach the device on its 192.168.1.1 address by adding a
static route on you host stating that 192.168.1.1 is behind 192.168.77.1 ?

You might also give iproute a try, it can do static NAT, although I'm not
certain that checksums are recomputed entirely. There's a big probability
that it uses differential checksums.

Last solution would be to use iptables (without conntrack) and assign packets
to the QUEUE target, then mangling them with a small user-space program
which would then reinject them into the network stack. It might not be too
hard to do. There's even a 'perlipq' perl extension which might do all the
dirty work for you.

Regards,
Willy

On Sat, Aug 21, 2004 at 08:15:30AM +0200, Josan Kadett wrote:
> I will explain the problem briefly;
> 
> - We have an old network concentrator device in our WAN, this device uses IP
> number 192.168.77.1 as its primary address
> - The device has another IP number (a local address) that is 192.168.1.1
> 
> When we ping the device from the internal network, we have to use the
> device's primary IP number which is 192.168.77.1:
> 
> ping -> 192.168.77.1
> reply from 192.168.1.1
> 
> Normally the reply should come from 192.168.77.1, but the device has some
> kind of programming failure and thus responds us using its internal IP
> number regardless of how we configure it.
> 
> This does not affect the ping from returning back even it is sourced by a
> different address than it is originally destined to, however; if we telnet
> to the device we get the following failure:
> 
> telnet -> TCP SYN sent to 192.168.77.1
> TCP SYN ACK reply from 192.168.1.1
> TCP SYN sent to 192.168.77.1
> TCP SYN sent to 192.168.77.1
> TCP SYN sent to 192.168.77.1
> .... [The connection times since our linux host does not "see" the TCP SYN
> ACK reply for an obvious reason)
> 
> The client from which we send telnet requests to the device gets a packet
> from 192.168.1.1 instead of getting a packet from 192.168.77.1. However; at
> this case, the returning TCP SYN ACK packet has the wrong CRC checksum
> because;
> 
> The network concentrator computes the TCP checksum with the source address
> header of its IP number 192.167.77.1, however; our client that gets the
> packet from the address 192.168.1.1 uses this address instead of the correct
> one in order to compute the checksum and thus they mismatch;
> 
> Eg.
> 0D 74 (Checksum computed by concentrator device)
> 13 D6 (Checksum computed by our client)
> 
> So the incoming packets are dropped due to the fact that they have "wrong"
> checksum... Now either we should find a way to correct the source address
> and the IP checksum in each incoming packet received by our client, or we
> should "program" a utility for it. Here is what we plan to do;
> 
> - Intercept each packet coming from interface eth0
> - Put the IP data in buffer
> - Find and change the bits in which the source IP address is encoded (from
> 192.168.1.1 back to 192.168.77.1)
> - Since the TCP packet has already been checksummed for the correct IP,
> after we change the source, the TCP checksum would be "automatically"
> corrected
> - But since we modified the source IP, now the IP header checksum is broken;
> so recalculate it and put it in correct place
> - "Re-inject" the packet to the interface eth0, but to the "incoming" data
> path that would be received by kernel (just as generating a packet that goes
> to system itself, instead of an external link)
> 
> I found that in /usr/src/linux/net/ipv4/tcp_input.c and udp.c are the two
> sources that control how the communication occurs. I experimented with the
> code and re-compiled the kernel times over times, though either the "CRC"
> checksum checking was still there or the communication was totally cut out.
> 
> I also investigated terms such as CRC checksum offloading and such, and as I
> could see that there was no easy way (a switch or a definition) to disable
> CRC checksumming of received packets, either it be TCP or UDP. I am still
> sure that if the kernel is "told" to allow all packets regardless of their
> CRC field, I would resolve the problem with our network, but the question is
> "how ??"
> 
> Below is a detailed view of the malformed packet;
> 
> Ethernet II Header
>      |
>      - IP Header 
>        (flags) Source IP: 192.168.1.1 (This is where the problem begins, it
> should have been 192.168.77.1)
>                  Dest.    IP: 192.168.1.5 (Our client's IP number)
>           Checksum [0x7d43] --> Correct CRC for IP header
>      |
>      - UDP Header (The same case for TCP)
>        (flags) Source Port: 161
>                  Dest.    Port: 32816
>           Length: 0x0048
>           Checksum [0x341a] --> Wrong CRC that causes all problems.**
> 
> Our system thinks that the checksum would be what it wants to be, so the
> conflict between these two devices makes communication impossible. I know,
> if a patch is applied to the source code of the kernel, both TCP and UDP
> would ingore the CRC and allow communication. Since our network is
> absolutely reliable, there will not be a single side effect of disabling
> TCP/UDP checksums.
> 
> Now if all else fails, at least I have one option though I really do not
> wish to program a packet interceptor for no reason but the dumbness of a
> router and the "abhorrent rigidity" of linux TCP/IP stack. But if I must
> then I will... (We will not replace a multi-K$ UAC device just for this
> reason)
> 
> Perhaps there is a small utility that corrects checksums of the incoming
> data (in real-time) ? Indeed many sniffers have this option to correct the
> CRC (or show the correct value), but none of them are programmed to create a
> stream in which the modifications are done and the packets get re-injected.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
