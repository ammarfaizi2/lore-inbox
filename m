Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSFSJ3l>; Wed, 19 Jun 2002 05:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317830AbSFSJ3k>; Wed, 19 Jun 2002 05:29:40 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49065 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317829AbSFSJ3j>; Wed, 19 Jun 2002 05:29:39 -0400
Date: Wed, 19 Jun 2002 05:29:39 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: weiqing@zw.com.cn
cc: linux-kernel@vger.kernel.org
Subject: A question on "Scheduling in interrupt". (fwd)
Message-ID: <Pine.LNX.4.44.0206190523210.31471-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


looks like that besides Ulrich Windl i got the very same email body as
well, as a private email. Lee, how many kernel hackers have you mailed
with the same email body, i hope it's not "everyone in the CREDITS and
MAINTAINERS file" ?  Why didnt you ask this on linux-net@vger.kernel.org
or linux-kernel@vger.kernel.org?

	Ingo

---------- Forwarded message ----------
Date: Sat, 15 Jun 2002 12:55:30 +0800
From: "[gb2312] Œ¿«Â" <weiqing@zw.com.cn>
To: mingo@redhat.com
Subject: A question on "Scheduling in interrupt".

Dear Ingo Molnar,

I am a system engineer in a Chinese software development company, and currently I am implementing IPSec on Linux version 2.2.16. Generally speaking, what I am doing is adding internet key exchange and IPsec processing functions into the Linux ip_queue_xmit, ip_build_xmit and ip_local_deliver procedures. After I have built up a new sk_buff variable, I send it off using my own function send_skbuff(), this is where the problem occurs. Following is the complete copy of the culprit:

void send_skbuff(struct sk_buff *skb)
{
  struct rtable *rt;
  struct iphdr *iph;

  iph = skb->nh.iph;
  if(ip_route_output(&rt, iph->daddr, iph->saddr,
 IPTOS_LOWDELAY, 0))
    goto drop;
  skb->dst = dst_clone(&rt->u.dst);
  skb->priority = TC_PRIO_FILLER;
  if (skb_cloned(skb))
    skb = skb_copy(skb, GFP_ATOMIC);
  else
    skb = skb_clone(skb, GFP_ATOMIC);
  if (skb->len > rt->u.dst.pmtu)
    goto fragment;
  skb->dst->output(skb);
  return;
fragment:
  ip_fragment(skb, skb->dst->output);
  return;
drop:
  kfree_skb(skb); 
}

All functions within the above procedure are kernel supplied and irrelevant to the problem, so I will skip its explanation.
I use the kgdb to debug my codes. Everything worked fine until I had crossed the skb->dst->output(skb) statement and hit upon return. Then, when I typed °∞next°± on host machine, the system crashed with °∞Scheduling in interrupt!°± appearing on target machine and the following message on my host machine:

Program received signal SIGSEGV, Segmentation fault.
Schedule () at sched.c: 875
875 *(int *)0 = 0

Leery of some low level codes within the °∞skb->dst->output(skb)°± provoked the crash, I step into that statement which points to function ip_output. Alas, the system crashed with the same reason upon the first statement of procedure ip_output, and that statement does simple book keeping!
The problem is patent: scheduling while within the interrupt processing context, the myth is how could it ever be scheduling within interrupt since I am not doing anything within the interrupt context!?
By the way, I implemented the send_skbuff months ago, and together with other codes had been working fine. This scheduling in interrupt problem only recently popped up when I was debugging error processing for IPsec and the place it occurred is irrelevant to the error processing.
Any comments will be greatly appreciated.

Regards,

Lee Tong


