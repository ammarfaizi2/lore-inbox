Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWJMVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWJMVQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWJMVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:16:34 -0400
Received: from mout0.freenet.de ([194.97.50.131]:28075 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751885AbWJMVQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:16:33 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: dipankar@in.ibm.com
Subject: Re: 2.6.18-rt1
Date: Fri, 13 Oct 2006 23:18:01 +0200
User-Agent: KMail/1.9.4
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com>
In-Reply-To: <20060930181804.GA28768@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610132318.02512.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 30. September 2006 20:18 schrieb Dipankar Sarma:
> On Sat, Sep 30, 2006 at 02:06:04PM -0400, Lee Revell wrote:
> > On Wed, 2006-09-20 at 16:19 +0200, Ingo Molnar wrote:
> > > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > > from the usual place:
> > > 
> > >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > I got this Oops with -rt3, looks RCU related.  Apologies in advance if
> > it's already known.
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> >  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
> > PGD 46a3067 PUD 4e27067 PMD 0 
> > Oops: 0002 [1] PREEMPT SMP 
> > CPU 1 
> 
> I see a very similar crash while running rcutorture on 2.6.18-mm1 and
> my rcu patchset that has rcupreempt stuff rom -rt. I don't see this
> while running on 2.6.18-rc3, but then rc3 had an older version
> of rcutorture. I am working on narrowing it down.
> 
> The following script reproduces the problem quickly (within
> a couple of minutes) in my 4-cpu x86_64 system -
> 
> #! /bin/sh
> for ((i=0 ; i<200 ; i++))
> do
>         echo "Starting pass $i"
>         modprobe rcutorture stat_interval=10 # test_no_idle_hz=1 shuffle_interval=5
>         sleep 30
>         rmmod rcutorture
>         dmesg | sed -n -e '/^rcutorture: --- End of test:/p' | tail -1
> done
> exit 0
> 

Bug just happened here on a tainted UP x86_64 running rt4.
IIRC this is the second time in 2 weeks or so.
Machine seams to be fine still after the oops...

<Oops>
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<ffffffff802a1b21>] __rcu_read_unlock+0x2e/0x80
PGD 3b616067 PUD 1718b067 PMD 0
Oops: 0002 [1] PREEMPT
CPU 0
Modules linked in: autofs4 sunrpc video button ac lp parport_pc parport nvram snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq nvidia snd_pcm_oss snd_mixer_oss snd_pcm ehci_hcd uhci_hcd snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi pcspkr snd_seq_device snd i2c_viapro i2c_core r8169 soundcore ext3 jbd
Pid: 7102, comm: sh Tainted: P      2.6.18-rt4 #4
RIP: 0010:[<ffffffff802a1b21>]  [<ffffffff802a1b21>] __rcu_read_unlock+0x2e/0x80
RSP: 0018:ffff8100189ebc00  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff81003fd0d450 RCX: 0000000000000246
RDX: 0000000000000000 RSI: ffff81003e351008 RDI: ffff81003fd0d458
RBP: ffff81003fd0d450 R08: ffff81003e351005 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8022a714 R12: ffff81003fd0d458
R13: ffff81003f43b070 R14: ffff8100189ebcb8 R15: 000000000023605a
FS:  00002ac8f7d9dd50(0000) GS:ffffffff8053f000(0000) knlGS:00000000f7fa96c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000003582f000 CR4: 00000000000006e0
Process sh (pid: 7102, threadinfo ffff8100189ea000, task ffff81000c8d2080)
Stack:  ffffffff80208d3b 00000001000200d2 00000003804686b0 ffff81003e351005
 00000000000041ed ffff8100189ebe48 ffff81003f7bd788 ffff81003fde8cc0
 ffff8100189ebe48 ffff8100189ebcb8 ffffffff8020be2c 00000000000041ed
Call Trace:
 [<ffffffff80208d3b>] __d_lookup+0x10a/0x11c
 [<ffffffff8020be2c>] do_lookup+0x2a/0x173
 [<ffffffff802090f9>] __link_path_walk+0x3ac/0xf4a
 [<ffffffff8020d93b>] link_path_walk+0x5a/0xe1
 [<ffffffff8020bc82>] do_path_lookup+0x26d/0x2e9
 [<ffffffff80210f67>] getname+0x15b/0x1c1
 [<ffffffff802216e3>] __user_walk_fd+0x37/0x4c
 [<ffffffff802265ce>] vfs_stat_fd+0x1b/0x4a
 [<ffffffff8022143c>] sys_newstat+0x19/0x31
 [<ffffffff8025a7a1>] error_exit+0x0/0x84
 [<ffffffff80259ece>] system_call+0x7e/0x83


Code: ff 08 65 48 8b 04 25 00 00 00 00 48 c7 80 a8 00 00 00 00 00
RIP  [<ffffffff802a1b21>] __rcu_read_unlock+0x2e/0x80
 RSP <ffff8100189ebc00>
CR2: 0000000000000000
</Oops>

Thanks

      Karsten
