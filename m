Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULDTyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULDTyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 14:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbULDTyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 14:54:36 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:21129 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261151AbULDTya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 14:54:30 -0500
Date: Sat, 4 Dec 2004 14:51:31 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Performance analysis of i386 SMP timer interrupt
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200412041453_MC3-1-900E-1EAD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance analysis of arch/i386/kernel/apic.c::smp_local_timer_interrupt:

{
        int cpu = smp_processor_id();

        profile_tick(CPU_PROFILING, regs);
1 ->    if (--per_cpu(prof_counter, cpu) <= 0) {

                per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
2 ->            if (per_cpu(prof_counter, cpu) !=
                                        per_cpu(prof_old_multiplier, cpu)) {
3 ->                    __setup_APIC_LVTT(
                                        calibration_result/
                                        per_cpu(prof_counter, cpu));
4 ->                    per_cpu(prof_old_multiplier, cpu) =
                                                per_cpu(prof_counter, cpu);
                }

5 ->            update_process_times(user_mode(regs));
        }
}


(1)     Needs likely().

(2)     Needs unlikely().

(3,4)   (4) should be done before (3) to minimize register usage.
        (function becomes 6 insns smaller and uses 8 bytes less stack space)

(5)     The user_mode() macro is inefficient:
        #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))

        (VM86 mode is very rare compared to normal cpu mode, so both
        parts of the 'or' are evaluated almost every time on most systems.)


--Chuck Ebbert  04-Dec-04  14:50:39
