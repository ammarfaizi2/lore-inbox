Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWGXDjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWGXDjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWGXDjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 23:39:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48781 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751385AbWGXDjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 23:39:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=mDhz3LjktR67J8nNCl8+sRbczC5OlmBqYQIJYPcvg9yS6TRgjYGTvXnNL3CN05QsPVXWDlS3YqEo6r5iIpjZSjZouGPzZ5x2Pn0I1aLcgY/nZBjrHT1/5c208k2W8HZnuuoFLYZDDaIipBJkN0GyyZWVGr862xbtBaQZsebrTRI=
Message-ID: <7d01f9f00607232039g3d480198w7e206050bca36b0c@mail.gmail.com>
Date: Sun, 23 Jul 2006 23:39:15 -0400
From: "Thibaut VARENE" <T-Bone@parisc-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.17 hangs on ppc/ia64/parisc and won't load init
Cc: "Matthew Wilcox" <matthew@wil.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 36d1ad139ffc8c46
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this very strange bug and i know this is not the kind of bug
report you expect from me. I really have very limited information and
apologize since it doesn't meet the 'standard'.
Below is a brain dump of everything I know so far and will gladly
answer questions.

Quick summary:
The machine dies, and when I reboot it, it is so whacked it won't load
init, whether it's /sbin/init or /bin/sh. Happened on totally
different hw (ppc, ia64, parisc) running totally different workloads.
2.6.16 seems to work fine, and I don't know how to reproduce this bug.
Haven't tried 2.6.18-rc yet.

The long story:
My ppc machine (Pegasos II, 512MB, 1Ghz G4, 40GB PATA, radeon 9200,
reiserfs root disk) hung using 2.6.17-ck1 kernel and debian etch. This
is my main desktop machine and as expected using Xorg 7.1, firefox, a
few remote X apps etc...
After that machine hung I reset it. The boot process was stuck at
Loading INIT. Reset again and tried with init=/bin/sh. It took approx
5 minutes to get the "sh-3.1#" prompt. Then 'ls' would work.But 'ls
-l' would hang, as well as many other simple commands (I don't
remember exactly which i tried but i tried a few). I could kill the
stuck process with SysRQ. Note, all the machines I'm describing here
use LDAP to get regular users credentials, root is local though. To
make sure that the 5 minutes delay wasn't caused by some LDAP lookup
timing out, I tried to boot init=/bin/sh on a similar setup of a
working machine, and the "sh-3.1#" prompt came immediately, so there
is something else going on.

Fortunately, I had a second system partition on the same disk and was
able to boot from it fine (using the kernel that crashed, meaning the
binary apparently wasn't corrupted). Reiserfs utils attempted to
repair the root partition which was (according to those utils) badly
broken. Still, I could chroot into the original root partition, run ls
and
other commandline tools.
Except 'du -sh etc' came up with something like "2.1T". At that point
I knew something was terribly wrong ;P

So I reformatted that partition to ext3 to get rid of one possible
cause of the problem, and built a new 2.6.17-ck1 kernel. That new
setup lasted for less than a day before dying again. At that point I
gave up breaking my main system and considered it safe to get back to
known-working 2.6.16-ish.

At that point I was also thinking I could have bad hw (eg disk).
The following should convince you it's not.

A few days after the PPC machine events, one of my ia64 headless
servers (rx2600, McKinley 900MHz SMP, 4GB RAM, 36GB SCSI), running
debian etch and 2.6.17-pa3 (from the parisc CVS tree, basically
mainline 2.6.17 on ia64), crashed without any output on the console
after a couple weeks uptime. When I rebooted it, guess what, it would
hang calling init. That time, I booted from another partition as well,
and tried to reinstall all 'base' (ie, essential to the system)
packages, including init and friends. It didn't help. The symptoms
were exactly the same; I couldn't recover the system and had to
reinstall it. I don't recall if the root file system was either ext3
or xfs. I'm certain it was not reiserfs.

Finally, most recently (yesterday to be precise), on of my parisc
system (rp3440, pa8800 SMP 800MHz, 4GB RAM, 73GB SCSI) crashed while I
was using it, and again exposed the exact same symptoms. It was
running  debian sid and 2.6.17-rc6-pa3 64bit. It was up for a
few hours. Interestingly, I experienced much longer uptimes with that
very same machine/kernel. The machine was running gdb when it died,
and this time I got a stack dump on the console. I don't totally trust
parisc stack unwinder but here it is anyway:

BUG: soft lockup detected on CPU#1!
Backtrace:
 [<0000000010112aa0>] dump_stack+0x18/0x28
 [<0000000010172558>] softlockup_tick+0x130/0x160
 [<0000000010152630>] run_local_timers+0x28/0x38
 [<0000000010152708>] update_process_times+0xc8/0x128
 [<000000001011d9d8>] smp_do_timer+0x60/0x80
 [<0000000010113a5c>] timer_interrupt+0xec/0x1f0
 [<00000000101726fc>] handle_IRQ_event+0x74/0xf8
 [<0000000010172838>] __do_IRQ+0xb8/0x260
 [<00000000101145f8>] do_cpu_irq_mask+0x130/0x1f8
 [<0000000010104074>] intr_return+0x0/0x1c

BUG: soft lockup detected on CPU#0!
Backtrace:
 [<0000000010112aa0>] dump_stack+0x18/0x28
 [<0000000010172558>] softlockup_tick+0x130/0x160
 [<0000000010152630>] run_local_timers+0x28/0x38
 [<0000000010152708>] update_process_times+0xc8/0x128
 [<000000001011d9d8>] smp_do_timer+0x60/0x80
 [<0000000010113a5c>] timer_interrupt+0xec/0x1f0
 [<00000000101726fc>] handle_IRQ_event+0x74/0xf8
 [<0000000010172838>] __do_IRQ+0xb8/0x260
 [<00000000101145f8>] do_cpu_irq_mask+0x130/0x1f8
 [<0000000010104074>] intr_return+0x0/0x1c
 [<0000000010167708>] hrtimer_run_queues+0x198/0x268
 [<000000001015239c>] run_timer_softirq+0x54/0x2c0
 [<000000001014b8cc>] __do_softirq+0x15c/0x180
 [<000000001010ec14>] do_softirq+0x64/0x70
 [<000000001014ba1c>] irq_exit+0x6c/0x78
 [<0000000010114680>] do_cpu_irq_mask+0x1b8/0x1f8

This bug (so far) never killed our systems as badly as what I'm
describing, so it could be something else. The rp3440 machine was
using an ext3 fs.

I can probably provide configs for the ppc and parisc kernels. But the
ia64 config is gone unfortunately.

So far, here's what I can infer:
- it's not a particular fs' problem (affected reiserfs, ext3fs)
- it's in generic code (affected ppc, ia64 and parisc)
- it's probably in 'core' code actually (totally different
configurations, yet affected all of them)
- it has an impact on fs coherency (that's the only explanation i can
come up with to explain the fact that init=/bin/sh won't work)
- 2.6.16 doesn't seem to be affected (at least not to that extent)

HTH, and again, feel free to ask questions

T-Bone

PS: please CC-me in replies, I'm not subscribed.

-- 
Thibaut VARENE
http://www.parisc-linux.org/~varenet/
