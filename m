Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWH2NGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWH2NGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWH2NGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:06:36 -0400
Received: from rune.pobox.com ([208.210.124.79]:28901 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S964940AbWH2NGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:06:35 -0400
Date: Tue, 29 Aug 2006 08:06:29 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060829130629.GW11309@localdomain>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060829115537.GA24256@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829115537.GA24256@aepfle.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf-

Olaf Hering wrote:
> On Sun, Aug 27, Linus Torvalds wrote:
> 
> > Pls test it out, and please remind all the appropriate people about any 
> > regressions you find (including any found earlier if they haven't been 
> > addressed yet).
> 
> > Nathan Lynch:
> >       [POWERPC] Fix gettimeofday inaccuracies
> 
> Tested on B&W G3, iBook1 and a G4/466.
> This patch causes deadlocks on ppc32, but not on ppc64. Have to verify
> it on a vanilla kernel, but I'm sure there are no funky patches in
> openSuSE.
> 
> https://bugzilla.novell.com/show_bug.cgi?id=202146

Sorry about that, does this (a partial revert of the change) fix it
for you?


diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 18e59e4..fe9b1d9 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -655,7 +655,6 @@ void timer_interrupt(struct pt_regs * re
 	int next_dec;
 	int cpu = smp_processor_id();
 	unsigned long ticks;
-	u64 tb_next_jiffy;
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -697,14 +696,11 @@ void timer_interrupt(struct pt_regs * re
 			continue;
 
 		write_seqlock(&xtime_lock);
-		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
-		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
-			tb_last_jiffy = tb_next_jiffy;
-			tb_last_stamp = per_cpu(last_jiffy, cpu);
-			do_timer(regs);
-			timer_recalc_offset(tb_last_jiffy);
-			timer_check_rtc();
-		}
+		tb_last_jiffy += tb_ticks_per_jiffy;
+		tb_last_stamp = per_cpu(last_jiffy, cpu);
+		do_timer(regs);
+		timer_recalc_offset(tb_last_jiffy);
+		timer_check_rtc();
 		write_sequnlock(&xtime_lock);
 	}
 	
