Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWGDAyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWGDAyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWGDAyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:54:44 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:56717 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751335AbWGDAyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:54:43 -0400
Date: Mon, 03 Jul 2006 20:54:37 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-reply-to: <44A9881F.7030103@watson.ibm.com>
To: hadi@cyberus.ca
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-id: <44A9BC4D.7030803@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com> <449C6620.1020203@engr.sgi.com>
 <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com>
 <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
 <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org>
 <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
 <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com>
 <44A5EDE6.3010605@watson.ibm.com> <20060630205148.4f66b125.akpm@osdl.org>
 <44A9881F.7030103@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:

> Andrew Morton wrote:
>
>> On Fri, 30 Jun 2006 23:37:10 -0400
>> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>
>>  
>>
>>>> Set aside the implementation details and ask "what is a good design"?
>>>>
>>>> A kernel-wide constant, whether determined at build-time or by a 
>>>> /proc poke
>>>> isn't a nice design.
>>>>
>>>> Can we permit userspace to send in a netlink message describing a 
>>>> cpumask? That's back-compatible.
>>>>
>>>>
>>>>     
>>>
>>> Yes, that should be doable. And passing in a cpumask is much better 
>>> since we no longer
>>> have to maintain mappings.
>>>
>>> So the strawman is:
>>> Listener bind()s to genetlink using its real pid.
>>> Sends a separate "registration" message with cpumask to listen to. 
>>> Kernel stores (real) pid and cpumask.
>>> During task exit, kernel goes through each registered listener 
>>> (small list) and decides which
>>> one needs to get this exit data and calls a genetlink_unicast to 
>>> each one that does need it.
>>>
>>> If number of listeners is small, the lookups should be swift enough. 
>>> If it grows large, we
>>> can consider a fancier lookup (but there I go again, delving into 
>>> implementation too early :-)
>>>   
>>
>>
>> We'll need a map.
>>
>> 1024 CPUs, 1024 listeners, 1000 exits/sec/CPU and we're up to a million
>> operations per second per CPU.  Meltdown.
>>
>> But it's a pretty simple map.  A per-cpu array of pointers to the 
>> head of a
>> linked list.  One lock for each CPU's list.
>>  
>>
> Here's a patch that implements the above ideas.
>
> A listener register's interest by specifying a cpumask in the
> cpulist format (comma separated ranges of cpus). The listener's pid
> is entered into per-cpu lists for those cpus and exit events from those
> cpus go to the listeners using netlink unicasts.
>
> Please comment.
>
> Andrew, this is not being proposed for inclusion yet since there is 
> atleast one more issue that needs to be resolved:
>
> What happens when a listener exits without doing deregistration
> (or if the listener attempts to register another cpumask while a current
> registration is still active).
>
( Jamal, your thoughts on this problem would be appreciated)

Problem is that we have a listener task which has "registered" with 
taskstats and caused
its pid to be stored in various per-cpu lists of listeners. Later, when 
some other task exits on a given cpu, its exit data is sent using 
genlmsg_unicast on each pid present on that cpu's list.

If the listener exits without doing a "deregister", its pid continues to 
be kept around, obviously not a good thing. So we need some way of 
detecting the situation (task is no longer listening on
these cpus events) that is efficient.

Two solutions come to mind:

1. During the exit of every task check to see if it is is already  
"registered" with taskstats. If so, do a cleanup of its pid on various 
per-cpu lists.

2. Before doing a genlmsg_unicast to a pid on one of the per-cpu lists 
(or if genlmsg_unicast
fails with a -ECONNREFUSED, a result of netlink_lookup failing for that 
pid), then just delete
it from that cpu's list and continue.

1 is more desirable because its the right place to catch this and 
happens relatively rarely
(few listener exits compared to all exits). However, how can we check 
whether a task/pid
has registered with taskstats earlier ? Again, two possibilities
- Maintain a list of registered listeners within taskstats and check that.
- try to leverage netlink's nl_pid_hash which maintains the same kind of 
info for each protocol.
Thus a netlink_lookup of the pid would save a lot of work.
However, the netlink layer's hashtable appears to be for the entire 
NETLINK_GENERIC
protocol and not just for the taskstats client of NETLINK_GENERIC. So 
even if a task has
deregistered with taskstats, as long as it has some other 
NETLINK_GENERIC socket open,
it will still show up as "connected" as far as netlink is concerned.

Jamal - is my interpretation correct ? Do I need to essentially 
replicate the pidhash at the
taskstats layer ? Thoughts on whether there's any way genetlink can 
provide support for this or
whether its desirable etc. (we appear to be the second user of genetlink 
- this may not be a
common need going forward).

1 has the disadvantage that if such a situation is detected, one has to 
iterate over all cpus in
the system, deleting that pid from any per-cpu list it happens to be in.
One could store the cpumask that the listener originally used to 
optimize this search. usual tradeoff of storage vs. time.

2 avoids the problem just mentioned since it delegates the task of 
cleanup to each cpu at the cost
of incurring an extra check for each listener for each exit on that cpu.
By storing the task_struct instead of the pid in the per-cpu lists, the 
check can be made quite
cheap.
But one problem with 2 is the issue of recycled task_structs and pids. 
Since the stale task on the
per-cpu listener list could have exited a while back, its possible its 
alive at the time of the check
and has even registered with a different interest list ! So it'll 
receive events it didn't register for.
I guess this again calls for us to maintain the listener list within 
taskstats explicitly (solution 1)
and explicitly catch the exit of the task/pid.

Thoughts ?

--Shailabh





