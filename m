Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVCKFD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVCKFD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCKFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:03:56 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:62157 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262512AbVCKFBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:01:42 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.9771.415044.444272@wombat.chubb.wattle.id.au>
Date: Fri, 11 Mar 2005 16:01:31 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Microstate Accounting for 2.6.11
In-Reply-To: <20050310200808.306caf98.akpm@osdl.org>
References: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
	<20050310200808.306caf98.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>>  Timing data on threads at present is pretty crude: when the timer
>> interrupt occurs, a tick is added to either system time or user
>> time for the currently running thread.  Thus in an unpacthed kernel
>> one can distinguish three timed states: On-cpu in userspace, on-cpu
>> in system space, and not running.
>> 
>> The actual number of states is much larger.  A thread can be on a
>> runqueue or the expired queue (i.e., ready to run but not running),
>> sleeping on a semaphore or on a futex, having its time stolen to
>> service an interrupt, etc., etc.
>> 
>> This patch adds timers per-state to each struct task_struct, so
>> that time in all these states can be tracked.  This patch contains
>> the core code do the timing, and to initialise the timers.
>> Subsequent patches enable the code (by adding Kconfig options) and
>> add hooks to track state changes.

Andrew> Why does the kernel need this feature?

I find that it's useful when trying to work out why a thread is going
more slowly than it needs to.  Userspace tools in the CVS repository
at gelato.unsw.edu.au let you graph in real time the time spent in
each state, so you get graphs like this:

     http://gelato.unsw.edu.au/patches/snapshot.png

which shows mplay skipping because of a slow disk/filesystem.

Andrew> Have you any numbers on the overhead?

Around 5% on LMbench context switch numbers for uniprocessor,
negligeable on SMP (but SMP context switch results are horrible at the
moment according to LMbench2 -- almost 16usec); select on 10 fd goes
from 1.665 usec to 1.701; 

Andrew> The preempt_disable() in sys_msa() seems odd.

Yes I only added that yesterday.  It's to prevent migration while
updating the current timer.  All the other places where the current
timer are updated are naturally protected this.  It should probably be a
local_irq_disable() instead.

Peter C

