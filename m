Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTKTINk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 03:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKTINj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 03:13:39 -0500
Received: from waste.org ([209.173.204.2]:39595 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264045AbTKTINh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 03:13:37 -0500
Date: Thu, 20 Nov 2003 02:13:24 -0600
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Message-ID: <20031120081324.GH22139@waste.org>
References: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com> <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org> <20031119203210.GC22139@waste.org> <20031119230928.GE22139@waste.org> <20031120074405.GG22139@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120074405.GG22139@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 01:44:05AM -0600, Matt Mackall wrote:
> On Wed, Nov 19, 2003 at 05:09:28PM -0600, Matt Mackall wrote:
> > On Wed, Nov 19, 2003 at 02:32:10PM -0600, Matt Mackall wrote:
> > > 
> > > Zwane's got a K6-2 500MHz. I've just managed to reproduce this on my
> > > 1.4GHz Opteron box (with Debian gcc 3.2). Here, the "ooh la la" bit
> > > doesn't help. So my suspicion is that the printk is changing the
> > > timing just enough on Zwane's box that he's getting a timer interrupt
> > > knocking him out of vm86 mode before he hits a fatal bit in the fault
> > > handling path for 4/4. Printks in handle_vm86_trap, handle_vm86_fault,
> > > do_trap:vm86_trap, and do_general_protection:gp_in_vm86 never fire so
> > > there's probably something amiss in the trampoline code.
> > 
> > Some more datapoints:
> > 
> > CPU          distro          compiler  video        X     result
> > K6-2/500     connectiva 9    2.96      trident      4.3   reboot (zwane)
> > K6-2/500     connectiva 9    3.2.2     trident      4.3   reboot (zwane)
> > Opteron 240  debian unstable 3.2       S3           4.2.1 reboot
> > Athlon 2100  debian unstable 3.2       radeon 7500  4.2.1 works
> > P4M 1800     debian unstable 3.2       radeon m7    4.2.1 reboot
> 
> And indeed it does turn out to be a problem with the trampoline
> mechanics. The fix for -mm4:

Cleanup, as pointed out by Zwane:

Fix triple faulting on some boxes with 4G/4G


 mm-mpm/arch/i386/kernel/vm86.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/i386/kernel/vm86.c~virtual-esp arch/i386/kernel/vm86.c
--- mm/arch/i386/kernel/vm86.c~virtual-esp	2003-11-20 01:36:32.000000000 -0600
+++ mm-mpm/arch/i386/kernel/vm86.c	2003-11-20 02:08:38.000000000 -0600
@@ -303,10 +303,9 @@ static void do_sys_vm86(struct kernel_vm
 
 	tss = init_tss + get_cpu();
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
-	tss->esp0 = virtual_esp0(tsk);
 	if (cpu_has_sep)
 		tsk->thread.sysenter_cs = 0;
-	load_esp0(tss, &tsk->thread);
+	load_virtual_esp0(tss, tsk);
 	put_cpu();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;

_



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
