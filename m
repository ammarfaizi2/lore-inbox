Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUJQQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUJQQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUJQQz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:55:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39815 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269183AbUJQQxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:53:45 -0400
Date: Sun, 17 Oct 2004 18:55:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041017165509.GA26791@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041017190330.7a226190@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017190330.7a226190@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> the cpu mhz issue seems to be fixed:
> 
> ~$ uname -a
> Linux mango.fruits.de 2.6.9-rc4-mm1-RT-U4-RT #1 Sun Oct 17 17:48:48 CEST 2004 i686 GNU/Linux
> ~$ cat /proc/cpuinfo |grep MHz
> cpu MHz         : 1195.145
> mango:/usr/src/linux-2.6.9-rc4-mm1-VP-U4# grep REALTIME .config
> CONFIG_PREEMPT_REALTIME=y
> 
> Might of course be coincidence. Will report as soon as i see the 0.001 Mhz
> pop up again.

ok.

> I saw one of these in /var/log/syslog:
> 
> Oct 17 18:53:52 mango kernel: PCI: Found IRQ 3 for device 0000:00:0f.0
> Oct 17 18:53:52 mango kernel: Debug: sleeping function called from invalid context modprobe(109) at kernel/mutex.c:25
> Oct 17 18:53:52 mango kernel: in_atomic():0 [00000000], irqs_disabled():1
> Oct 17 18:53:52 mango kernel:  [print_context_stack+78/112] dump_stack+0x1e/0x20
> Oct 17 18:53:52 mango kernel:  [sinbin_release_fn+536/864] __might_sleep+0xb8/0xd0
> Oct 17 18:53:52 mango kernel:  [__create_workqueue+35/320] _mutex_lock+0x23/0x60
> Oct 17 18:53:52 mango kernel:  [__create_workqueue+145/320] _mutex_lock_irqsave+0x11/0x20
> Oct 17 18:53:52 mango kernel:  [pg0+809943061/1069765632] get_time_pit+0x15/0x50 [gameport]

ok, does the patch below fix those messages? (gameport.c used its own,
private, incompatible prototype for i8253_lock which breaks raw spinlock
handling.)

	Ingo

--- linux/drivers/input/gameport/gameport.c.orig
+++ linux/drivers/input/gameport/gameport.c
@@ -37,12 +37,13 @@ static LIST_HEAD(gameport_dev_list);
 
 #ifdef __i386__
 
+#include <asm/i8253.h>
+
 #define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
 #define GET_TIME(x)     do { x = get_time_pit(); } while (0)
 
 static unsigned int get_time_pit(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 	unsigned int count;
 
