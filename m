Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJ3Jha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTJ3Jha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 04:37:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:24033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbTJ3JhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 04:37:25 -0500
Date: Thu, 30 Oct 2003 01:39:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander V. Lukyanov" <lav@netis.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.0-test9: access beyond end of device
Message-Id: <20031030013904.6acaefe3.akpm@osdl.org>
In-Reply-To: <20031030092248.GA7649@swing.yars.free.net>
References: <20031029101240.GA12958@night.netis.priv>
	<20031029124003.4510bb1d.akpm@osdl.org>
	<20031030092248.GA7649@swing.yars.free.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander V. Lukyanov" <lav@netis.ru> wrote:
>
> On Wed, Oct 29, 2003 at 12:40:03PM -0800, Andrew Morton wrote:
> > > 	heavily loaded squid server with two ext3 filesystems for cache on
> > > 	two IC35L040AVVN07-0 40GiB hard disks (ibm), TCQ enabled.
> > 
> > Please force an fsck against those partitions, then see if it is repeatable
> > with TCQ disabled.
> 
> Ok, without TCQ it worked a little longer, but produced another error.
> Now it can be related to network interface configuration: it has two
> 100Mb ethernets, one of which has mtu 576. kernel 2.4.22 used to produce
> warning "sending pkt_too_big to myself" from time to time.
> 

Congratulations, you broke the 2.6 networking code!

Please send a full report, including your .config and a description of how
you have set everything up to netdev@oss.sgi.com.

Is it repeatable?


Oct 30 11:41:52 mars kernel: BUG: dst underflow 0: c01d15f1
Oct 30 11:41:52 mars kernel: recvmsg bug: copied F7C6B8D0 seq F7C6BE78
Oct 30 11:41:52 mars last message repeated 31 times
Oct 30 11:41:52 mars kernel: KERNEL: assertion (!sk->sk_forward_alloc) 
Oct 30 11:41:52 mars kernel: recvmsg bug: copied F7C6B8D0 seq F7C6BE78
Oct 30 11:41:52 mars last message repeated 4 times
Oct 30 11:41:52 mars Oct 30 11:41:52
Oct 30 11:41:52 mars E
Oct 30 11:41:52 mars kernel: KERNEL: assertion (!atomic_read(&sk->sk_rmem_alloc)) failed at net/ipv4/af_inet.c (154)
Oct 30 11:41:52 mars kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (157)
Oct 30 11:42:00 mars kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Oct 30 11:42:21 mars last message repeated 4 times
Oct 30 11:42:23 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:42:23 mars kernel: recvmsg bug: copied 38B12037 seq 38B1205F
Oct 30 11:42:39 mars kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Oct 30 11:42:41 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:42:41 mars kernel: recvmsg bug: copied DEEFC9B5 seq DEEFCA39
Oct 30 11:43:18 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:43:18 mars kernel: recvmsg bug: copied DEEFC9B5 seq DEEFCA39
Oct 30 11:43:18 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:43:18 mars kernel: recvmsg bug: copied DEEFC9B5 seq DEEFCA39

...lots and lots of the same KERNEL and recvmsg messages.

Oct 30 11:47:45 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:47:45 mars kernel: recvmsg bug: copied DEEFC9B5 seq DEEFCA39
Oct 30 11:47:46 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:47:46 mars kernel: recvmsg bug: copied DEEFC9B5 seq DEEFCA39
Oct 30 11:48:06 mars squid[579]: Squid Parent: child process 582 exited due to signal 11
Oct 30 11:48:06 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:48:06 mars kernel: KERNEL: assertion (flags & MSG_PEEK) failed at net/ipv4/tcp.c (1565)
Oct 30 11:48:06 mars kernel: Unable to handle kernel paging request at virtual address 005e1a00
Oct 30 11:48:06 mars kernel:  printing eip:
Oct 30 11:48:06 mars kernel: c01d14a0
Oct 30 11:48:06 mars kernel: *pde = 00000000
Oct 30 11:48:06 mars kernel: Oops: 0000 [#1]
Oct 30 11:48:06 mars kernel: CPU:    0
Oct 30 11:48:06 mars kernel: EIP:    0060:[<c01d14a0>]    Not tainted
Oct 30 11:48:06 mars kernel: EFLAGS: 00010207
Oct 30 11:48:06 mars kernel: EIP is at skb_release_data+0x37/0x9f
Oct 30 11:48:06 mars kernel: eax: c4e82480   ebx: d022f080   ecx: c4e82480   edx: 005e1a00
Oct 30 11:48:06 mars kernel: esi: 00000000   edi: 00000001   ebp: 00000000   esp: e1163eb0
Oct 30 11:48:06 mars kernel: ds: 007b   es: 007b   ss: 0068
Oct 30 11:48:06 mars kernel: Process squid (pid: 582, threadinfo=e1162000 task=e0ef26a0)
Oct 30 11:48:06 mars kernel: Stack: 00000000 d022f080 dc10cb80 c01d151b d022f080 00000000 00000000 c01d15b6 
Oct 30 11:48:06 mars kernel:        d022f080 00000000 00000001 dc10cbc4 c01f45f1 d022f080 00000000 266e2ecf 
Oct 30 11:48:06 mars kernel:        00000000 00000000 e0ef26a0 c01f5434 d9fb0100 00000000 00000000 c39889a4 
Oct 30 11:48:06 mars kernel: Call Trace:
Oct 30 11:48:06 mars kernel:  [<c01d151b>] kfree_skbmem+0x13/0x2c
Oct 30 11:48:06 mars kernel:  [<c01d15b6>] __kfree_skb+0x82/0xfa
Oct 30 11:48:06 mars kernel:  [<c01f45f1>] tcp_close+0x98/0x6eb
Oct 30 11:48:06 mars kernel:  [<c01f5434>] tcp_setsockopt+0xfe/0x68a
Oct 30 11:48:06 mars kernel:  [<c0212232>] inet_release+0x53/0x61
Oct 30 11:48:06 mars kernel:  [<c01cdefd>] sock_release+0x5d/0x66
Oct 30 11:48:06 mars kernel:  [<c01ce74b>] sock_close+0x36/0x4e
Oct 30 11:48:06 mars kernel:  [<c0141d50>] __fput+0xb3/0xc5
Oct 30 11:48:06 mars kernel:  [<c014065c>] filp_close+0x59/0x86
Oct 30 11:48:06 mars kernel:  [<c01406d9>] sys_close+0x50/0x5f
Oct 30 11:48:06 mars kernel:  [<c0108e41>] sysenter_past_esp+0x52/0x71
Oct 30 11:48:06 mars kernel: 
Oct 30 11:48:06 mars kernel: Code: 8b 02 a9 00 08 00 00 75 17 8b 42 04 85 c0 74 48 ff 4a 04 0f 


