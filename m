Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266862AbUGVRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266862AbUGVRxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbUGVRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:53:38 -0400
Received: from ext-proxy-2.ftel.co.uk ([192.65.220.98]:17047 "EHLO
	ext-proxy-2.ftel.co.uk") by vger.kernel.org with ESMTP
	id S266862AbUGVRx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:53:29 -0400
Message-ID: <40FFFF10.2000902@mesias.co.uk>
Date: Thu, 22 Jul 2004 18:53:20 +0100
From: Cam <camilo@mesias.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.4.20_mvl31 OOPS ip_route_input called within ip_rt_init
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an embedded ppc linux which sometimes can oops at boot time if it 
receives a packet during ip_rt_init. There is a printk in there in the 
middle of initialisation of rt_hash_table which can introduce a delay 
which makes the problem more likely to happen,

Output before the oops:
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
<4>Oops: kernel access of bad area, sig: 11

Decoded trace (my arrows):

Trace; c00ffcfc <ip_route_input+40/21c>   <--
Trace; c010339c <ip_rcv_finish+24c/258>
Trace; c00f0af8 <netif_receive_skb+118/224>
Trace; c00f0ca0 <process_backlog+9c/178>
Trace; c00f0e14 <net_rx_action+98/18c>
Trace; c001cfec <do_softirq+134/138>
Trace; c000723c <do_IRQ+c4/c8>
Trace; c00072c0 <preempt_intercept+80/84>
Trace; c0005ecc <ret_from_intercept+0/8c>
Trace; c0068d9c <proc_register+1c/f4>
Trace; c00173a8 <call_console_drivers+c0/160>
Trace; c00177cc <release_console_sem+84/130>
Trace; c0017630 <printk+170/1f0>
Trace; c0198294 <ip_rt_init+128/2c8>       <--
Trace; c0198530 <ip_init+1c/5c>
Trace; c0198d74 <inet_init+f0/220>
Trace; c01896b0 <do_initcalls+30/50>
Trace; c0003b40 <init+28/200>
Trace; c000894c <arch_kernel_thread+30/3c>

Code:

int ip_route_input(struct sk_buff *skb, u32 daddr, u32 saddr,
                    u8 tos, struct net_device *dev)
{
         struct rtable * rth;
         unsigned        hash;
         int iif = dev->ifindex;

         tos &= IPTOS_RT_MASK;
         hash = rt_hash_code(daddr, saddr ^ (iif << 5), tos);

         read_lock(&rt_hash_table[hash].lock);  <-- oops here!!

  [...]

void __init ip_rt_init(void)
{

  [...]

         rt_hash_table = (struct rt_hash_bucket *)
             __get_free_pages(GFP_ATOMIC, order);
     } while (rt_hash_table == NULL && --order > 0);

     if (!rt_hash_table)
         panic("Failed to allocate IP route cache hash table\n");

     printk(KERN_INFO "IP: routing cache hash table of %u buckets, 
%ldKbytes\n",
            rt_hash_mask,
            (long) (rt_hash_mask * sizeof(struct rt_hash_bucket)) / 1024);

     for (rt_hash_log = 0; (1 << rt_hash_log) != rt_hash_mask; 
rt_hash_log++)
         /* NOTHING */;

     rt_hash_mask--;
     for (i = 0; i <= rt_hash_mask; i++) {
         rt_hash_table[i].lock = RW_LOCK_UNLOCKED;
         rt_hash_table[i].chain = NULL;
     }


Is this a known problem?

What can be done to prevent this? Should the device be held inactive 
somehow until ip_rt_init has completed? Should I just move the printk 
to later in the code and hope for the best?

Any info gratefully received,

-Cam
-- 
camilo@mesias.co.uk                                                 <--
