Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbUKPUwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUKPUwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKPUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:52:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39872 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261790AbUKPUvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:51:54 -0500
Date: Tue, 16 Nov 2004 21:51:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os@analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Work around a lockup?
In-Reply-To: <Pine.LNX.4.61.0411161524450.1562@chaos.analogic.com>
Message-ID: <Pine.LNX.4.53.0411162145240.20538@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
 <Pine.LNX.4.53.0411162111440.32739@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161524450.1562@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If there is a continuous loop inside the kernel, something outside
>the kernel (you) are never going to get control except from an
>interrupt. The keyboard interrupt is going to let you see what
>is happening, but you won't get any real control because the
>kernel is not a task. If the kernel were a task (like VMS),

(Surprise.) Yes, I can still ping it and initiate a connection (i.e. the queue
accepts it, because someone did listen() on the socket), but that's all. I bet
that's due to the network card generating an interrupt.

>you could (maybe) context-switch out of the kernel. But,
>the kernel is some common code that executes on behalf of
>all the tasks in the context of "current". If the current
>task is stuck inside the kernel code, it has nowhere to go.

Wait, an interrupt can ... well interrupt a task, /even/ if it is in kernel
mode, otherwise jiffies would not get incremented. So, would not it be possible
to call some sort of schedule() when do_timer() (or similar) is run?
Like:
  foreach p in runqueue {
    if(p->location==KERNELSPACE && exceeded-kernelspace-timeslic) {
      switch_to(rq->next); // "never returns"
    }
  }

>When some user task executes outside the kernel, it doesn't
>have the priviliges to loop forever. A context switch will
>occur and the CPU will be shared with others. However, when
>that user task calls some kernel function, perhaps from
>a driver interface, that function has the priviliges to
>keep the CPU forever. If the driver is improperly written,
>it will.

So to summarize what I need: disprivilege a process to keep the CPU forever
when it is in kernel mode.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
