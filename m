Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbTCTHpk>; Thu, 20 Mar 2003 02:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbTCTHpj>; Thu, 20 Mar 2003 02:45:39 -0500
Received: from w1312.hostcentric.net ([66.40.206.254]:24079 "HELO
	w1312.hostcentric.net") by vger.kernel.org with SMTP
	id <S261298AbTCTHpf>; Thu, 20 Mar 2003 02:45:35 -0500
Message-Id: <5.2.0.9.0.20030320132850.00b01af8@mail.impulsesoft.com>
Illegal-Object: Syntax error in X-Sender: address found on vger.kernel.org:
	X-Sender:	nalin@impulsesoft.com@mail.impulsesoft.com
					     ^-illegal special character in phrase
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 20 Mar 2003 13:39:39 +0530
To: "v.nagasrinivas" <cheluvi@yahoo.com>
From: Nalin Gupta <nalin@impulsesoft.com>
Subject: Re: Do and Don'ts for socket programming from kernel 
  module/kernel-thread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E797086.A686E25@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Srinivas,

If you refer the oops msg I posted.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0437.html

Probably, I am at mistake, as I am calling "sock_sendmsg" for UDP socket.
from my netdevice::hard_start_xmit (micdev_xmit)  function.

What is my mistake is not clear to me ?

Further, as we know netdevice::hard_start_xmit function is called through
Net Tx Tasklet function net_tx_action through do_softirq.

I am just taking care masking __GFP_WAIT for sock->sk->allocation.
I also tried by merely assigned GFP_ATOMIC.

And also set MSG_DONTWAIT flag for "msg" parameter to sock_sendmsg.

Do I need to disable interrupts too.
I was assuming that "local_irq_save"  in skb_head_from_pool will take care.

I recompiled kernel with quite a few printk, but it seems only my 
invocation to sock_sendmsg cause this panic.


thanks,
regards,
- nalin

At 01:10 PM 3/20/2003 +0530, v.nagasrinivas wrote:
>Hi Nalin,
>
>                    I am just putting my idea , like inline function you
>are mentioning
>from the header file, could you copy and make it as a macro in that
>header file
>and the original inline function  you put like commenting for the time
>being..
>and in the macro just
>
>
>---------------------------------------------------------
>extern __inline__ struct sk_buff *__skb_dequeue(struct sk_buff_head
>*list)
>{
>         struct sk_buff *next, *prev, *result;
>
>         prev = (struct sk_buff *) list;
>         next = prev->next;
>         result = NULL;
>         if (next != prev) {
>                 result = next;
>                 next = next->next;
>                 list->qlen--;
>                 next->prev = prev;
>                 prev->next = next;
>                 result->next = NULL;
>                 result->prev = NULL;
>                 result->list = NULL;
>         }
>         return result;
>}
>
>extern   struct sk_buff *__skb_dequeue(struct sk_buff_head *list)\
>{\
>         struct sk_buff *next, *prev, *result;\
>
>         prev = (struct sk_buff *) list;\
>         printk("%d%s", __LINE__ ,  __FILE__);  <----like this some more
>also.......
>         next = prev->next;\
>         result = NULL;\
>         if (next != prev) {\
>                 result = next;\
>                 next = next->next;\
>                 list->qlen--;\
>                 next->prev = prev;\
>                 prev->next = next;\
>                 result->next = NULL;\
>                 result->prev = NULL;\
>                 result->list = NULL;\
>         }\
>         return result;\
>}\
>
>will give actually at what line and which file is causing causing the
>problem..
>So can debug the problem easily..
>
>
>I am waiting to hear if this works out....to solve the problem.....
>
>
>regards,
>srinivas.
>
>
>
>Path: uni-berlin.de!fu-berlin.de!bofh.it!robomod
>From: <nalin@impulsesoft.com>
>Newsgroups: linux.kernel
>Subject: Do and Don'ts for socket programming from kernel module/kernel-thread
>Date: Thu, 20 Mar 2003 07:10:06 +0100
>Message-ID: <20030320061006$37ac@gated-at.bofh.it>
>X-Mailer: TWIG 2.7.4
>X-Client-IP: 202.9.179.70
>Sender: robomod@news.nic.it
>X-Mailing-List: linux-kernel@vger.kernel.org
>Approved: robomod@news.nic.it
>Organization: linux.* mail to news gateway
>X-Original-Date: Thu, 20 Mar 2003 06:04:02 -0000
>X-Original-Message-ID: <20030320055305Z261391-25575+33069@vger.kernel.org>
>X-Original-Sender: linux-kernel-owner@vger.kernel.org
>X-Original-To: <linux-kernel@vger.kernel.org>
>Xref: uni-berlin.de linux.kernel:120670
>
>Friends,
>
>Where could I find some tips and tricks for correctly doing socket programming
>from a kernel module and a kernel thread.
>
>I am totally stuck and not able to proceed.
>
>I am invariably getting kernel panic from __skb_dequeue inline function called
>from alloc_skb.
>
>In detail I posted following mail, but unfortunately it could not attract
>anyones attention.
>
>Sub : alloc_skb panic oops / virtual network interface
>URL:  http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0437.html
>
>
>Hope to get some response and much need guidance from linux gurus.
>
>thanks in advance,
>
>regards
>- nalin
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

