Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266945AbRGOUQA>; Sun, 15 Jul 2001 16:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266947AbRGOUPu>; Sun, 15 Jul 2001 16:15:50 -0400
Received: from ns.suse.de ([213.95.15.193]:48903 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266945AbRGOUPk>;
	Sun, 15 Jul 2001 16:15:40 -0400
Date: Sun, 15 Jul 2001 22:15:42 +0200
From: Andi Kleen <ak@suse.de>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: David Lang <david.lang@digitalinsight.com>, Larry McVoy <lm@bitmover.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010715221542.B14480@gruyere.muc.suse.de>
In-Reply-To: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.33.0107131249200.4540-100000@dlang.diginsite.com> <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com>; from mkravetz@sequent.com on Fri, Jul 13, 2001 at 03:43:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 03:43:05PM -0700, Mike Kravetz wrote:
> - Define a new field in the task structure 'saved_cpus_allowed'.
>   With a little collapsing of existing fields, there is room to put
>   this on the same cache line as 'cpus_allowed'.
> - In reschedule_idle() if we determine that the best CPU for a task
>   is the CPU it is associated with (p->processor), then temporarily
>   bind the task to that CPU.  The task is temporarily bound to the
>   CPU by overwriting the 'cpus_allowed' field such that the task can
>   only be scheduled on the target CPU.  Of course, the original
>   value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
> - In schedule(), the loop which examines all tasks on the runqueue
>   will restore the value of 'cpus_allowed'.

This sounds racy, at least with your simple description. Even other CPUs
could walk their run queue while the IPI is being processed and reset the
cpus_allowed flag too early. I guess it would need a check in the 
schedule loop that restores cpus_allowed that the current CPU is the only
on set in that task's cpus_allowed. This unfortunately would hang the
process if the CPU for some reason cannot process schedules timely, so
it may be needed to add a timestamp also to the task_struct that allows 
the restoration of cpus_allowed even from non target CPUs after some
time.


-Andi
