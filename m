Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUGPJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUGPJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUGPJbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:31:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266509AbUGPJ37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:29:59 -0400
Date: Fri, 16 Jul 2004 05:29:23 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Eirik Nordbroden <eirik.nordbroden@morecom.no>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: Question on Linux and SCHED_FIFO scheduling for POSIX threads
Message-ID: <20040716092923.GO21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <40FB8221D224C44393B0549DDB7A5CE8378C37@tor.lokal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FB8221D224C44393B0549DDB7A5CE8378C37@tor.lokal.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 11:11:54AM +0200, Eirik Nordbr?den wrote:
> Can anybody clarify how SCHED_FIFO scheduling and thread priorities works
> on Linux? We are novices in this field in the Linux environment and needs
> help to understand how it works. To verify the behaviour we made up a
> small test program consisting of four threads and a mutex. We have run the
> program on both the 2.6.5 and 2.6.7 kernels with same behaviour.
> 
> Program:
> 
> T-MAIN: scheduling policy=SCHED_FIFO, priority=1
> T-LP:   scheduling policy=SCHED_FIFO, priority=10
> T-MP:   scheduling policy=SCHED_FIFO, priority=20
> T-HP:   scheduling policy=SCHED_FIFO, priority=30
> 
> The program runs like this:
> 
> T-MAIN locks mutex => T-MAIN runs.
> T-MAIN creates T-LP => T-LP runs.
> T-LP waits for mutex => T-MAIN runs.
> T-MAIN creates T-MP => T-MP runs.
> T-MP waits for mutex => T-MAIN runs.
> T-MAIN creates T-HP => T-HP runs.
> T-HP waits for mutex => T-MAIN runs.
> T-MAIN waits 3 seconds and unlocks mutex => T-LP runs.
> T-LP waits 3 seconds and unlocks mutex => T-MP runs.
> T-MP waits 3 seconds and unlocks mutex => T-HP runs.
> :
> :
> 
> For us this is unexpected behaviour. We would expect that the thread with
> the highest priority would be scheduled to run when a number of threads is
> waiting for a mutex and the mutex is unlocked. Can anyone clarify this?
> Have we missed something?

NPTL locking is implemented on top of futex(2).
futex(2) queues are ATM FIFOs, not priority based queues.
Check http://developer.osdl.org/dev/robustmutexes/
for some patches which introduce priority based queues for futexes (well,
AFAIK they introduce new syscalls and call the primitive fusyn instead).

	Jakub
