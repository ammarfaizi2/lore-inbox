Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULJVId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULJVId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbULJVId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:08:33 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:23530 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261177AbULJVIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:08:18 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 15:06:43 -0600
Message-ID: <OFDDE2143E.7CA72E68-ON86256F66.0073F88B-86256F66.0073F8B7@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 03:06:45 PM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison of .32-18RT and .32-18PK results
RT has PREEMPT_RT,
PK has PREEMPT_DESKTOP and no threaded IRQ's.
2.4 has lowlat + preempt patches applied

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   RT     PK        RT      PK   |   CPU  Elapsed
X     90.40 100.00&     73 *    64+  |  97.20   70
top   78.56 100.00&     39 *    31+  |  97.48   29
neto  92.82 100.00&    350 *   184+  |  96.23   36
neti  90.69 100.00&    350 *   170+  |  95.86   41
diskw 82.96  99.99     360 *    61+  |  77.64   29
diskc 91.41  99.34     350 *   310+  |  84.12   77
diskr 88.41  99.96     360 *   310+  |  90.66   86
total                 1881    1130   |         368
 [higher is better]  [lower is better]
* wide variation in audio duration
+ long stretch of audio duration "too fast"
& 100% to digits shown, had a FEW samples > 100 usec.

WOW! Look at the 100% values measured on -18PK. The performance
of 2.6 with PREEMPT_DESKTOP is far better than 2.4 preempt+lowlat
in every way except the non RT starvation problem. Something
fixed between -12 and -18 really made a big improvement.

It is still disturbing to see the worse results for -18RT
and I wish I knew what the cause was. Perhaps the traces I sent
earlier can provide a clue.

Other notes:

[1] -PK has many more latency traces > 250 usec [some MUCH longer]
than -RT. I ended up collecting more traces for -RT since I set
the limit to 100 usec, but only got about 8 > 250 usec traces
compared to 40 for -PK.

[2] Some of the traces in -PK are extremely long (up to 2 msec) and
I guess I'm glad I have an SMP system to run the RT application on
the other CPU. Here's an extract of one example:

reemption latency trace v1.1.4 on 2.6.10-rc2-mm3-V0.7.32-18PK
--------------------------------------------------------------------
 latency: 1698 us, #3137/3137, CPU#0 | (M:preempt VP:0, KP:1, SP:0 HP:0
#P:2)
    -----------------
    | task: kjournald-1203 (uid:0 nice:0 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
<unknown-1203  0d..1    0탎 < (54)
<unknown-1203  0...1    0탎 : journal_remove_journal_head
(journal_commit_transaction)
<unknown-1203  0...1    1탎 : __journal_remove_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1    1탎 : __brelse (__journal_remove_journal_head)
<unknown-1203  0...1    1탎 : journal_free_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1    1탎 : kmem_cache_free (journal_free_journal_head)
<unknown-1203  0d..1    2탎 : cache_flusharray (kmem_cache_free)
<unknown-1203  0d..1    2탎 : _raw_spin_lock (cache_flusharray)
<unknown-1203  0d..2    2탎+: free_block (cache_flusharray)
<unknown-1203  0d..2    5탎 : _raw_spin_unlock (cache_flusharray)
<unknown-1203  0d..1    5탎 : memmove (cache_flusharray)
<unknown-1203  0d..1    5탎 : memcpy (memmove)
<unknown-1203  0...1    6탎 : inverted_lock (journal_commit_transaction)
<unknown-1203  0...1    6탎 : __journal_unfile_buffer
(journal_commit_transaction)
<unknown-1203  0...1    7탎 : journal_remove_journal_head
(journal_commit_transaction)
<unknown-1203  0...1    7탎 : __journal_remove_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1    8탎 : __brelse (__journal_remove_journal_head)
<unknown-1203  0...1    8탎 : journal_free_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1    8탎 : kmem_cache_free (journal_free_journal_head)
<unknown-1203  0...1    9탎 : inverted_lock (journal_commit_transaction)
<unknown-1203  0...1    9탎 : __journal_unfile_buffer
(journal_commit_transaction)
...
<unknown-1203  0...1  835탎 : journal_remove_journal_head
(journal_commit_transaction)
<unknown-1203  0...1  835탎 : __journal_remove_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1  836탎 : __brelse (__journal_remove_journal_head)
<unknown-1203  0...1  836탎 : journal_free_journal_head
(journal_remove_journal_head)
<unknown-1203  0...1  837탎 : kmem_cache_free (journal_free_journal_head)
<unknown-1203  0d..1  837탎 : cache_flusharray (kmem_cache_free)
<unknown-1203  0d..1  837탎 : _raw_spin_lock (cache_flusharray)
<unknown-1203  0d..2  838탎 : free_block (cache_flusharray)
<unknown-1203  0d.h2  839탎 : do_nmi (__mcount)
<unknown-1203  0d.h2  840탎 : do_nmi (<08048340>)
<unknown-1203  0d.h2  840탎+: do_nmi (<00200282>)
<unknown-1203  0d..2  843탎 : _raw_spin_unlock (cache_flusharray)
<unknown-1203  0d..1  844탎 : memmove (cache_flusharray)
<unknown-1203  0d..1  844탎 : memcpy (memmove)
<unknown-1203  0...1  844탎 : inverted_lock (journal_commit_transaction)
...
<unknown-1203  0d.h2 1686탎 : __mod_timer (ide_execute_command)
<unknown-1203  0d.h2 1686탎 : _raw_spin_lock_irqsave (__mod_timer)
<unknown-1203  0d.h3 1687탎 : _raw_spin_lock (__mod_timer)
<unknown-1203  0d.h4 1687탎 : internal_add_timer (__mod_timer)
<unknown-1203  0d.h4 1687탎 : _raw_spin_unlock (__mod_timer)
<unknown-1203  0d.h3 1688탎 : _raw_spin_unlock_irqrestore (__mod_timer)
<unknown-1203  0d.h2 1688탎 : ide_outbsync (ide_execute_command)
<unknown-1203  0d.h2 1689탎 : __const_udelay (ide_execute_command)
<unknown-1203  0d.h2 1690탎 : __delay (ide_execute_command)
<unknown-1203  0d.h2 1690탎 : delay_tsc (__delay)
<unknown-1203  0d.h2 1691탎 : _raw_spin_unlock_irqrestore
(ide_dma_exec_cmd)
<unknown-1203  0..h1 1691탎 : ide_dma_start (__ide_do_rw_disk)
<unknown-1203  0..h1 1692탎 : ide_inb (ide_dma_start)
<unknown-1203  0..h1 1692탎 : ide_outb (ide_dma_start)
<unknown-1203  0..h1 1693탎 : _raw_spin_lock_irq (ide_do_request)
<unknown-1203  0..h1 1693탎 : _raw_spin_lock_irqsave (ide_do_request)
<unknown-1203  0d.h2 1694탎 : _raw_spin_unlock_irqrestore (ide_intr)
<unknown-1203  0d.h1 1695탎 : _raw_spin_lock (__do_IRQ)
<unknown-1203  0d.h2 1695탎 : note_interrupt (__do_IRQ)
<unknown-1203  0d.h2 1696탎 : end_edge_ioapic_irq (__do_IRQ)
<unknown-1203  0d.h2 1696탎 : _raw_spin_unlock (__do_IRQ)
<unknown-1203  0d.h1 1696탎 : irq_exit (do_IRQ)

[3] The charts are very smooth on -PK, very similar to those on
2.4 other than the "too fast" symptom for the audio duration.
[the white line is shifted down when compared to the nominal
duration yellow line]

[4] -PK also had two of the non RT starvation periods. Each was
almost 3 minutes long (should be a 5 second sleep). -RT had
none.

Will send the traces separately.
  --Mark

