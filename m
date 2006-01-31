Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWAaKIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAaKIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWAaKIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:08:00 -0500
Received: from tornado.reub.net ([202.89.145.182]:47034 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750722AbWAaKH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:07:59 -0500
Message-ID: <43DF36FD.70305@reub.net>
Date: Tue, 31 Jan 2006 23:07:57 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060129)
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: ip_conntrack related slab error (Re: Fw: Re: 2.6.16-rc1-mm3)
References: <20060130221429.5f12d947.akpm@osdl.org> <20060131092447.GL4603@sunbeam.de.gnumonks.org>
In-Reply-To: <20060131092447.GL4603@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2006 10:24 p.m., Harald Welte wrote:
>> Begin forwarded message:
>>
>> Date: Sat, 28 Jan 2006 00:47:06 +1300
>> From: Reuben Farrelly <reuben-lkml@reub.net>
>> To: Andrew Morton <akpm@osdl.org>
>> Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
>> Subject: Re: 2.6.16-rc1-mm3
>>
>> Just triggered this one, which had a fairly bad effect on connectivity to the box:
>>
>> i2c /dev entries driver
>> slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free all objects
>>   [<b010412b>] show_trace+0xd/0xf
>>   [<b01041cc>] dump_stack+0x17/0x19
>>   [<b0155d04>] kmem_cache_destroy+0x9b/0x1a9
>>   [<f0ebf701>] ip_conntrack_cleanup+0x5d/0x10e [ip_conntrack]
>>   [<f0ebe31e>] init_or_cleanup+0x1f8/0x283 [ip_conntrack]
>>   [<f0ec2c4e>] fini+0xa/0x66 [ip_conntrack]
>>   [<b0136d06>] sys_delete_module+0x161/0x1fb
>>   [<b0102b3f>] sysenter_past_esp+0x54/0x75
>> Removing netfilter NETLINK layer.
>> [root@tornado log]#
>>
>> I was just reading IMAP mail at the time, ie same as I'd been doing for an hour 
>> or two beforehand and not altering config of the box in any way.  I was able to 
>> log on via console but lost all network connectivity and had to reboot :(
> 
> The codepath you see in that backtrace is only hit during load or
> removal of the 'ip_conntrack' module.  While this certainly still should
> not oops, your description of 'not doing anything but IMAP reading' is
> certainly not true.  
> 
> Could you please describe what actually happened when that bug happened?
> It looks to me that you were unloading ip_conntrack_netlink.ko followed
> by ip_conntrack.ko.

This just happened, in fact while I was typing up my previous mail.  I only 
noticed because I went to send and connection to the server timed out:

I'm not sure if this is related or not.


Fedora Core release 4 (Rawhide)
Kernel 2.6.16-rc1-mm4 on an i686

tornado.reub.net login: BUG: unable to handle kernel paging request at virtual 
address 00200200
  printing eip:
f0eb410d
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /block/fd0/dev
Modules linked in: nfsd exportfs lockd sunrpc lm85 hwmon_vid eeprom ipv6 ip_gre 
iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle 
ip_tables binfmt_misc ide_cd cdrom serio_raw hw_random piix i2c_i801
CPU:    0
EIP:    0060:[<f0eb410d>]    Not tainted VLI
EFLAGS: 00010292   (2.6.16-rc1-mm4 #2)
EIP is at ip_nat_cleanup_conntrack+0x22/0x62 [ip_nat]
eax: dbcb0570   ebx: d6f9164c   ecx: d6f916c8   edx: 00200200
esi: d6f9164c   edi: eef02380   ebp: b044ce74   esp: b044ce70
ds: 007b   es: 007b   ss: 0068
Process smbd (pid: 2517, threadinfo=b044c000 task=dbcb0570)
Stack: <0>d6f9164c b044ce88 f0ec0251 00004599 d6f9164c d52aca80 b044cee4 b02e9914
        b044ceb4 b02c6b49 00000000 00000277 00000277 00000002 0100007f 0100007f
        b0487508 b044cee4 b02c6d6d 02772e80 027747ab ef856ff4 b02cd972 80000000
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db7>] show_registers+0x19d/0x22b
  [<b0103f61>] die+0x11c/0x22c
  [<b01140e4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<f0ec0251>] destroy_conntrack+0x4c/0x13e [ip_conntrack]
  [<b02e9914>] tcp_v4_rcv+0xad9/0xb25
  [<b02ce33e>] ip_local_deliver+0x92/0x2d4
  [<b02cdfd2>] ip_rcv+0x331/0x60b
  [<b02b3638>] netif_receive_skb+0x219/0x302
  [<b02b506b>] process_backlog+0x8e/0x12e
  [<b02b51c6>] net_rx_action+0xbb/0x1c4
  [<b01213cd>] __do_softirq+0x70/0xd7
  [<b0105071>] do_softirq+0x4f/0x53
  =======================
  [<b0121480>] local_bh_enable+0x4c/0x79
  [<b02b536d>] dev_queue_xmit+0x9e/0x305
  [<b02d3d72>] ip_output+0x17d/0x32b
  [<b02d31d2>] ip_queue_xmit+0x240/0x53e
  [<b02e2562>] tcp_transmit_skb+0x3bd/0x6c9
  [<b02e29b1>] tcp_send_ack+0xa2/0xdf
  [<b02d826c>] cleanup_rbuf+0x40/0xf0
  [<b02d9f59>] tcp_recvmsg+0x1b0/0x7b2
  [<b02ab6ab>] sock_common_recvmsg+0x3d/0x53
  [<b02a9b1e>] sock_recvmsg+0xda/0xfe
  [<b02aae39>] sys_recvfrom+0x79/0xbe
  [<b02aaeb4>] sys_recv+0x36/0x38
  [<b02ab209>] sys_socketcall+0x158/0x254
  [<b0102b3f>] sysenter_past_esp+0x54/0x75
Code: 5d c3 b9 60 73 eb f0 eb f5 55 89 e5 53 89 c3 f7 40 08 80 01 00 00 75 03 5b 
5d c3 b8 40 73 eb f0 e8 f4 cc 45 bf 8d 4b 7c 8b 51 04 <3b> 0a 75 28 8b 43 7c 3b 
48 04 75 2a 89 50 04 89 02 c7 43 7c 00
  <0>Kernel panic - not syncing: Fatal exception in interrupt
  <0>Rebooting in 60 seconds..

reuben
