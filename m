Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUHJLKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUHJLKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUHJLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:10:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:16547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264261AbUHJLKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:10:31 -0400
X-Authenticated: #4399952
Date: Tue, 10 Aug 2004 13:20:32 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-Id: <20040810132032.2877f687@mango.fruits.de>
In-Reply-To: <1092103522.761.2.camel@mindpipe>
References: <1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040809130558.GA17725@elte.hu>
	<20040809190201.64dab6ea@mango.fruits.de>
	<1092103522.761.2.camel@mindpipe>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 22:06:20 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> > I don't use APIC, since it never worked good for me.. But i wanted
> > to report that the mlockall latency still seems to be there.. I can
> > easily trigger it with mlockall'ing > ~10000kb. Need to recompile
> > with the preempt-timing patch, but here's an xrun trace that
> > happened when mlockall'ing 20000kb:
> > 
> 
> Same results here, the mlockall problem is not fixed by -O4:
> 
> ALSA
> /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139:
> XRUN: pcmC0D2c
>  [<c0106717>] dump_stack+0x17/0x20
[snip]
> (jackd/778): 10984us non-preemptible critical section violated 1100 us
> preempt threshold starting at kmap_atomic+0x10/0x60 and ending at
> kunmap_atomic+0x8/0x20
[snip]


Hi,

i just applied the new preempt-timing patch and i made the observation
that if jackd is not running then mlocking 500megs of ram doesn't cause
the preempt-timing [thresh = 1000] to report anything.

But when jackd is running i can easily cause an xrun by mlocking even
only 50megs. In this case also a critical section report is printed by
the preempt-timing:

Aug 10 13:13:05 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 10 13:13:05 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 13:13:05 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
Aug 10 13:13:05 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
Aug 10 13:13:05 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 10 13:13:05 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 10 13:13:05 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 13:13:05 mango kernel:  [<c013f073>] get_user_pages+0xd3/0x3d0
Aug 10 13:13:05 mango kernel:  [<c01408fd>] make_pages_present+0x8d/0xb0
Aug 10 13:13:05 mango kernel:  [<c0140da6>] mlock_fixup+0xa6/0xc0
Aug 10 13:13:05 mango kernel:  [<c014109b>] do_mlockall+0x7b/0x90
Aug 10 13:13:05 mango kernel:  [<c014114e>] sys_mlockall+0x9e/0xb0
Aug 10 13:13:05 mango kernel:  [<c0105f2b>] syscall_call+0x7/0xb
Aug 10 13:13:05 mango kernel: (mlockall_test/877): 2706us
non-preemptible critical section violated 1000 us preempt threshold
starting at get_user_pages+0x2f3/0x3d0 and ending at
get_user_pages+0xa5/0x3d0
Aug 10 13:13:05 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 13:13:05 mango kernel:  [<c01146b3>]
touch_preempt_timing+0x33/0x40
Aug 10 13:13:05 mango kernel:  [<c013f045>] get_user_pages+0xa5/0x3d0
Aug 10 13:13:05 mango kernel:  [<c01408fd>] make_pages_present+0x8d/0xb0
Aug 10 13:13:05 mango kernel:  [<c0140da6>] mlock_fixup+0xa6/0xc0
Aug 10 13:13:05 mango kernel:  [<c014109b>] do_mlockall+0x7b/0x90
Aug 10 13:13:05 mango kernel:  [<c014114e>] sys_mlockall+0x9e/0xb0
Aug 10 13:13:05 mango kernel:  [<c0105f2b>] syscall_call+0x7/0xb

So it seems that the combination of the two is somehow triggering this
behaviour:

ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c013f293>] get_user_pages+0x2f3/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
(mlockall_test/862): 2701us non-preemptible critical section violated
1000 us preempt threshold starting at get_user_pages+0x2f3/0x3d0 and
ending at get_user_pages+0xa5/0x3d0
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c01146b3>] touch_preempt_timing+0x33/0x40
 [<c013f045>] get_user_pages+0xa5/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c0114576>] check_preempt_timing+0x16/0x100
 [<c0114735>] sub_preempt_count+0x45/0x60
 [<c013f282>] get_user_pages+0x2e2/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20


I also tried to disable syslogd and looked into dmesg to see the xrun
reports. i don't know if they differ in any essential way:

 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c0114668>] __touch_preempt_timing+0x8/0x20
 [<c01146be>] touch_preempt_timing+0x3e/0x40
 [<c013f045>] get_user_pages+0xa5/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
(mlockall_test/913): 3053us non-preemptible critical section violated
1000 us preempt threshold starting at get_user_pages+0xa5/0x3d0 and
ending at get_user_pages+0x2e2/0x3d0
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0114735>] sub_preempt_count+0x45/0x60
 [<c013f282>] get_user_pages+0x2e2/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c013f293>] get_user_pages+0x2f3/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0c
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c013f045>] get_user_pages+0xa5/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
(mlockall_test/916): 2703us non-preemptible critical section violated
1000 us preempt threshold starting at get_user_pages+0xa5/0x3d0 and
ending at get_user_pages+0x2e2/0x3d0
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0114735>] sub_preempt_count+0x45/0x60
 [<c013f282>] get_user_pages+0x2e2/0x3d0
 [<c01408fd>] make_pages_present+0x8d/0xb0
 [<c0140da6>] mlock_fixup+0xa6/0xc0
 [<c014109b>] do_mlockall+0x7b/0x90
 [<c014114e>] sys_mlockall+0x9e/0xb0
 [<c0105f2b>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01064ae>] dump_stack+0x1e/0x20
 [<f08c2431>] snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
 [<f089ebce>] snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
 [<c011b55b>] generic_handle_IRQ_event+0x3b/0x70
 [<c01078c6>] do_IRQ+0xb6/0x170
 [<c0106098>] common_interrupt+0x18/0x20
 [<c0114576>] check_preempt_timing+0x16/0x100
 [<c0114735>] sub_preempt_count+0x45/0x60
 [<c0291bc5>] schedule+0x305/0x5b0
 [<c029241e>] schedule_timeout+0x5e/0xb0
 [<c0162fd9>] do_poll+0x99/0xc0
 [<c016313f>] sys_poll+0x13f/0x240
 [<c0105f2b>] syscall_call+0x7/0xb
(qjackctl/859): 5549us non-preemptible critical section violated 1000 us
preempt threshold starting at schedule+0x5c/0x5b0 and ending at
schedule+0x305/0x5b0
 [<c01064ae>] dump_stack+0x1e/0x20
 [<c0114735>] sub_preempt_count+0x45/0x60
 [<c0291bc5>] schedule+0x305/0x5b0
 [<c029241e>] schedule_timeout+0x5e/0xb0
 [<c0162fd9>] do_poll+0x99/0xc0
 [<c016313f>] sys_poll+0x13f/0x240
 [<c0105f2b>] syscall_call+0x7/0xb


Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

