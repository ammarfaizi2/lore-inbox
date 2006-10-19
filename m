Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWJSTWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWJSTWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423181AbWJSTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:22:08 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:31666 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422795AbWJSTWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:22:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5YU4kJwzChYlPi7egzEJqkP0HCYAJ+mX1sxus8TM6FlqdSgfFBo5EGdbw0I25I/1rgchNR1fQ/unTW908mWuHs452uUQ1oQNEWsmigXnjgig87zLiGtFV309qnMw0iACKOWz5o6od+S2k/0XAEOJlssoyzhQHit+DtEvXPgJYOc=  ;
Message-ID: <4537D056.9080108@yahoo.com.au>
Date: Fri, 20 Oct 2006 05:21:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>	<4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com>
In-Reply-To: <20061019120358.6d302ae9.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>You shouldn't need to, assuming cpusets doesn't mess it up.
> 
> 
> I'm guessing we're agreeing that the routines update_cpu_domains()
> and related code in kernel/cpuset.c are messing things up.

At the moment they are, yes.

> I view that code as a failed intrustion of some sched domain code into
> cpusets, and apparently you view that code as a failed attempt to
> manage sched domains coming from cpusets.
> 
> Oh well ... finger pointing is such fun ;).

:)

I don't know about finger pointing, but the sched-domains partitioning
works. It does what you ask of it, which is to partition the
multiprocessor balancing.

>>+	non_partitioned = top_cpuset.cpus_allowed;
>>+	update_cpu_domains_children(&top_cpuset, &non_partitioned);
>>+	partition_sched_domains(&non_partitioned);
> 
> 
> So ... instead of throwing the baby out, you want to replace it
> with a puppy.  If one attempt to overload cpu_exclusive didn't
> work, try another.

It isn't overloading anything. Your cpusets code has assigned a
particular semantic to cpu_exclusive. It so happens that we can
take advantage of this knowledge in order to do a more efficient
implementation.

It doesn't suddenly become a flag to manage sched-domains; its
semantics are completely unchanged (modulo bugs). The cpuset
interface semantics have no connection to sched-domains.

Put it this way: you don't think your code is currently
overloading the cpuset cpus_allowed setting in order to set the
task's cpus_allowed field, do you? You shouldn't need a flag to
tell it to set that, it is all just the mechanism behind the
policy.

> I have two problems with this.
> 
> 1) I haven't found any need for this, past the need to mark some
>    CPUs as isolated from the scheduler balancing code, which we
>    seem to be agreeing on, more or less, on another patch.
> 
>    Please explain why we need this or any such mechanism for user
>    space to affect sched domain partitioning.

Until very recently, the multiprocessor balancing could easily be very
stupid when faced with cpus_allowed restrictions. This is somewhat
fixed, but it is still suboptimal compared to a sched-domains partition
when you are dealing with disjoint cpusets.

It is mostly SGI who seem to be running into these balancing issues, so
I would have thought this would be helpful for your customers primarily.

I don't know of anyone else using cpusets, but I'd be interested to know.

> 2) I've had better luck with the cpuset API by adding new flags
>    when I needed some additional semantics, rather than overloading
>    existing flags.  So once we figure out what's needed and why,
>    then odds are I will suggest a new flag, specific to that purpose.

There is no new semantic beyond what is already specified by
cpu_exclusive.

> 
>    This new flag might well logically depend on the cpu_exclusive
>    setting, if that's useful.  But it would probably be a separate
>    flag or setting.
> 
>    I dislike providing explicit mechanisms via implicit side affects.

This is more like providing a specific implementation for a given
semantic.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
