Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUFVO6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUFVO6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUFVOoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:44:39 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:41345 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S264422AbUFVOkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:40:03 -0400
Date: Tue, 22 Jun 2004 16:40:00 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Message-Id: <20040622164000.110f2a63@phoebee>
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

Hi there!

I don't know where I should mail this, so maybe it fits to the LKML.

I have a problem with one of my programs which streams data out over udp as a
multicast.

the program creates a thread. in the thread it creates a socket and sets the
multicast stuff:

[code]
    if((sendfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
        perror("socket(sendfd)");
        return -3;
    }

    ret = 1472; // max send buffer for udp (disable fragmentation?)
    if(setsockopt(sendfd, SOL_SOCKET, SO_SNDBUF, (char *)&ret, sizeof (ret))
!= 0) {        perror("setsockopt(SO_SNDBUF)");
    }

    {
       struct ip_mreq imr; //XXX zero out
       imr.imr_multiaddr.s_addr = inet_addr(td->sendip);
       imr.imr_interface.s_addr = 0;
       if (setsockopt(sendfd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &imr, sizeof(struct
ip_mreq)) < 0)
           perror("IP_ADD_MEMBERSHIP");    
    }
[/code]

then it reads data from a file and with sendto sends it out:
[code]
    ret = read(readfd, sendbuf, sizeof(sendbuf));

    ret = sendto(sendfd, sendbuf, ret, 0, (struct sockaddr*)&td->udp,
sizeof(td->udp)); //send the stream out
    if(ret < 0) {
        perror("sendto(sendfd)");
    } else {
        sent_bytes += ret;
    }
[/code]

on the other side is a client(I started it on the same machine) which reads data
from the connected socket and writes the data to a file, which is a pipe.

but sometimes the sendto hangs for a few seconds and longer. the strace output
of the thread:

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



if I run "arp" while it hangs, the sendto continues...
and I also think that it continues if the kernel receives a network packet.

can this be a locking bug?

Regards,
Martin


ps.: I'm sorry if this is the wrong ml!

-- 
MyExcuse:
monitor VLF leakage

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
