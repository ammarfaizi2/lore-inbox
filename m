Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750864AbWFFBAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWFFBAE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWFFBAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:00:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:36759 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750864AbWFFBAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:00:01 -0400
Message-ID: <4484D25E.4020805@in.ibm.com>
Date: Tue, 06 Jun 2006 06:24:54 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jay Lan <jlan@engr.sgi.com>,
        Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Merge of per task delay accounting (was Re: 2.6.18 -mm merge plans)
References: <20060604135011.decdc7c9.akpm@osdl.org>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> per-task-delay-accounting-setup.patch
> per-task-delay-accounting-setup-fix-1.patch
> per-task-delay-accounting-setup-fix-2.patch
> per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
> per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch
> per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
> per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch
> per-task-delay-accounting-utilities-for-genetlink-usage.patch
> per-task-delay-accounting-taskstats-interface.patch
> per-task-delay-accounting-taskstats-interface-fix-1.patch
> per-task-delay-accounting-taskstats-interface-fix-2.patch
> per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
> per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
> per-task-delay-accounting-documentation.patch
> per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
> per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch
> 
>  I just don't know.  There are a number of groups who pop up with various
>  enhanced accounting requirements and patches (all quite different) but I
>  haven't heard a lot of enthusiasm from any of them over this work, which
>  attempts to provide an extensible framework for accumulation and querying
>  of per-task metrics.
> 
>  But then again, we cannot just sit there and wait for everyone to be 100%
>  happy.  So I'm 51% inclined to push this along.
> 
>  Anyone else who has an interest in this sort of thing needs to be aware
>  that there will be an expectation that any future statistics submissions
>  should use these interfaces.  So the time to pay attention is right now.
> 

Hi, Andrew,

Here is a brief summary of the status of the response we have received from
the stakeholders (some of it has been duplicated in previous postings)

Project                                         Response

1. CSA accounting/PAGG/JOB:                    Has agreed to use taskstats
  Jay Lan <jlan@engr.sgi.com>                  interface

2. per-process IO statistics:                  None
  Levent Serinol <lserinol@gmail.com>          Needs are subset of CSA

3. per-cpu time statistics:                    None (email bounced)
  Erich Focht <efocht@ess.nec.de>              Needs can be met by taskstats
                                               Statistics not yet submitted

4. Microstate accounting:                      None
  Peter Chubb <peterc@gelato.unsw.edu.au>      overlap with delay accounting
                                               prefers /proc due to convenience
                                               taskstats can meet the needs


5. ELSA: Guillaume Thouvenin                   None
  <guillaume.thouvenin@bull.net>               ELSA is not a direct user
                                               of new kernel statistics
                                               Consumer of CSA/BSD accounting
                                               statistics

6. pnotify: Jes Sorensen <jes@sgi.com>         None
(taken over pnotify from Erik Jacobson)        Informed over private email
                                               that pnotify replacement is
                                               being worked on. pnotify
                                               or its replacement will
                                               not be concerned with
                                               exporting data to user space
                                               or collecting any statistics.


7. Scalable statistics counters with /proc      Not working on it
  reporting:                                   anymore
  Ravikiran G Thirumalai,
  Dipankar Sarma <dipankar@in.ibm.com>

Studying the responses from all stake holders, Jay Lan's was the most
encouraging. Peter Chubb prefers the /proc interface due to the text interface
and ease of parsing. (in our opinion, taskstats can meet the needs easily
and the getdelays utility can provide the same ease for parsing).
The others did not respond. 

Some performance numbers of taskstats were posted at
http://lkml.org/lkml/2006/3/23/141. The result highlights are included
below

    Results highlights

    - Configuring delay accounting adds < 0.5%
      overhead in most cases and even reduces overhead
      in some cases

    - Enabling delay accounting has similar results
      with a maximum overhead of 1.2% for hackbench,
      most other overheads < 1% and reduction in
      overhead in some cases

These statistics are _per task_ and can be extended easily by anyone
who wishes to obtain per task data. An example of per task improved
scheduler statistics was mentioned in http://lkml.org/lkml/2006/6/1/381
(I am not sure if the email refers to our per-task statistics). If not,
the new statistics could easily use the taskstats interface.

These statistics can be used by software product stacks to monitor
usage information about the various tasks they create and control.
I also informally spoke to a group of students (verbally), who were
excited at the possibility of using the per-task statistics to do
dynamic deadline based power management. They want to use the delay data
(CPU and IO) to predict deadlines for a task and then use these results
for dynamically scaling CPU frequency.


The ability to monitor the CPU run and delay data and IO delay data is useful.

I would request you to consider the inclusion per-task delay accounting into
2.6.18.

-- 

	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
