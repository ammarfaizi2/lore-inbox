Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWFFW2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWFFW2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFFW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:28:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:39555 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751246AbWFFW2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:28:36 -0400
Message-ID: <4486017F.8030308@watson.ibm.com>
Date: Tue, 06 Jun 2006 18:28:15 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jay Lan <jlan@engr.sgi.com>, Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge
 plans)
References: <20060604135011.decdc7c9.akpm@osdl.org> <4484D25E.4020805@in.ibm.com>
In-Reply-To: <4484D25E.4020805@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Andrew Morton wrote:
> 
>> per-task-delay-accounting-setup.patch
>> per-task-delay-accounting-setup-fix-1.patch
>> per-task-delay-accounting-setup-fix-2.patch
>> per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
>>
>> per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch
>>
>> per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
>> per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch
>> per-task-delay-accounting-utilities-for-genetlink-usage.patch
>> per-task-delay-accounting-taskstats-interface.patch
>> per-task-delay-accounting-taskstats-interface-fix-1.patch
>> per-task-delay-accounting-taskstats-interface-fix-2.patch
>> per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
>>
>> per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
>>
>> per-task-delay-accounting-documentation.patch
>> per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
>>
>> per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch
>>
>>
>>  I just don't know.  There are a number of groups who pop up with various
>>  enhanced accounting requirements and patches (all quite different) but I
>>  haven't heard a lot of enthusiasm from any of them over this work, which
>>  attempts to provide an extensible framework for accumulation and
>> querying
>>  of per-task metrics.
>>
>>  But then again, we cannot just sit there and wait for everyone to be
>> 100%
>>  happy.  So I'm 51% inclined to push this along.
>>
>>  Anyone else who has an interest in this sort of thing needs to be aware
>>  that there will be an expectation that any future statistics submissions
>>  should use these interfaces.  So the time to pay attention is right now.
>>
> 
> Hi, Andrew,
> 
> Here is a brief summary of the status of the response we have received from
> the stakeholders (some of it has been duplicated in previous postings)
> 
> Project                                         Response
> 
> 1. CSA accounting/PAGG/JOB:                    Has agreed to use taskstats
>  Jay Lan <jlan@engr.sgi.com>                  interface
> 
> 2. per-process IO statistics:                  None
>  Levent Serinol <lserinol@gmail.com>          Needs are subset of CSA
> 
> 3. per-cpu time statistics:                    None (email bounced)
>  Erich Focht <efocht@ess.nec.de>              Needs can be met by taskstats
>                                               Statistics not yet submitted
> 
> 4. Microstate accounting:                      None
>  Peter Chubb <peterc@gelato.unsw.edu.au>      overlap with delay accounting
>                                               prefers /proc due to
> convenience
>                                               taskstats can meet the needs
> 
> 
> 5. ELSA: Guillaume Thouvenin                   None
>  <guillaume.thouvenin@bull.net>               ELSA is not a direct user
>                                               of new kernel statistics
>                                               Consumer of CSA/BSD
> accounting
>                                               statistics
> 
> 6. pnotify: Jes Sorensen <jes@sgi.com>         None
> (taken over pnotify from Erik Jacobson)        Informed over private email
>                                               that pnotify replacement is
>                                               being worked on. pnotify
>                                               or its replacement will
>                                               not be concerned with
>                                               exporting data to user space
>                                               or collecting any statistics.
> 
> 
> 7. Scalable statistics counters with /proc      Not working on it
>  reporting:                                   anymore
>  Ravikiran G Thirumalai,
>  Dipankar Sarma <dipankar@in.ibm.com>
> 
> Studying the responses from all stake holders, Jay Lan's was the most
> encouraging. Peter Chubb prefers the /proc interface due to the text
> interface
> and ease of parsing. (in our opinion, taskstats can meet the needs easily
> and the getdelays utility can provide the same ease for parsing).
> The others did not respond.
> Some performance numbers of taskstats were posted at
> http://lkml.org/lkml/2006/3/23/141. The result highlights are included
> below
> 
>    Results highlights
> 
>    - Configuring delay accounting adds < 0.5%
>      overhead in most cases and even reduces overhead
>      in some cases
> 
>    - Enabling delay accounting has similar results
>      with a maximum overhead of 1.2% for hackbench,
>      most other overheads < 1% and reduction in
>      overhead in some cases
> 
> These statistics are _per task_ and can be extended easily by anyone
> who wishes to obtain per task data. An example of per task improved
> scheduler statistics was mentioned in http://lkml.org/lkml/2006/6/1/381
> (I am not sure if the email refers to our per-task statistics). If not,
> the new statistics could easily use the taskstats interface.
> 
> These statistics can be used by software product stacks to monitor
> usage information about the various tasks they create and control.
> I also informally spoke to a group of students (verbally), who were
> excited at the possibility of using the per-task statistics to do
> dynamic deadline based power management. They want to use the delay data
> (CPU and IO) to predict deadlines for a task and then use these results
> for dynamically scaling CPU frequency.
> 
> 
> The ability to monitor the CPU run and delay data and IO delay data is
> useful.
> 
> I would request you to consider the inclusion per-task delay accounting
> into
> 2.6.18.
> 


Andrew,

The only other new set of patches to be discussed in this context are the
statistics-infrastructure patches from Martin Peschke.

That infrastructure cannot meet the needs of delay accounting, CSA etc. because
- it only provides "user pull" model of getting stats whereas "kernel push" is
needed for delay accounting
- it uses a relatively slow interface unsuitable for high volumes of data. Each
statistic has its own definition, needs to be read separately using ASCII,
reading data continuously means open/read/close each time.....all of
which is not very conducive to large structures being sent to userspace.
- its oriented towards sampled data whereas taskstats isn't.

So, we have a good consensus from existing/potential users of taskstats and would
very much appreciate it being included in 2.6.18.

--Shailabh




