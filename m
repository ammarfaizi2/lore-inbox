Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRCJAsw>; Fri, 9 Mar 2001 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130784AbRCJAso>; Fri, 9 Mar 2001 19:48:44 -0500
Received: from gateway.sequent.com ([192.148.1.10]:40476 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S130781AbRCJAsg>; Fri, 9 Mar 2001 19:48:36 -0500
Date: Fri, 9 Mar 2001 16:47:41 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: sys_sched_yield fast path
Message-ID: <20010309164740.D1057@w-mikek2.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts about adding a 'fast path' to the SMP code in
sys_sched_yield.  Why not compare nr_pending to smp_num_cpus
before examining the aligned_data structures?  Something like,

if (nr_pending > smp_num_cpus)
	goto set_resched_now;

Where set_resched_now is a label placed just before the code
that sets the need_resched field of the current process.
This would eliminate touching all the aligned_data cache lines
in the case where nr_pending can never be decremented to zero.

Also, would it make sense to stop decrementing nr_pending to
prevent it from going negative?  OR  Is the reasoning that in
these cases there is so much 'scheduling' activity that we
should force the reschedule?

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
