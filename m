Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268748AbRG0Ar4>; Thu, 26 Jul 2001 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268749AbRG0Arr>; Thu, 26 Jul 2001 20:47:47 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:23731 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268748AbRG0Arh>; Thu, 26 Jul 2001 20:47:37 -0400
Message-Id: <4.3.1.0.20010726165025.0574cdc0@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Thu, 26 Jul 2001 17:47:50 -0700
To: Andrea Arcangeli <andrea@suse.de>, kuznet@ms2.inr.ac.ru
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.7 softirq incorrectness.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010726202939.D22784@athlon.random>
In-Reply-To: <200107261746.VAA31697@ms2.inr.ac.ru>
 <20010726002357.D32148@athlon.random>
 <200107261746.VAA31697@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


>If there are lots of users of netif_rx outside bh or irq context I guess
>this is the simpler way is:
I'm not sure about a lot but there are certainly some. TUN/TAP driver for example.
It calls netif_rx from user context (syscall). 

> > > after netif_rx.
> > 
> > But why not to do just local_bh_disable(); netif_rx(); local_bh_enable()?
> > Is this not right?
>
>That is certainly right. However it is slower than just doing if (pending) do_softirq()  after netif_rx().
Should we then create generic function (something like netif_rx_from_user) than will call do_softirq 
after calling netif_rx ?

btw I think I just found another problem with softirqs. Actually with tasklets. May be you guys can help me with that.
The problem is that my tasklet is getting run on 2 cpu simultaneously and according to description in linux/interrupt.h 
it shouldn't.
I have a simple tx_task. All it does is sending queued stuff to the device. Whenever I need to send something 
I queue it and do tasklet_schedule(tx_task). Everything works just fine but on SMP machine I noticed that sometimes 
data is sent in the wrong order. And the only reason why reordering could happen is if several tx_tasks are runing at the 
same time. So I added a simple check in tasklet function to complain if it's already running. 
Here is the simplified code example:

tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);

static void hci_tx_task(unsigned long arg)
{
         struct hci_dev *hdev = (struct hci_dev *) arg;
         struct sk_buff *skb;

         static __u32 r = 0;

         if (test_and_set_bit(1, &r)) {
                 ERR("already running cpu %d", smp_processor_id());
                 return;
         }

         /* Send next queued packet */
         while ((skb = skb_dequeue(&hdev->raw_q)))
                 hci_send_frame(skb);

         clear_bit(1, &r);
}

tasklet_schedule(&hdev->tx_task);

Now everything is in order and I'm getting bunch of "already running" messages with different cpu_id.
(hci_tx_task is never called directly).

So, I looked at the tasklet_schedule and tasklet_action code. And it seems to me that tasklet can be scheduled on several 
cpus at the same time. Here is scenario:
         tasklet X is running on cpu 1. tasklet_action clears STATE_SCHED bit and calls tasklet function.
         tasklet_schedule(taskletX) is called on cpu 2. Since STATE_SCHED is cleared tasklet X is scheduled.
         tasklet_action is called on cpu 2 (tasklet X functions is still running on cpu 1)
In that case tasklet_action on cpu 2 should hit a:
         if (!tasklet_trylock(t))
                 BUG();
because tasklet is still locked by cpu 1. For some reason it doesn't though (I don't see any "kernel bug" messages). 
But my tx_task is run second time.

Comments ?

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

