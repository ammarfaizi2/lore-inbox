Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbRF0Wlq>; Wed, 27 Jun 2001 18:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265440AbRF0Wlg>; Wed, 27 Jun 2001 18:41:36 -0400
Received: from colorfullife.com ([216.156.138.34]:33802 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S265438AbRF0WlZ>;
	Wed, 27 Jun 2001 18:41:25 -0400
Message-ID: <3B3A6119.A951648@colorfullife.com>
Date: Thu, 28 Jun 2001 00:41:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: Scott Long <scott@swiftview.com>, linux-kernel@vger.kernel.org
Subject: Re: wake_up vs. wake_up_sync
In-Reply-To: <3B3A4E8B.E4301909@colorfullife.com> <20010627143845.D1135@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> 
> On Wed, Jun 27, 2001 at 11:22:19PM +0200, Manfred Spraul wrote:
> > > Why would you want to prevent
> > > reschedule_idle()?
> > >
> > If one process runs, wakes up another process and _knows_ that it's
> > going to sleep immediately after the wake_up it doesn't need the
> > reschedule_idle: the current cpu will be idle soon, the scheduler
> > doesn't need to find another cpu for the woken up thread.
> 
> I'm curious.  How does the caller of wake_up_sync know that the
> current cpu will soon be idle.  Does it assume that there are no
> other tasks on the runqueue waiting for a CPU?  If there are other
> tasks on the runqueue, isn't it possible that another task has a
> higher goodness value than the task being awakened.  In such a case,
> isn't is possible that the awakened task could sit on the runqueue
> (waiting for a CPU) while tasks with a lower goodness value are
> allowed to run?
>

I found one combination where that could happen:

process.thread
A.1: highest priority, runs on cpu0
B.1: lowest priority, runs on cpu1
A.2: another thread of process A, priority
PROC_CHANGE_PENALTY+PRIORITY(B.1)+1, sleeping.
B.2: same priority as A.2, sleeping, same process as B.1

A.1:
{
	wake_up("A.2");
/* nothing happens: preemption_goodness is 0 since B.1 has both
PROC_CHANGE_PENALTY and the += 1 from 'same mm'
*/
	wake_up_sync("B.2");
	schedule();
/* schedule selects A.2 instead of B.2 due to the += 1 from 'same mm'.
BUG: B.2 should replace B.1 on cpu1. The preemption_goodness is 1.
*/

IMHO obscure and very rare. 

But I just found a bigger problem:
If wake_up_sync wakes up more than 1 process then cpus could remain in
cpu_idle() although processes are on the runqueue without cpus.

--
	Manfred
