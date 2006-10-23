Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWJWGRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWJWGRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWJWGRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:17:36 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:47228 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751577AbWJWGRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:17:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fNvxn6m+YiJSLY0QX8PdxlvUj5JInks7IQvlbYbMiD6izkrPbAjw9qNt+Au1iAUQDpInJajH3IY1W8DsfYAzpqN9fi0e0RG/RSrs1ZT7v/yyGadn5Qd2mzMMG/Rt2NAU9Vs4iHmUxrzdfcPqS/4+hoibi0Tj2xjCuwu0hX85c+Y=  ;
Message-ID: <453C5E77.2050905@yahoo.com.au>
Date: Mon, 23 Oct 2006 16:17:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<20061020210422.GA29870@in.ibm.com>	<20061022201824.267525c9.pj@sgi.com>	<453C4E22.9000308@yahoo.com.au> <20061022225108.21716614.pj@sgi.com>
In-Reply-To: <20061022225108.21716614.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>Did you send resend the patch to remove sched-domain partitioning?
>>After clearing up my confusion, IMO that is needed and could probably
>>go into 2.6.19.
> 
> 
> The patch titled
>      cpuset: remove sched domain hooks from cpusets
> went into *-mm on Friday, 20 Oct.
> 
> Is that the patch you mean?

Yes.

> It's just the first step - unplugging the old.
> 
> Now we need the new:
>  1) Ability at runtime to isolate cpus for real-time and such.
>  2) Big systems perform better if we can avoid load balancing across
>     zillions of cpus.

These are both part of the same larger solution, which is to
partition domains. isolated CPUs are just the case of 1 CPU in
its own domain (and that's how they are implemented now).

So we need the interface or some driver to do this partitioning.

>>A cool option would be to determine the partitions according to the
>>disjoint set of unions of cpus_allowed masks of all tasks. I see this
>>getting computationally expensive though, probably O(tasks*CPUs)... I
>>guess that isn't too bad.
> 
> 
> Yeah - if that would work, from the practical perspective of providing
> us with a useful partitioning (get those humongous sched domains carved
> down to a reasonable size) then that would be cool.
> 
> I'm guessing that in practice, it would be annoying to use.  One would
> end up with stray tasks that happened to be sitting in one of the bigger
> cpusets and that did not have their cpus_allowed narrowed, stopping us
> from getting a useful partitioning.  Perhaps anilliary tasks associated
> with the batch scheduler, or some paused tasks in an inactive job that
> were it active would need load balancing across a big swath of cpus.
> These would be tasks that we really didn't need to load balance, but they
> would appear as if they needed it because of their fat cpus_allowed.

But we simply can't make a partition for them because they have asked
to use all CPUs. We can't know if this is something that should be
partitioned or not, can we?

> Users (admins) would have to hunt down these tasks that were getting in
> the way of a nice partitioning and whack their cpus_allowed down to
> size.

In the sense that they get what they ask for, yes. The obvious route
for the big SGI systems is to put them in the right cpuset. The job
managers (or admins) on those things are surely up to the task.

This leaves unbound and transient kernel threads like pdflush as a
remaining problem. Not quite sure what to do about that yet. I see
you have a little hack in there...

> So essentially, one would end up with another userspace API, backdoor
> again.  Like those magic doors in the libraries of wealthy protagonists
> in mystery novels, where you have to open a particular book and pull
> the lamp cord to get the door to appear and open.
> 
> Automatic chokes and transmissions are great - if they work.  If not,
> give me a knob and a stick.

But your knob is just going to be some mechanism to say that you don't
care about such and such a task, or you want to put task x into domain
y.

> ===
> 
> Another idea for a cpuset-based API to this ...
> 
>>From our internal perspective, it's all about getting the sched domain
> partitions cut down to a reasonable size, for performance reasons.
> 
> But from the users perspective, the deal we are asking them to
> consider is to trade in fully automatic, all tasks across all cpus,
> load balancing, in turn for better performance.
> 
> Big system admins would often be quite happy to mark the top cpuset
> as "no need to load balance tasks in this cpuset."  They would
> take responsibility for moving any non-trivial, unpinned tasks into
> lower cpusets (or not be upset if something left behind wasn't load
> balancing.)
> 
> And the batch scheduler would be quite happy to mark its top cpuset as
> "no need to load balance".  It could mark any cpusets holding inactive
> jobs the same way.
> 
> This "no need to load balance" flag would be advisory.  The kernel
> might load balance anyway.  For example if the batch scheduler were
> running under a top cpuset that was -not- so marked, we'd still have
> to load balance everyone.  The batch scheduler wouldn't care.  It would
> have done its duty, to mark which of its cpusets didn't need balancing.
> 
> All we need from them is the ok to not load balance certain cpusets,
> and the rest is easy enough.  If they give us such ok on enough of the
> big cpusets, we give back a nice performance improvement.

I think this is much more of an automatic behind your back thing. If
they don't want any load balancing to happen, they could pin the tasks
in that cpuset to the cpu they're currently on, for example.

It would be trivial to make such a script to parse the root cpuset and
do exactly this, wouldn't it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
