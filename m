Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSHAXdy>; Thu, 1 Aug 2002 19:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSHAXdy>; Thu, 1 Aug 2002 19:33:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6994 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317338AbSHAXdx>; Thu, 1 Aug 2002 19:33:53 -0400
Date: Thu, 1 Aug 2002 19:37:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200208012337.g71NbKs01634@devserv.devel.redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <mailman.1028232841.11555.linux-kernel2news@redhat.com>
References: <Pine.LNX.4.33.0208011203010.3000-100000@penguin.transmeta.com> <mailman.1028232841.11555.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  They should be waiting in TASK_UNINTERRUPTIBLE, and we should add a
>> flag  to distinguish between "increases load average" and "doesn't".
> 
> The disadvantage of this approach is that it encourages people to be lazy
> and sleep with signals disabled, instead of implementing proper cleanup
> code. 
> 
> I'm more in favour of removing TASK_UNINTERRUPTIBLE entirely, or at least 
> making people apply for a special licence to be permitted to use it :)
> 
> --
> dwmw2

Consider this. An application writes to /dev/dsp0, and ymfpci
(for example) start DMA. Then user interrupts the app with ^C.
When ymfpci gets ->release() call, it has to tell the chip
to stop DMA, then wait until it's complete. If it tries to
wait with TASK_INTERRUPTIBLE, schedule() will return immediately,
and in essense do a busy loop with CPU pegged at 100%.

Same thing happens in USB, only there it's worse: a spinning
application locks out khubd and whole subsistem dies.

-- Pete
