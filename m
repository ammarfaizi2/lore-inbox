Return-Path: <linux-kernel-owner+w=401wt.eu-S932293AbXAJLsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXAJLsT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbXAJLsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:48:19 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43042 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293AbXAJLsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:48:18 -0500
Message-ID: <45A4D249.8080904@bull.net>
Date: Wed, 10 Jan 2007 12:47:21 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com>
In-Reply-To: <45A3C2CE.7070500@redhat.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 12:56:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 12:56:24,
	Serialize complete at 10/01/2007 12:56:24
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper a écrit :
> 
> I have never seen performance numbers for this.  If it is punishing
> existing code in a measurable way I think it's not anacceptable default
> behavior.
> 

Here are some numbers. My test program measures the latency of pthread_broadcast 
with 1000 pthreads (all threads are blocked on pthread_cond_wait, the time is 
measured between the broadcast call and the last woken pthread).

Here are the average latencies after 5000 measures.

[only this patch is used, not the following.
  The system is a dual Xeon 2.80GHz with HT enable]

First case: all threads are SCHED_OTHER
* with simple list:
Iterations=5000
Latency (us)      min      max      avg      stddev
                  3869     7400  6656.73      539.35

* with plist:
Iterations=5000
Latency (us)      min      max      avg      stddev
                  3684     7629  6787.97      479.41

Second case: all threads are SCHED_FIFO with priority equally distributed from 
priomin to priomax
* with simple list:
Iterations=5000
Latency (us)      min      max      avg      stddev
                  4548     7197  6656.85      463.30

* with plist:
Iterations=5000
Latency (us)      min      max      avg      stddev
                  8289    11752  9720.12      426.45


So, yes it (logically) has a cost, depending of the number of different 
priorities used, so it's specially measurable with real-time threads.
With SCHED_OTHER, I suppose that the priorities are not be very distributed.

May be, supposing it makes sense to respect the priority order only for 
real-time pthreads, I can register all SCHED_OTHER threads to the same 
MAX_RT_PRIO priotity ?
Or do you think this must be set behind a CONFIG* option ?
(Or finally not interesting enough for mainline ?)

-- 
Pierre
