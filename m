Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTLZC0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 21:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTLZC0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 21:26:52 -0500
Received: from [202.37.96.11] ([202.37.96.11]:30929 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S264452AbTLZC0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 21:26:49 -0500
Date: Fri, 26 Dec 2003 15:26:56 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: 2.4.22: Sending data using raw IP. HELP!!
To: linux-kernel@vger.kernel.org
Message-id: <3FEB9C70.9060504@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to send a data out using raw IP.
For start I tried to send an ICMP response using the code below, but it 
gives me a error (kernel 2.4.22) and clears the skb buffer without 
sending it.
Please help me to send the data out of the kernel 2.4.22 - I have 
dstaddr, srcaddr and payload and I know it should go through eth0. I 
just need somehow push this data out.
The data comes from the user space application, shall I consider other 
options, like to send data from the user space. Can I do this using raw IP?
I am very much appreciate for any ideas on how to send data using raw IP.

Please help!!

__the_error__

dstip = ac198c13, 0
eth0
h_h_len :: 4
Allocated 48 bytes
Length :: 12
ip_finish_output: bad unowned skb(nf_debug=10) = c0794120: POST_ROUTING
skb: pf=2 (unowned) dev=eth0 len=32
PROTO=1 172.25.206.4:0 172.25.140.19:0 L=32 S=0x00 I=0 F=0x4000 T=128
retval :: 0

__the_code__

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



