Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWDJVpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDJVpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWDJVpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:45:04 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:30347 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751209AbWDJVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:45:01 -0400
Date: Mon, 10 Apr 2006 17:44:59 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 0/8] per-task delay accounting
In-reply-to: <443A929A.9040102@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       erikj@sgi.com, lserinol@gmail.com, guillaume.thouvenin@bull.net,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, Jes Sorensen <jes@sgi.com>
Message-id: <443AD1DB.5090303@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <442B271D.10208@watson.ibm.com>
 <20060329210314.3db53aaa.akpm@osdl.org> <20060330062357.GB18387@in.ibm.com>
 <20060329224737.071b9567.akpm@osdl.org> <442CCF54.3000501@watson.ibm.com>
 <442D8E39.8080606@engr.sgi.com> <442DED81.5060009@engr.sgi.com>
 <443A929A.9040102@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

> I made two feedback on 3/31 only to see them bounced
> back over the weekend. :(
>
> Here was my first feedback:
>
> Shailabh Nagar wrote:
> >>
> >>Following Andrew's suggestion, here's my quick overview
> >>of the various other accounting packages that have been
> >>proposed on lse-tech with a focus on whether they can
> >>utilize the netlink-based taskstats interface being proposed
> >>by the delay accounting patches.
> >>
> >>Please note that unification of statistics *collection* is not
> >>being discussed since that kind of merger can be done as these
> >>patches get accepted, if at all, into the kernel. To try and
> >>unify right away would hold every patch (esp. delay accounting !)
> >>hostage to the problems in every other patch unnecessarily. As
> >>long as the interface can be unified, the merger of the
> >>collection bits can always happen without affecting user space.
> >>
> >>Stakeholders of each of these patches, on cc, are requested to
> >>please correct any misunderstandings of what their patches do.
> >
> >To me, data collection and formation before sending down to
> >userspace is very important part.  What this taskstats netlink
> >interface does is  just to provide an interface to send "already
> >formatted" data to userspace. In other words, it will replace
> >"writing accounting records to an accounting file" step currently
> >performed in BSD accouting and in CSA. 

Exactly. The writing of the accounting file can be done in userspace
through a CSA-specific daemon reading the data.

> If i understand it correctly,
> >you have delayacct.c sitting on top of taskstats interface, and
> >all other accounting methods should build their own layer on top
> >of taskstats as well. 

Yes, all the new ones that are yet to be included in the kernel

> For example, potentially BSD acct.c can replace
> >fput() (and other statements dealing with acctounting file) with
> >this interface. Same for CSA.

Yes. I'm not sure if changing BSD would be useful (since I don't
know how often it is used ?) but yes, it can be done and CSA is
similar.

> >
> >This approach sounds right to me. Actually i am very glad that you
> >made effort to provide a common ground here. Yet, this is only
> >one step. I will apply your patchset on top of 2.6.16-mm to see
> >what i get and give more feedback later.
>
> And, here is the second one:
>
>>
>>
>> This taskstats thing is much more complicated than what Guillaume
>> used to have when he put up a prototype of doing ELSA over netlink.
>> One confusing point is the struct taskstats. If it is to be used
>> as the big data struct to contain all accounting data everybody
>> needs (as Shailabh suggested on his CSA analysis section), then
>> if at do_exit() every accounting methods are to be invoked to
>> handle their netlink transmission (as currently implemented in
>> delayed accounting), would it be a lot of overhead sending "grand
>> data" too many times? Maybe each layer should just format data of
>> their interest when invoked from do_exit, and then we do one call
>> to genetlink to deliver formated struct taskstats data? 
>

Good idea. One can already do this in the code we submitted by adding
functions similar to delayacct_add_tsk() within the fill_pid() and 
fill_tgid() parts
of the taskstats code. Then the delayacct_tsk_exit() routine will serve 
as the
 "one call" to deliver formatted data.

However, using delayacct_tsk_exit (which does have delay accounting specific
bits too) as the data delivery call isn't intuitive. So I'll separate 
out the taskstats_exit_pid
as a separate call directly made within do_exit(). Will require some 
refactoring but it
can be done.


>>
>> Also, as you pointed out, CSA only retrieve data at end of task
>> but delayed accounting needs to retrieve data during the process.
>> So, i think we need more than one record types, not just the
>> struct taskstats, so that the user space delayed accounting 
>> application can specify to get only delayed accounting record. 
>
A separate record type isn't needed, atleast for now. For delay 
accounting, the data obtained during a
process' lifetime is the same as the one expected at the end. So by 
itself, it has no need to distinguish
records generated during the lifetime and those generated after a 
process exits.

Yes, the additional fields added to the taskstats struct by CSA will be 
"unnecessary" for delay accounting
users but they will have to be able to deal with that anyway (for the 
process exit records where CSA and delay
will share a common exit record).

So creating a separate record structure for the "during lifetime" 
records trades off transmission of a larger structure (relatively cheap) 
vs. the added complexity of tracking two types of records.
At this point, the tradeoff isn't worth it for us.


>> Honestly, this taskstats.c layer looks more like something
>> extracted from delayed accounting than a carefully designed common 
>> ground to me. 
>
If you have other specific suggestions about the interface and why it 
doesn't meet CSA's needs,
we can work to fix them.

>> Patch 8/8 is about documentation of delayed
>> accounting than the common ground for various accounting methods.
>
True. Patch 8/8 was meant to document delay accounting alone. I'll 
extract the
taskstats specific parts out.

>> Can you please present us a documentation of design concept of
>> such a common layer ?
>
Well, the design is fairly straightforward and is probably apparent by now.
A common per-task accounting structure called taskstats exists.
Userspace can use a NETLINK_GENERIC interface to send queries for
statistics of a particular pid or tgid during the lifetime of a process.
Specifying the pid gives the stats for just that pid. Specifying the 
tgid returns
the sum of stats for all threads of the tgid.

Userspace can also choose to open the NETLINK_GENERIC socket in 
multicast and
listen for per-pid and per-tgid statistics that are automatically  sent 
from the kernel using a whenever a task exits. These stats are sent
whenever there is any listener on the genetlink socket. The per-pid and 
per-tgid
data are exactly the same as what you would get if a query could be done 
just before
a task exited. Sending the per-tgid data at the exit of each pid/tid is 
necessary since
there is no well-defined "tgid exit" point in the kernel (we do not 
define a thread group to
cease existence when the thread group leader exits...rather it ceases to 
exist when the
last thread of the thread group exits). Also, per-tgid accumalation is 
only done dynamically in the kernel, not maintained as a separate 
statistic (to avoid wasting time and space). So each time a  tid from a 
tgid exits, one needs to collect and send the whole tgid's data in case 
userspace is trying to track the stats at a per-tgid level.

The statistic structure contents are documented in include/linux/taskstats.h
and by the accounting subsystem which fills in the fields. Currently 
delay accounting
is the only user so all the fields are of the form
    XXX_count and XXX_delay_total

where the former is a count of number of values added in the latter. 
Latter is the
cumulative "delay", in nanoseconds, seen by a pid waiting for the 
resource XXX.
e.g. cpu_delay_total is the total time spent waiting for a cpu to run 
on, blkio_delay_total
is the time spent waiting for  sync block I/O to complete etc.

As more per-task accounting packages get added to the kernel, they can 
define
additional fields following the instructions in 
include/linux/taskstats.h and define their
own userspace utilities similar to getdelays.c
Querying for data during a task's lifetime is done completely 
independently by all the utilities
(using unicast queries and replies) - responses to queries by one are 
not seen by the others.
The stats sent on task exit are common and multicast to all listening 
utilities.


Will add this to a separate taskstats doc in Documentation/.

>> That would help me. I guess i also need to catch up on genetlink to 
>> better understand taskstats code.
>
Please do so soon. The usage of genetlink for taskstats has gone through 
a detailed review by Jamal etc. so there shouldn't be any genetlink 
issues that are pertinent to the potential CSA usage of taskstats.


--Shailabh


>>
>> Regards.
>>  - jay
>>
