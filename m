Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280777AbRKKCc5>; Sat, 10 Nov 2001 21:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKKCcs>; Sat, 10 Nov 2001 21:32:48 -0500
Received: from mmohlmann.demon.nl ([212.238.27.16]:17668 "HELO
	brand.mmohlmann.demon.nl") by vger.kernel.org with SMTP
	id <S280777AbRKKCcj>; Sat, 10 Nov 2001 21:32:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] fix loop with disabled tasklets
Date: Sun, 11 Nov 2001 03:32:43 +0100
X-Mailer: KMail [version 1.3.1]
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl> <20011110.053720.55510115.davem@redhat.com> <20011110160301.B1381@athlon.random>
In-Reply-To: <20011110160301.B1381@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011111023228.85BBA231A4@brand.mmohlmann.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 November 2001 16:03, Andrea Arcangeli wrote:
> So it seems to fix the looping problem of disabled tasklets we should
> really dschedule the tasklet in tasklet_disable (and of course to forbid
> it to be scheduled when disabled in tasklet_schedule) and later to
> reschedule it in tasklet_enable.

i'm beginning to see my troubles here. (only just now). I have been reading 
"writing linux device drivers" and they state some additional properties for 
tasklets. These are (page 199-200):
1)	a tasklet is guaranteed to run on the cpu that first schedules it. For
	better cache behavoir.
2)	when a tasklet is disabled, you may still schedule it. It will run asap
	after tasklet_enable.
If we also want to enforce these rules we should a) put them in interrupts.h
b) i think we don't escape from using a cpu field and locking it.

Now, i don't know where oreilly got these addition properties from. In fact, 
i've been working on the kernel for less then a week and the first two days 
were just to setup my cross compiler. I only noticed that my sparcstation LX 
didn't boot and that started this of. (oh and i want to see my name in the 
changelog someday, just for fun  ;).

anyway, don't know were these come from, but i would like to know if we should
enforce them. I'm working on a better patch, which has the above features, 
but if we don't support them, no need to wast cycles over them.
 
This patch i'm working on now removes the tasklet from tasklet_vec[cpu].list 
when it is disabled but not after saving smp_processor_id in t->cpu. When the
tasklet is enabled and the tasklet is marked scheduled, the tasklet is added
to the right cpu.
t->cpu is set on first schedule and not reset with additional schedules.

Oh, and i will try to look for races this time  ;)

	me
