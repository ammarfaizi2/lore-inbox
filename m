Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWEWFj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWEWFj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWEWFj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:39:29 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8112 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932067AbWEWFj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:39:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=By2PqEMb7Ljlx5dpF+AzvDX33eWBxP53LJdfNYgMN81kL6n4JLrxHgXRUntyGv4d2bI+JESqKUg6HDkjuhk2k7g1mkRPyE/YRhxqfNor51NCWzr/XiLGbXas5L2DIn6H6wigbps7LdTjQMQN5mTLjJCmm7Lyk2liop4DJ60xM+0=  ;
Message-ID: <4472A006.2090006@yahoo.com.au>
Date: Tue, 23 May 2006 15:39:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH (try #3)] mm: avoid unnecessary OOM kills
References: <200605230032.k4N0WCIU023760@calaveras.llnl.gov>
In-Reply-To: <200605230032.k4N0WCIU023760@calaveras.llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:
> Below is a 2.6.17-rc4-mm3 patch that fixes a problem where the OOM killer was
> unnecessarily killing system daemons in addition to memory-hogging user
> processes.  The patch fixes things so that the following assertion is
> satisfied:
> 
>     If a failed attempt to allocate memory triggers the OOM killer, then the
>     failed attempt must have occurred _after_ any process previously shot by
>     the OOM killer has cleaned out its mm_struct.
> 
> Thus we avoid situations where concurrent invocations of the OOM killer cause
> more processes to be shot than necessary to resolve the OOM condition.

Does this fix observed problems on real (or fake) workloads? Can we have
some more information about that?

I still don't quite understand why all this mechanism is needed. Suppose
that we single-thread the oom kill path (which isn't unreasonable, unless
you need really good OOM throughput :P), isn't it enough to find that any
process has TIF_MEMDIE set in order to know that an OOM kill is in progress?

down(&oom_sem);
for each process {
   if TIF_MEMDIE
      goto oom_in_progress;
   else
     calculate badness;
}
up(&oom_sem);

I have one other comment, below

> +/* If an OOM kill is not already in progress, try once more to allocate
> + * memory.  If allocation fails this time, invoke the OOM killer.
> + */
> +static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,
> +		struct zonelist *zonelist)
> +{
> +	static DECLARE_MUTEX(sem);
> +	struct page *page;
> +
> +	down(&sem);
> +
> +	/* Prevent parallel OOM kill operations.  This fixes a problem where
> +	 * the OOM killer was observed shooting system daemons in addition to
> +	 * memory-hogging user processes.
> +	 */
> +	if (oom_kill_active()) {
> +		up(&sem);
> +		goto out_sleep;
> +	}
> +
> +	/* If we get here, we _know_ that any previous OOM killer victim has
> +	 * cleaned out its mm_struct.  Therefore we should pick a victim to
> +	 * shoot if this allocation fails.
> +	 */
> +	page = get_page_from_freelist(gfp_mask | __GFP_HARDWALL, order,
> +				zonelist, ALLOC_WMARK_HIGH | ALLOC_CPUSET);
> +
> +	if (page) {
> +		up(&sem);
> +		return page;
> +	}
> +
> +	oom_kill_start();
> +	up(&sem);
> +
> +	/* Try to shoot a process.  Call oom_kill_finish() only if the OOM
> +	 * killer did not shoot anything.  If the OOM killer shot something,
> +	 * mmput() will call oom_kill_finish() once the mm_users count of the
> +	 * victim's mm_struct has reached 0 and the mm_struct has been cleaned
> +	 * out.
> +	 */
> +	if (out_of_memory(zonelist, gfp_mask, order))
> +		oom_kill_finish();  /* cancel OOM kill */
> +
> +out_sleep:
> +	/* Did we get shot by the OOM killer?  If not, sleep for a while to
> +	 * avoid burning lots of CPU cycles looping in the memory allocator.
> +	 * If the OOM killer shot a process, this gives the victim a good
> +	 * chance to die before we retry allocation.
> +	 */
> +	if (!test_thread_flag(TIF_MEMDIE))
> +		schedule_timeout_uninterruptible(1);
> +
> +	return NULL;
> +}

Is all this really required? Shouldn't you just have in place the
mechanism to prevent concurrent OOM killings in the OOM code, and
so the page allocator doesn't have to bother with it at all (ie.
it can just call into the OOM killer, which may or may not actually
kill anything).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
