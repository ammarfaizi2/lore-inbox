Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265750AbSJYAcm>; Thu, 24 Oct 2002 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSJYAcm>; Thu, 24 Oct 2002 20:32:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265750AbSJYAcj>;
	Thu, 24 Oct 2002 20:32:39 -0400
Message-Id: <200210250038.g9P0ciC20582@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net, cliffw@osdl.org
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Thu, 24 Oct 2002 15:29:44 PDT." <3DB87458.F5C7DABA@digeo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Oct 2002 17:38:44 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mingming cao wrote:
> > 
> > Hi Andrew,
> > 
> > Here is the updated ipc lock patch:
> 
> Well I can get you a bit of testing and attention, but I'm afraid
> my knowledge of the IPC code is negligible.
> 
> So to be able to commend this change to Linus I'd have to rely on
> assurances from people who _do_ understand IPC (Hugh?) and on lots
> of testing.
> 
> So yes, I'll include it, and would solicit success reports from
> people who are actually exercising that code path, thanks.
> 
> > http://www.osdl.org/projects/dbt1prfrns/results/mingming/index.html
> 
> DBT1 is really interesting, and I'm glad the OSDL team have
> put it together.  If people would only stop sending me patches
> I'd be using it ;)
> 
Thank you very much for that :)

> Could someone please help explain the results?  Comparing, say,
> http://www.osdl.org/projects/dbt1prfrns/results/mingming/run.2cpu.42-mm2.r5/index.html
> and
> http://www.osdl.org/projects/dbt1prfrns/results/mingming/run.18.r5/index.html
> 
> It would appear that 2.5 completely smoked 2.4 on response time,
> yet the overall bogotransactions/sec is significantly lower.
> What should we conclude from this?

Whoa - we ran these 5 times for an average. The 2.5 run you picked was the 
'off' run -
It has the worse results. You will notice on this run, there are a large 
number of errors
which didn't happen on the other runs - this lowered the BT/sec number. Use 
one of the
other 2.5 ones and you'll see something more sensible. ( say, 42-mm2.r3) 
Unfortunately,
on average, 2.4 still beats 2.5 on both response time and BT's

 		         2.5.42-mm2     2.5.42-mm2-ipclock  2.4.18
 Average over 5 runs     85.0 BT           89.8 BT          96.92 BT
 Std Deviation 5 runs    7.4  BT           1.0 BT           2.07 BT
 Average of best 4 runs  88.15 BT          90.2 BT          97.2 BT
 Std Deviation 4 run     2.8 BT            0.5 BT            2.3 BT 
> 
One other place to start comparing is in the system information which is at 
the bottom of the page.
Some points (might be minor) : 
Cpu statistics:
	2.4.18 - cpu %idle averages around 1.5% %system swings between 3-7% %nice 
steady at ~3.6%
	2.5.42-mm2 cpu %idle 0.0 all thru run, %system steady at ~6% % nice up ~5.5
Swap (sar -r) 
	Very slight differences - we consumed ~98% of the memory in both cases, 2.4 
swapped a little
		bit (%28) more than 2.5 (%26) 
We also include profile data for both the load and run phase. (profile=2)

> Also I see:
> 
> 	14.7 minute duration
> and
> 	Time for DBT run 19:36
> 
> What is the 14.7 minutes referring to?
> 
The 14.7 minute time comes from the workload driver log, which are parsed to 
get the
response numbers. The 'Time for' stamps come from the master driver script, 
and include some
of the workload startup and shutdown time. The workload driver waits a bit to 
be sure things are
stable, before the official run data is collected.  The script timestamp waits 
until the run clients are
dead. So there's always a bit of a delta between the two. 

> Also:
> 
> 	2.5: Time for key creation 1:27
> 	2.4: Time for key creation 14:24
> versus:
> 	2.5: Time for table creation 16:48
> 	2.4: Time for table creation 8:58
>  
	
	
This is a Mystery Question - we don't have an answer, we were hoping _you 
would see something :)
Table creation involves sequential inserts of data from a flat file to an 
SAPDB B-tree on a devspace.
Our devspace is a raw device, so we're doing raw io, plus some processing. 
This op is write-intensive
'Key creation' is establishing a foreign key column contraint on various 
tables.  For each table, it examines every row in the table,
looks up (does a B-tree index lookup) the column value in a second table to 
find a specific primary key that matches the
column value in the first table. So again, some I/O, a bit of processing. Key 
creation (foreign key) is read-intensive.
Also interesting is the delta in index creation:
	2.5 Time for index creation 27:58
	2.4 Time for index creation 17:21
Index creation requires a read of the table, a sort, then creation of a B-tree 
index.  Both the index and
table creates build a B-tree for SAP-DB ( both run slower on 2.5 ) - the table 
creation does no sorting.
We also notice that the times for both index and key creation varies a bit 
more across runs with the -mm2 kernel,
as shown by the standard deviation across the runs. 
mingming and 2.4.18 are a bit more consistent. ( we threw out -mm2 run 5 for 
this average, due to the errors)

Results are: average time[std dev] 
Action           2.4.18        2.5.42-mm2     2.5.42-mm2-ipclock
table create 	 8:55 [0:04]   19:03 [2:40]    19.39 [0:50]
index create     17:17 [0:11]  25:19 [5:31]    28:05 [0:02]
key create       14:23 [0:16]  15:21 [6:37]    18:46 [0:17]

Also interesting is -mm2 run2 - foreign key creation took 5:26, the run 
completed with no errors...why so fast, only one time?
 It is an ongoing mystery. We Just Don't Know Why Right Now.
We are working on better data capture of db/run errors, and we'd love to hear 
suggestions
on improving the instrumentation. 


> So it's all rather confusing.  Masses of numbers usually _are_
> confusing.  What really adds tons of value to such an exercise is
> for the person who ran the test to write up some conclusions. 

Yes, agreed. We don't yet know enough to map from test results to an exact 
kernel area.
We just added a database expert to staff (Mary Edie Meredith) so we intend to 
get better.
We'll probably be nagging you a bit, and again we very much appreciate all 
suggestions.

 To
> tell the developers what went well, what went poorly, what areas
> to focus on, etc.  To use your own judgement to tell us what to
> zoom in on.
> 
> Is that something which could be added?
> 
It is something we are working on adding.  
cliffw

> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Influence the future 
> of Java(TM) technology. Join the Java Community 
> Process(SM) (JCP(SM)) program now. 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 


