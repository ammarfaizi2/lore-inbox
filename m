Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbVKXUUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVKXUUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVKXUUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:20:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3047 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751392AbVKXUUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:20:52 -0500
Date: Fri, 25 Nov 2005 01:56:37 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: david singleton <dsingleton@mvista.com>,
       "David F. Carlson" <dave@chronolytics.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051124202637.GB9098@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20051124145734.GA2717@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2005 at 03:57:34PM +0100, Ingo Molnar wrote:
> 
> * david singleton <dsingleton@mvista.com> wrote:
> 
> > Sure.  Attached is the locking fix patch. [...]
> 
> thanks, applied - it should show up in -rt15.
> 

I just noticed with the above fix, Paul's testcase completely
hangs up and when killed I hit the BUG mentioned below.
Till -rt13, this testcase just ran to completion

check_monotonic_clock: monotonic inconsistency detected!
        from       52d314a423 (355728663587) to       50a53da892 (346369665170).
pthread_cond_ma/6345[CPU#2]: BUG in check_monotonic_clock at kernel/time/timeofday.c:156
 [<c011a840>] __WARN_ON+0x60/0x80 (8)
 [<c0139972>] check_monotonic_clock+0xcc/0x109 (48)
 [<c0139dfe>] get_monotonic_clock+0x110/0x146 (68)
 [<c013100c>] ktimer_interrupt+0x54/0x2f6 (92)
 [<c010163c>] __switch_to+0x2a/0x248 (12)
 [<c037d82b>] __schedule+0x41b/0xab7 (40)
 [<c013b86e>] add_preempt_count_ti+0x1e/0xc6 (20)
 [<c013b86e>] add_preempt_count_ti+0x1e/0xc6 (8)
 [<c01393e4>] handle_nextevent_update+0xd/0x23 (20)
 [<c010caaa>] smp_apic_timer_interrupt+0x5c/0x65 (12)
 [<c01037a4>] apic_timer_interrupt+0x1c/0x24 (12)
 [<c037f39f>] __down_mutex+0x69f/0x7fd (44)
 [<c0122856>] lock_timer_base+0x19/0x33 (24)
 [<c0122856>] lock_timer_base+0x19/0x33 (76)
 [<c0122856>] lock_timer_base+0x19/0x33 (20)
 [<c03815fd>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0122856>] lock_timer_base+0x19/0x33 (8)
 [<c0122856>] lock_timer_base+0x19/0x33 (16)
 [<c01228a8>] __mod_timer+0x38/0xdf (16)
 [<c037e86e>] schedule_timeout+0x4f/0xa2 (32)
 [<c0123773>] process_timeout+0x0/0x9 (32)
 [<c013c95d>] futex_wait+0x225/0x2b5 (24)
 [<c012e332>] add_wait_queue+0x12/0x30 (80)
 [<c013b9cb>] sub_preempt_count+0x1a/0x1e (20)
 [<c0381c34>] _raw_spin_unlock+0x12/0x2c (44)
 [<c037db39>] __schedule+0x729/0xab7 (8)
 [<c0114b4d>] default_wake_function+0x0/0x22 (12)
 [<c0114b4d>] default_wake_function+0x0/0x22 (32)
 [<c013d84f>] do_futex+0xf3/0xf8 (40)
 [<c013d949>] sys_futex+0xf5/0x101 (40)
 [<c013d951>] sys_futex+0xfd/0x101 (36)
 [<c0102ce7>] sysenter_past_esp+0x54/0x75 (24)
---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013b930>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (pthread_cond_ma/6345 [f2a52120,   0]):
------------------------------

#001:             [c3888fe0] {&base->t_base.lock}
... acquired at:               lock_timer_base+0x19/0x33


I have attached the testcase below. Run it as

gcc -g  -lpthread  pthread_cond_many.c   -o pthread_cond_many
sh ./pthread_cond_many.sh --realtime


	-Dinakar




--xXmbgvnjoT4axfJE
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="rt-pthread.tar.gz"
Content-Transfer-Encoding: base64

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

--xXmbgvnjoT4axfJE--
