Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUFWNm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUFWNm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFWNm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 09:42:56 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:6793 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S266480AbUFWNmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 09:42:33 -0400
Date: Wed, 23 Jun 2004 15:42:31 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Message-Id: <20040623154231.3c4c6344@phoebee>
In-Reply-To: <200406231536.10112.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040622164000.110f2a63@phoebee>
	<200406231334.57816.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040623140023.4cd7aa3e@phoebee>
	<200406231536.10112.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed-Claws 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 15:36:10 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> bubbled:

> > Yes, but why does the kernel not send out the queue?(I don't know if the
> > queue is empty or full when my sendto stops)
> > Without MSG_DONTWAIT, sendto waits endlessly. But on what?
> 
> strace, gdb and/or (SysRq-T with ksymoops) will tell you.

As I wrote in my first mail:

# strace -p 23620
Process 23620 attached - interrupt to quit
--- SIGSTOP (Stopped (signal)) @ 0 (0) ---
--- SIGSTOP (Stopped (signal)) @ 0 (0) ---
sendto(8, "\0\1\0\31z\30\243\206(\341\216)#\212I#\206H\341\226)%\212"..., 1316,
0, {sa_family=AF_INET, sin_port=htons(22333), sin_addr=inet_addr("224.0.0.1")},
16 <unfinished ...>
Process 23620 detached


and the kernel task output (sysrq + t):

streamserver  S D6564C80     0 23995  23994                     (NOTLB)
d1fcfbc8 00200082 00000000 d6564c80 c1574800 c0320214 00000001 dff9e200
       00b3af60 df8d1c00 c3010010 000002a6 2764d1d8 00000c50 cefb09f8 d1fce000
       7fffffff d1fcfc28 7fffffff c0378e02 dffef680 00000000 00000010 c04e3d50
Call Trace:
 [<c0320214>] ip_local_deliver+0xdf/0x20b
 [<c0378e02>] schedule_timeout+0xb1/0xb3
 [<c031108e>] netif_receive_skb+0x167/0x194
 [<c030c01f>] sock_wait_for_wmem+0xad/0xc5
 [<c0115a27>] autoremove_wake_function+0x0/0x43
 [<c0115a27>] autoremove_wake_function+0x0/0x43
 [<c030c0bb>] sock_alloc_send_pskb+0x84/0x1cb
 [<c030c21b>] sock_alloc_send_skb+0x19/0x21
 [<c0324605>] ip_append_data+0x63d/0x6e5
 [<c01870be>] do_get_write_access+0x246/0x5bc
 [<c0323f23>] ip_generic_getfrag+0x0/0xa5
 [<c033ff01>] udp_sendmsg+0x2d9/0x70a
 [<c0181c8d>] __ext3_journal_stop+0x24/0x4a
 [<c03476d2>] inet_sendmsg+0x4a/0x62
 [<c03097cf>] sock_sendmsg+0x86/0xb2
 [<c012dcb1>] __generic_file_aio_read+0x1cc/0x1fe
 [<c012da1b>] file_read_actor+0x0/0xca
 [<c025683a>] opost_block+0xc8/0x16e
 [<c0227663>] copy_from_user+0x34/0x61
 [<c030aa0b>] sys_sendto+0xc7/0xe2
 [<c0157601>] __pollwait+0x0/0xc0
 [<c0157c89>] sys_select+0x220/0x493
 [<c030b1d0>] sys_socketcall+0x17e/0x249
 [<c0103d63>] syscall_call+0x7/0xb


> 
> > Normally the kernel should put the queued packets on the line and accept
> > new ones, or did I misunderstand this?
> 
> Hm, yes. What does tcpdump tell you?

15:33:14.571437 IP phoebee.32797 > ALL-SYSTEMS.MCAST.NET.22333: UDP, length:
1316
15:33:14.595429 IP phoebee.32797 > ALL-SYSTEMS.MCAST.NET.22333: UDP, length:
1316
15:33:14.596445 IP phoebee.32797 > ALL-SYSTEMS.MCAST.NET.22333: UDP, length:
1316
15:33:14.597445 IP phoebee.32797 > ALL-SYSTEMS.MCAST.NET.22333: UDP, length:
1316

> 
> > My program sends out many udp packets, and sometimes it just stops until
> > the kernel receives a network packet or I access the local network(with arp
> > command).
> 
> arp does not access network. I think it just prints current arp cache.

well, but it resolves the ip's to the hostnames. arp contacts my nameserver, so
it accesses the network :)

socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 5
connect(5, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.0
.2")}, 28) = 0

> 
> > So if I run arp in an endless loop(while :; do arp; done), sendto runs
> > smooth.
> >
> > For me it smells like a bug ;)
> 
> Possible. We need more details. Also CC network folks :)

Hopefully not! But then I need a bugfix for my program...

Where can I find the address?

-- 
MyExcuse:
Boredom in the Kernel.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
