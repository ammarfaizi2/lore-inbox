Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317801AbSFSHQN>; Wed, 19 Jun 2002 03:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317802AbSFSHQM>; Wed, 19 Jun 2002 03:16:12 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:57868 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S317801AbSFSHQL> convert rfc822-to-8bit; Wed, 19 Jun 2002 03:16:11 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: =?ISO-8859-1?Q? "=CE=C0=C7=E5" ?= <weiqing@zw.com.cn>
Date: Wed, 19 Jun 2002 09:15:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Subject: Re: A question on "Scheduling in interrupt".
CC: linux-kernel@vger.kernel.org
Message-ID: <3D104BA1.28115.49B186@localhost>
In-reply-to: <001901c21429$3b29b940$c9001eac@public>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.12/Sophos-3.56+2.9+2.03.090+01 April 2002+73186@20020619.071452Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2002, at 12:58, ÎÀÇå wrote:

> Dear Ulrich Windl,
> 
> I am a system engineer in a Chinese software development company,
> and currently I am implementing IPSec on Linux version 2.2.16.

Lee Tong,

I'm no specialist on IPsec, but isn't it available already outside the 
great wall? Generally you should consult the file 
/usr/src/linux/MAINTAINERS to specifically address persons about 
specific parts of the code, or send mail to linux-
kernel@vger.kernel.org. Also in /usr/src/linux/Documentation you can 
find a lot of information and pointers to more.

> Generally speaking, what I am doing is adding internet key exchange
> and IPsec processing functions into the Linux ip_queue_xmit,
> ip_build_xmit and ip_local_deliver procedures. After I have built up
> a new sk_buff variable, I send it off using my own function
> send_skbuff(), this is where the problem occurs. Following is the
> complete copy of the culprit: 
> 
> void send_skbuff(struct sk_buff *skb)
> {
>   struct rtable *rt;
>   struct iphdr *iph;
> 
>   iph = skb->nh.iph;
>   if(ip_route_output(&rt, iph->daddr, iph->saddr,
>  IPTOS_LOWDELAY, 0))
>     goto drop;
>   skb->dst = dst_clone(&rt->u.dst);
>   skb->priority = TC_PRIO_FILLER;
>   if (skb_cloned(skb))
>     skb = skb_copy(skb, GFP_ATOMIC);
>   else
>     skb = skb_clone(skb, GFP_ATOMIC);
>   if (skb->len > rt->u.dst.pmtu)
>     goto fragment;
>   skb->dst->output(skb);
>   return;
> fragment:
>   ip_fragment(skb, skb->dst->output);
>   return;
> drop:
>   kfree_skb(skb); 
> }

If not for speed, you can avoid all your gotos.

> 
> All functions within the above procedure are kernel supplied and
> irrelevant to the problem, so I will skip its explanation. I use the
> kgdb to debug my codes. Everything worked fine until I had crossed
> the skb->dst->output(skb) statement and hit upon return. Then, when
> I typed ¡°next¡± on host machine, the system crashed with
> ¡°Scheduling in interrupt!¡± appearing on target machine and the
> following message on my host machine: 
> 
> Program received signal SIGSEGV, Segmentation fault.
> Schedule () at sched.c: 875
> 875 *(int *)0 = 0

I have no idea whether single stepping interrupt routines works well.
Generally it's wise to add syslog output to trace your program flow. It 
works from interrupt if the amount of output is not too much.

> 
> Leery of some low level codes within the ¡°skb->dst->output(skb)¡±
> provoked the crash, I step into that statement which points to
> function ip_output. Alas, the system crashed with the same reason
> upon the first statement of procedure ip_output, and that statement
> does simple book keeping! The problem is patent: scheduling while
> within the interrupt processing context, the myth is how could it
> ever be scheduling within interrupt since I am not doing anything
> within the interrupt context!? By the way, I implemented the

I have no idea.

> send_skbuff months ago, and together with other codes had been
> working fine. This scheduling in interrupt problem only recently
> popped up when I was debugging error processing for IPsec and the
> place it occurred is irrelevant to the error processing. Any comments
> will be greatly appreciated. 
> 
> Regards,
> 
> Lee Tong

Regards,
Ulrich
P.S. I'll CC: the message to linux-kernel, so maybe one of the 
enlighted will share some of their light.

