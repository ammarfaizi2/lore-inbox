Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTLYD0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 22:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLYD0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 22:26:06 -0500
Received: from [202.37.96.11] ([202.37.96.11]:31915 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S264277AbTLYD0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 22:26:01 -0500
Date: Thu, 25 Dec 2003 16:26:05 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: IP packets routing
To: dheeraj@triveni.no-ip.org, linux-kernel@vger.kernel.org
Message-id: <3FEA58CD.3000600@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a little code that sends an IP packet from the kernel (see at 
the bottom)

The problem is that I have a errors (kernel 2.4.22):

dstip = ac198c13, 0
eth0
h_h_len :: 4
Allocated 48 bytes
Length :: 12
ip_finish_output: bad unowned skb(nf_debug=10) = c0794120: POST_ROUTING
skb: pf=2 (unowned) dev=eth0 len=32
PROTO=1 172.25.206.4:0 172.25.140.19:0 L=32 S=0x00 I=0 F=0x4000 T=128
retval :: 0

Could anybody please give me a hand on how to get around of that problem 
and to send IP packets out for 2.4.22 kernel.

Thank you

_IFCONFIG_OUTPUT_

/home # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0D:CA:01:00:04
          inet addr:172.25.206.4  Bcast:172.25.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1375 errors:0 dropped:0 overruns:0 frame:0
          TX packets:814 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1 txqueuelen:100
          RX bytes:1055067 (1.0 MiB)  TX bytes:118312 (115.5 KiB)
          Base address:0xe00
...


__CODE_THAT_SENDS_THE_PACKET__

  struct curr_lbts {
    int i;
  } curr_lbts;
  ...// __declaration__

  struct rt_key key = {.dst = packet->data.dstip, .src=packet->data.srcip};
  total_len = sizeof(struct iphdr) + sizeof(struct icmphdr) + 
sizeof(curr_lbts);

  retval = ip_route_output_key(&rt, &key);
  printk("dstip = %x, %d\n", packet->data.dstip, retval);
  printk("%s\n", (rt->u.dst.dev)->name);

  hh_len =  ((rt->u.dst.dev->hard_header_len + 15) & ~15);
 
  printk ("h_h_len :: %d \n", sizeof(curr_lbts));
  skb = dev_alloc_skb(total_len + hh_len);
  printk("Allocated %d bytes \n", total_len + hh_len);
  skb->priority = 0;
  skb->dst = dst_clone(&rt->u.dst);
  skb_reserve(skb, hh_len);
       
  skb->nh.iph = iph = (struct iphdr *) skb_put(skb,
                                               (sizeof(struct iphdr) +
                                                sizeof(struct icmphdr)));
  iph->ihl = 5;
  iph->version = 4;
  iph->tos = 0x00;
  iph->tot_len = htons(total_len);
  iph->id = 0;
  iph->frag_off = htons(IP_DF);
  iph->ttl = 128;
  iph->protocol = IPPROTO_ICMP;
  iph->saddr = rt->rt_src;
  iph->daddr = rt->rt_dst;
  iph->check = 0;
  iph->check = ip_fast_csum((unsigned char*) iph, iph->ihl);
 
  skb->h.icmph = icmph = (struct icmphdr *)((char *)iph + iph->ihl * 4);
  icmph->type = ICMP_ECHO;
  icmph->code = code;
  icmph->un.echo.id = 0x42;
  icmph->un.echo.sequence = 0x42;
  icmph->checksum = 0x0000;
  printk("Length :: %d \n", total_len - sizeof(struct iphdr));
 
  data = (unsigned char*) icmph + sizeof(struct icmphdr) ;
  memcpy(skb_put(skb, sizeof(curr_lbts)), &curr_lbts, sizeof(curr_lbts));
  icmph->checksum = ip_compute_csum((unsigned char *)icmph,
                                    total_len - (iph->ihl * 4));
 
  retval = rt->u.dst.output(skb);
  printk("retval :: %d \n", retval);


