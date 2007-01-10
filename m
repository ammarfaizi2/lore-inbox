Return-Path: <linux-kernel-owner+w=401wt.eu-S964905AbXAJPGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbXAJPGs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbXAJPGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:06:48 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49351 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964905AbXAJPGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:06:47 -0500
Message-ID: <45A500CC.3030408@bull.net>
Date: Wed, 10 Jan 2007 16:05:48 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com> <45A4D249.8080904@bull.net> <20070110125416.GW29911@devserv.devel.redhat.com>
In-Reply-To: <20070110125416.GW29911@devserv.devel.redhat.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 16:14:53,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 16:14:54,
	Serialize complete at 10/01/2007 16:14:54
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree with all, that was what I have in mind too.

And by registering all SHED_OTHER threads with the same priority MAX_RT_PRIO, we 
have exactly this behavior, I think :

* the plist, when used with only one priority, behaves exactly as a simple list
(plist is a double simple list: first list contains all nodes sorted by 
priority, second list contains the first element of each "priority-based" 
sub-list of the first one):
Thus, when only one priority is used, there is nothing to sort at each add 
operation. (first list contains all elements by FIFO order, second list contains 
one element). So the overhead in this case is minimal and quasi-null.

* Now, if a SCHED_FIFO thread comes to the plist, its priority will be lower 
than MAX_RT_PRIO and it will be "naturally" sorted by prio order, and thus, it 
will be woken before the SCHED_OTHER threads because of its higher priority 
(i.e. lower prio-value in the kernel).

But there can be a performance impact when several processes use different 
futexes which have the same hash key.
In fact, the plist contains all waiters _of_all_futexes_ having the same hash 
key, not only the waiters of a given futex. This can be more a problem, if one 
process uses SCHED_FIFO threads, and the other SCHED_OTHER: the first will 
penalize the second...  but even in this case, as the second has a lower 
priority, this can be acceptable, I think ?

Jakub Jelinek a écrit :
> On Wed, Jan 10, 2007 at 12:47:21PM +0100, Pierre Peiffer wrote:
>> So, yes it (logically) has a cost, depending of the number of different 
>> priorities used, so it's specially measurable with real-time threads.
>> With SCHED_OTHER, I suppose that the priorities are not be very distributed.
>>
>> May be, supposing it makes sense to respect the priority order only for 
>> real-time pthreads, I can register all SCHED_OTHER threads to the same 
>> MAX_RT_PRIO priotity ?
>> Or do you think this must be set behind a CONFIG* option ?
>> (Or finally not interesting enough for mainline ?)
> 
> As soon as there is at least one non-SCHED_OTHER thread among the waiters,
> there is no question about whether plist should be used or not, that's
> a correctness issue and if we want to conform to POSIX, we have to use that.
> 
> I guess Ulrich's question was mainly about performance differences
> with/without plist wakeup when all threads are SCHED_OTHER.  I'd say for
> that a pure pthread_mutex_{lock,unlock} benchmark or even just a program
> which uses futex FUTEX_WAIT/FUTEX_WAKE in a bunch of threads would be
> better.
> 
> In the past we talked with Ingo about the possibilities here, one is use
> plist always and prove that it doesn't add measurable overhead over current
> FIFO (when only SCHED_OTHER is involved), the other possibility would be
> to start using FIFOs as before, but when the first non-SCHED_OTHER thread
> decides to wait on the futex, switch it to plist wakeup mode (convert the
> FIFO into a plist) and from that point on just use plist wakeups on it.
> 
> 	Jakub
> 

-- 
Pierre Peiffer
