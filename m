Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbUKQNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUKQNFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKQNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:05:29 -0500
Received: from pop.gmx.de ([213.165.64.20]:8085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262302AbUKQNFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:05:17 -0500
X-Authenticated: #4399952
Date: Wed, 17 Nov 2004 14:00:36 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: john cooper <john.cooper@timesys.com>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041117140036.7c59a47e@mango.fruits.de>
In-Reply-To: <20041117134509.GA29845@elte.hu>
References: <20041116223243.43feddf4@mango.fruits.de>
	<20041116224257.GB27550@elte.hu>
	<20041116230443.452497b9@mango.fruits.de>
	<20041116231145.GC31529@elte.hu>
	<20041116235535.6867290d@mango.fruits.de>
	<20041117002926.32a4b26f@mango.fruits.de>
	<419A961A.2070005@timesys.com>
	<20041117122318.479805fa@mango.fruits.de>
	<20041117130236.GA28240@elte.hu>
	<20041117131400.0c1dbe95@mango.fruits.de>
	<20041117134509.GA29845@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 14:45:09 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > > I had rtc_wakeup running with a rtc frequency of 8192 hz at the time
> > > > plus some general usage (reading mails, etc..) In earlier kernels it
> > > > seemed that the lock fell together with the rtc IRQ being piggy. will
> > > > try to reproduce now with the freshest RP kernel.
> > 
> > I am not all certain that there really is a correlation like this. It
> > might have been coincidence. This boot locked again when i was in X
> > for 1 minute for checking mails. So again no console output.
> 
> managed to reproduce the lockup on my testbox, using your .config,
> running rtc_wakeup -f 8192 and starting X. Hard hang and i had IRQ1 at
> prio 99. Will turn on the NMI watchdog now, hopefully this lockup will
> stay easy to reproduce.

Hi,

i experienced another one. But as i stayed on the console sysrq was
available, so i can send you the last locks listed by sysrq-t.

The scenario was this:

rtc_wakeup -f 8192 in one console
some find /'s in another

Now i changed to a third console and put some load on the system my doing
make clean bzImage in some kernel source dir.

right after hitting enter after typing "make clean bziage" i got another
piggy message and the machine locked. It seems (to my uneducated mind) cc1
and rtc_wakeup both are involved with this as the list of held locks (or the
part of the list which i can see) shows them.

there were 5 locks of the following form

&drive-gendev_rel_sem
init
init_hwif_data

2 locks of this form:

&tty->atomic_read
getty
reasd_char

and these:

&mm->page_table_lock
cc1
exit_mmap

&mm->mmap_sem
rtc_wakeup
do_page_fault

&mm->page_table_lock
rtc_wakeup
handle_mm_fault

&serio_lock
IRQ 1
serio_interrupt

sysrq_table_lock
IRQ 1
__handle_sysrq

flo
