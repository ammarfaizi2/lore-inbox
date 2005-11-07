Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVKGGFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVKGGFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVKGGFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:05:55 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:64932 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964790AbVKGGFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:05:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Riyly9dkOyss3VoTHP816+8brRFt/WZa9lbwUpLiFyILaHuJIuMcXTECpRT0VbYEZMvUpMrm7R8KL+8o/2dsBh9vgSPS5v2Z7SLVFxan+GGgCAkSUY+NsZT4wWfiPyqFOl09Z03tD1JwsS80MgEz1eM9ypBO3djmfHSo5BlZF1E=  ;
Message-ID: <436EEF43.2050403@yahoo.com.au>
Date: Mon, 07 Nov 2005 17:08:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051106124944.0b2ccca1.pj@sgi.com>	<436EC2AF.4020202@yahoo.com.au>	<200511070442.58876.ak@suse.de> <20051106203717.58c3eed0.pj@sgi.com>
In-Reply-To: <20051106203717.58c3eed0.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>Anyway, I think the first problem is a showstopper. I'd look into
>>Hugh's SLAB_DESTROY_BY_RCU for this ...
> 
> 
> Andi wrote:
> 
>>RCU could be used to avoid that. Just only free it in a RCU callback.
> 
> 
> 
> ... looking at mm/slab.h and rcupdate.h for the first time ... 
> 

Yeah, take a look at rmap.c as well, and some of the comments in
changelogs if you need a better feel for it.

Basically SLAB_DESTROY_BY_RCU will allow the entries to be freed
back to the slab for reuse, but will not allow the slab caches to
be freed back to the page allocator inside rcu readside.

So your cpusets may be reused, but only as new cpusets. This should
be no problem at all for you.

> Would this mean that I had to put the cpuset structures on their own
> slab cache, marked SLAB_DESTROY_BY_RCU?
> 
> And is the pair of operators:
>   task_lock(current), task_unlock(current)
> really that much worse than the pair of operatots
>   rcu_read_lock, rcu_read_unlock
> which apparently reduce to:
>   preempt_disable, preempt_enable
> 

You may also have to be careful about memory ordering when setting
a pointer which may be concurrently dereferenced by another CPU so
that stale data doesn't get picked up.

The set side needs an rcu_assign_pointer, and the dereference side
needs rcu_dereference. Unless you either don't care about races, or
already have the correct barriers in place. But it is better to be
safe.

> Would this work something like the following?  Say task A, on processor
> AP, is trying to dereference its cpuset pointer, while task B, on
> processor BP, is trying hard to destroy that cpuset. Then if task A
> wraps its reference in <rcu_read_lock, rcu_read_unlock>, this will keep
> the RCU freeing of that memory from completing, until interrupts on AP
> are re-enabled.
> 

Sounds like it should work.

> For that matter, if I just put cpuset structs in their own slab
> cache, would that be sufficient.
> 

No, because the slab caches can get freed back into the general
page allocator at any time.

>   Nick - Does use-after-free debugging even catch use of objects
> 	 returned to their slab cache?
> 

Yes (slab debugging catches write-after-free at least, I believe),
however there are exceptions made for RCU freed slab caches. That
is: it is acceptable to access a freed RCU slab object, especially
if you only read it (writes need to be more careful, but they're
possible in some situations).

> What about the other suggestions, Andi:
>  1) subset zonelists (which you asked to reconsider)
>  2) a kernel flag "cpusets_have_been_used" flag to short circuit
>     cpuset logic on systems not using cpusets.
> 

Not too sure at present. I think #1 might be a good idea though
it would be a bigger change. #2 again might be a good hack for
the time being, although it would be nice to try to get the same
performance from the normal cpuset fastpath.

My RCU suggestion was mainly an idea to get around your immediate
problem with a lockless fastpath, rather than advocating it over
any of the alternatives.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
