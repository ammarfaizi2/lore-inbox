Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUHVIdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUHVIdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266604AbUHVIdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 04:33:52 -0400
Received: from wasp.net.au ([203.190.192.17]:15020 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266611AbUHVI3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 04:29:25 -0400
Message-ID: <41285987.5030702@wasp.net.au>
Date: Sun, 22 Aug 2004 12:29:59 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S266324AbUHVHMa/20040822071230Z+15@vger.kernel.org>
In-Reply-To: <S266324AbUHVHMa/20040822071230Z+15@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> Linux Kernel 2.4.18-14 [Redhat 8 standard installation] 
> 
> As I underlined, I have been able to disable IP header checksumming for the
> received packets, so the system will not drop the packets even after CRC
> becomes invalid when the source address changes.
> 
> I have been asking this question over ten different mailing list and forums
> and no one has come up with a "solid" solution. I would be exteremely glad
> if I get a working source code.
> 
> I know the application will be so very simple, just changing some bits with
> another and putting it back to userspace, but it requires some low-level
> libraries and the knowledge to use them... 

This *MAY* do what you want.. (Compiled and tested on 2.4.26)

--- /usr/src/linux-2.4.26/net/ipv4/ip_input.c   2002-08-03 04:39:46.000000000 +0400
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


When you verify what it's doing, just remove the printk's.

I did it here using one of my local addresses (uml == 192.168.2.84)
And had the above addresses convert 192.168.2.85 to 192.168.77.1

bklaptop:/home/brad# tcpdump -i tap0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on tap0, link-type EN10MB (Ethernet), capture size 96 bytes
12:24:16.723748 IP 192.168.2.85 > uml: icmp 64: echo request seq 0
12:24:16.725119 arp who-has gateway tell uml
12:24:17.289458 arp reply gateway is-at 00:ff:14:7a:fe:66
12:24:17.290282 IP uml > 192.168.77.1: icmp 64: echo reply seq 0
12:24:17.720057 IP 192.168.2.85 > uml: icmp 64: echo request seq 256
12:24:17.723690 IP uml > 192.168.77.1: icmp 64: echo reply seq 256
12:24:18.720632 IP 192.168.2.85 > uml: icmp 64: echo request seq 512
12:24:18.724369 IP uml > 192.168.77.1: icmp 64: echo reply seq 512

Good luck.

Regards,
Brad
