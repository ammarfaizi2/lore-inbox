Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbRDDPov>; Wed, 4 Apr 2001 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132844AbRDDPol>; Wed, 4 Apr 2001 11:44:41 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:57565 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S132843AbRDDPo1>;
	Wed, 4 Apr 2001 11:44:27 -0400
Message-ID: <3ACB4156.160B7937@fc.hp.com>
Date: Wed, 04 Apr 2001 09:44:22 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: a quest for a better scheduler
In-Reply-To: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> This is an important point that Mike is raising and it also addresses a
> critique that Ingo issued yesterday, namely interactivity and fairness.
> The HP scheduler completely separates the per-CPU runqueues and does
> not take preemption goodness or alike into account. This can lead to
> unfair proportionment of CPU cycles, strong priority inversion and a
> potential
> lack of interactivity.
> 
> Our MQ scheduler does yield the same decision in most cases
> (other than defined by some race condition on locks and counter members)
> 

Let me stress that HP scheduler is not meant to be a replacement for the
current scheduler. The HP scheduler patch allows the current scheduler
to be replaced by another scheduler by loading a module in special
cases. HP is providing three different loadable scheduler modules -
Processor sets, Constant time scheduler, and Multi-runqueue scheduler.
Each one of these is geared towards a specific requirement. I would not
suggest using any of these for a generalized case. Processor sets
scheduler is designed to make scheduling decisions on a per-cpu basis
and not global basis. All we are trying to do is to make the current
scheduler modular so we CAN load an alternate scheduling policy module
in cases where the process mix requires a different scheduling policy or
the site policy require a different scheduling policy. An example of a
specific site processor allocation policy could be a site that runs a
database server on an MP machine along with a few other processes and
the administrator wants to guarantee that the database server process
always gets x percent of processing time or one CPU be dedicated to just
the database server. A policy like this is not meant to be fair and of
course, not a policy we want to impose upon others. The only HP changes
I would put in the kernel sources for general release would be the
changes to scheduler to allow such alternate (not necessarily fair or
the fastest for benchmarks, general process mix or 1000's of processes)
policies to be loaded. When a policy module is not loaded, scheduler
works exactly like the current scheduler even after HP patches. There
are people who could benefit from being able to load alternate policy
schedules. Fabio Ricardi happens to be one of them :-) Anyone who does
not want to even allow an alternate scheduler module to be loaded can
simply compile the alternate scheduler support out and that is how I
would expect most kernels to be compiled, especially the ones that ship
with various distributions. I would like the decision to include support
for alternate scheduler to be made by sys admins themselves for their
individual cases.

--
Khalid
 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
