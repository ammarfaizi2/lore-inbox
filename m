Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUFWFQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUFWFQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 01:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUFWFQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 01:16:13 -0400
Received: from outbound04.telus.net ([199.185.220.223]:41103 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S265117AbUFWFQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 01:16:08 -0400
Subject: Re: [PATCH] preempt count regression w/ lockless loopback patch
From: Bob Gill <gillb4@telusplanet.net>
To: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040622140140.66b26cd1.davem@redhat.com>
References: <200406210510.i5L5A340018849@hera.kernel.org>
	 <20040621035702.6114bdbe.akpm@osdl.org>
	 <Pine.SGI.4.56.0406220913010.1334066@neteng.engr.sgi.com>
	 <20040622123931.50d5ac05.davem@redhat.com>
	 <Pine.SGI.4.56.0406221344380.1357620@neteng.engr.sgi.com>
	 <20040622140140.66b26cd1.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1087968100.4083.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Jun 2004 23:21:40 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 15:01, David S. Miller wrote:

> Thanks a lot Arthur, patch applied.


Hi.  Sorry for the late reply.  I applied the patch (so now my
drivers/net/loopback.c around line 173 looks like:

for (i=0; i < NR_CPUS; i++) {
                if (!cpu_possible(i))
                        continue;
                lb_stats = &per_cpu(loopback_stats, i);
                stats->rx_bytes   += per_cpu_ptr(loopback_stats,
i)->rx_bytes;
                stats->tx_bytes   += per_cpu_ptr(loopback_stats,
i)->tx_bytes;
                stats->rx_packets += per_cpu_ptr(loopback_stats,
i)->rx_packets;                stats->tx_packets +=
per_cpu_ptr(loopback_stats, i)->tx_packets;        }
                                 
        return stats;

(and if that is the patch, then I get --with extra debugging in the
kernel):

CPU:    0
EIP:    0060:[<co11f349>]    Not tainted
EFLAGS: 00010246   (2.6.7-bk5)
EIP is at __mod_timer+0x170/0x17d
eax: 00000000   ebx: 00000000   ecx: f7ba8a20   edx: f7ba8aa4
esi: f7ba8aa4   edi: 0000e000   ebp: f7af7e80   esp: f7af7e38
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1535, threadinfo=f7af6000 task
Stack: 00000000 00001200 00000000 00000000 f7ba8800 0000e000 f7af7e80
f8aa6cb9
       f7ba8aa4 fffc163b 00000001 f7ba8800 f7ba8800 f7ba8a20 90326f48
f770f658
       c0328460 f7ba8800 00000000 c0256344 f7ba8800 f770f658 0000004c
f7fd2238
Call Trace:
 [<f8aa6cb9>] sis900_open+0x15f/0x166 [sis900]
 [<c0256344>] neigh_parms_alloc+0xa9/0xb9
 [<c0288a17>] inetdev_init+0x89/0x16e
 [<c028907e>] inet_set_ifa+0x9f/0x105
 [<c02888b6>] inet_alloc_ifa+0x22/0x48
 [<c028982b>] devinet_ioctl+0x2f3/0x560
 [<c028bbbd>] inet_ioctl+0x5e/0x9e
 [<c0248dc5>] sock_ioctl+0xed/0x28b
 [<c0248cd8>] sock_ioctl+0x0/0x28b
 [<c015c9e7>] sys_ioctl+0xf7/0x24c
 [<c0103eb1>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 9b 00 4b 42 2b c0 e9 a1 fe ff ff 83 ec 14 89 7c 24 10


I will try (any patches), but unfortunately, my turnaround time will
(likely) be delayed about 20 hours from this post (working long hours
lately).

Thanks for all replies.
Bob

