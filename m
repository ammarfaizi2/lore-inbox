Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933123AbWFZX0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123AbWFZX0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbWFZXZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:25:27 -0400
Received: from www.osadl.org ([213.239.205.134]:32959 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S933189AbWFZXZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:25:18 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 01:27:09 +0200
Message-Id: <1151364429.25491.462.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 17:41 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 24 Jun 2006 06:19:14 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
> 
> I'm seeing a 2-minute or so hang at system startup, seems to be hrtimer
> related.  

hrtimer is not really involved here.

> This is at fairly early userspace - the initrd has run, but we're not
> into /etc/rc.sysinit yet (although the root filesystem is mounted and we have
> a kjournald for it).  Poking with sysrq-T and sysrq-R gets me this:
> 
> [  108.301806] Pid: 4, comm:              khelper
> [  108.330565] EIP: 0060:[<c0119f48>] CPU: 0
> [  108.359315] EIP is at getnstimeofday+0x9e/0xb8
> [  108.387820]  EFLAGS: 00000207    Not tainted  (2.6.17-mm2 #1)
> [  108.416344] EAX: efed073c EBX: efed073c ECX: 00000000 EDX: 0f16d9ba
> [  108.444765] ESI: a7955c5a EDI: 4a12cf06 EBP: effd0e5c DS: 007b ES: 007b
> [  108.473303] CR0: 8005003b CR2: b7d9acb0 CR3: 2ffbc000 CR4: 000006d0
> [  108.501579]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
> [  108.530366]  <c0111f3c> do_fork+0x8d/0x16a  <c0100a27> kernel_thread+0x6c/0x74
> [  108.559363]  <c0120431> __call_usermodehelper+0x2b/0x44  <c0120982> run_workqueue+0x94/0xe9
> [  108.588523]  <c0120e64> worker_thread+0xe1/0x115  <c01232b2> kthread+0xb0/0xdc
> [  108.617618]  <c01006c5> kernel_thread_helper+0x5/0xb
> [  115.881903] SysRq : Show Regs
> [  115.910288]
> [  115.938097] Pid: 4, comm:              khelper
> [  115.965908] EIP: 0060:[<c0119f48>] CPU: 0
> [  115.993553] EIP is at getnstimeofday+0x9e/0xb8
> [  116.020928]  EFLAGS: 00000287    Not tainted  (2.6.17-mm2 #1)
> [  116.048387] EAX: efed073c EBX: efed073c ECX: 00000000 EDX: 0f16d9ba
> [  116.075750] ESI: 9484965a EDI: 2262af5b EBP: effd0e5c DS: 007b ES: 007b
> [  116.103240] CR0: 8005003b CR2: b7d9acb0 CR3: 2ffbc000 CR4: 000006d0
> [  116.130449]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
> [  116.158078]  <c0111f3c> do_fork+0x8d/0x16a  <c0100a27> kernel_thread+0x6c/0x74
> [  116.185729]  <c0120431> __call_usermodehelper+0x2b/0x44  <c0120982> run_workqueue+0x94/0xe9
> [  116.213729]  <c0120e64> worker_thread+0xe1/0x115  <c01232b2> kthread+0xb0/0xdc
> [  116.241689]  <c01006c5> kernel_thread_helper+0x5/0xb
> 
> Looking at the body of ktime_get_ts, I see:
> 
>         do {
>                 seq = read_seqbegin(&xtime_lock);
>                 getnstimeofday(ts);
>                 tomono = wall_to_monotonic;
> 
>         } while (read_seqretry(&xtime_lock, seq));

>From the stack trace:

copy_process:
 ....
 do_posix_clock_monotonic_gettime(&p->start_time);

#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)

ktime_get_ts() has not been touched since it was merged in 2.6.16

Can you provide the complete boot log up to this point please ? -
Preferably over serial console.

	tglx



