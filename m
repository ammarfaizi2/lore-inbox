Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbUHVSjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbUHVSjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268071AbUHVSjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:39:43 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:8922 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S268067AbUHVSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:39:36 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cursed Checksums
Date: Sun, 22 Aug 2004 21:39:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <1093174820.24319.60.camel@localhost.localdomain>
Thread-Index: AcSIRYUTto1yacZeQUW0oRMfU6WipQAOMDiA
Message-Id: <S268067AbUHVSjg/20040822183936Z+59@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I have patched the kernel with the following code in ip_input.c 

--- /usr/src/linux-2.4.26/net/ipv4/ip_input.c   2002-08-03
04:39:46.000000000 +0400
+++ net/ipv4/ip_input.c 2004-08-22 12:22:41.000000000 +0400
@@ -417,6 +417,10 @@

         if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
                 goto inhdr_error;
+       printk("Ip saddr %08x  --  ",iph->saddr);
+       if (iph->saddr == 0x0101a8c0) // 192.168.1.1
+               iph->saddr = 0x014da8c0; // 192.168.77.1
+       printk("Ip saddr %08x\n",iph->saddr);

         {
                 __u32 len = ntohs(iph->tot_len);

This way whenever an IP packet with the source address of 192.168.1.1
reaches the patched box, the code changes that address of 192.168.77.1

Thus at the time before the box was not patched, this was happening;
ping 192.168.77.1 
ping reply from 192.168.1.1

Now with the patch, this is corrected;
ping 192.167.77.1
ping reply from 192.167.77.1

This is a type of packet mangling, but there is still one problem we could
not resolve. Iptables SNAT does not work in this configuration, the box just
does not redirect the ping replies to the SNATted host. Tcpdump shows that
the ping replies reach the patched box which will do the NAT, but the system
just does not redirect them back to the requesting host.

I thought the patch was in socket-level, and my prediction was correct. Even
the tcpdump (presumably the lowest layer application that receives raw
packs) shows that system is told to receive packets from 192.168.77.1 even
if they are originally from 192.168.1.1

But now, NAT does not work in anyway. Is IPTables working in a lower-level
than tcpdump itself, how can this be? It should have received the packets as
tcpdump receives them (manipulated). Can I debug IPTables by actually
viewing what it receives from the socket? Or perhaps the patch I applied to
ip_input.c just does not affect Iptables at all? (I still cannot believe it)


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Sunday, August 22, 2004 1:40 PM
To: Josan Kadett
Cc: Linux Kernel Mailing List
Subject: Re: Cursed Checksums

It depends on your hardware. With modern network cards we do the
checksum processing in hardware. For older setups passing a packet
through a Linux box won't directly help as the ttl recomputation is done
without recalculation from scratch.

We also have a pile of paths for checksumming including copy/checksum
rolled into one so it isn't easy to remove there.

I'd take up the issue with the vendor of the broken object. If its
something like an internal prototype you need to test then you'll
probably have to write a user space application using raw sockets to
communicate with it and do the fixups/passthrough in use space. Pretty
horrible either way.

Alan


Alan



