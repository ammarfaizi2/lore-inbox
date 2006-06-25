Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWFYLkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWFYLkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWFYLkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:40:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932381AbWFYLkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:40:20 -0400
Date: Sun, 25 Jun 2006 04:40:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060625044013.09190fff.akpm@osdl.org>
In-Reply-To: <6bffcb0e0606250419p5e1fca1en5975f3d7a3c12ecd@mail.gmail.com>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<6bffcb0e0606250419p5e1fca1en5975f3d7a3c12ecd@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 13:19:25 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 24/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
> >
> 
> I found this in /var/log/messages.1
> 
> Jun 24 22:29:52 ltg01-fedora kernel: BUG: unable to handle kernel
> paging request at virtual address 6b6b6b7b
> Jun 24 22:29:52 ltg01-fedora kernel:  printing eip:
> Jun 24 22:29:52 ltg01-fedora kernel: c01174f2
> Jun 24 22:29:52 ltg01-fedora kernel: *pde = 00000000
> Jun 24 22:29:52 ltg01-fedora kernel: Oops: 0000 [#1]
> Jun 24 22:29:52 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
> Jun 24 22:29:52 ltg01-fedora kernel: last sysfs file:
> /devices/platform/i2c-9191/9191-0290/temp2_input
> Jun 24 22:29:52 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
> hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
> _ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
> iptable_filter ip_tables x_tables p4_clockmod speedstep_lib binfmt_
> misc thermal processor fan container parport_pc parport nvram
> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq
> _oss snd_seq_midi_event evdev snd_seq snd_seq_device snd_pcm_oss
> snd_mixer_oss snd_pcm snd_timer snd soundcore ide_cd snd_pa
> ge_alloc intel_agp i2c_i801 sk98lin skge agpgart cdrom rtc unix
> Jun 24 22:29:52 ltg01-fedora kernel: CPU:    0
> Jun 24 22:29:52 ltg01-fedora kernel: EIP:    0060:[<c01174f2>]    Not
> tainted VLI
> Jun 24 22:29:52 ltg01-fedora kernel: EFLAGS: 00010096   (2.6.17-mm2 #51)
> Jun 24 22:29:52 ltg01-fedora kernel: EIP is at task_rq_lock+0x1d/0x57

OK, thanks.  I expect the below will fix that (I've since dropped the
offending patches)




Begin forwarded message:

Date: Sun, 25 Jun 2006 01:31:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: more -mm2 troubles ...



* Ingo Molnar <mingo@elte.hu> wrote:

> hm, look at the sched_exit() => task_rq_lock() use-after-free crash 
> below.
> 
> I bet it was p->real_parent that got freed. (because at the point we 
> call sched_exit() we already unlink ourselves from the parent so it is 
> free to exit)
> 
> We moved sched_exit() within exit.c to an unsafe place in mm2 - what 
> patch was that?

patch below seems to fix it for me. mm2 is now stable.

	Ingo

--------------
Subject: move sched_exit() back to under the tasklist_lock umbrella
From: Ingo Molnar <mingo@elte.hu>

seems like sched_exit() cannot be moved to a later stage just yet.
Needs more investigation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/exit.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -827,6 +827,7 @@ static void exit_notify(struct task_stru
 		state = EXIT_DEAD;
 	tsk->exit_state = state;
 
+	sched_exit(tsk);
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_safe(_p, _n, &ptrace_dead) {
@@ -952,8 +953,6 @@ fastcall NORET_TYPE void do_exit(long co
 	if (tsk->splice_pipe)
 		__free_pipe_info(tsk->splice_pipe);
 
-	sched_exit(tsk);
-
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
