Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWE2GMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWE2GMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWE2GMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:12:46 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:31837 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751230AbWE2GMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:12:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GwUxRsayIdpgQn3SU4enZL03w97v0FQOghJ/+oCPahdmI0r74BXhv9gW0l4GFqFGA+CCHNcxTsXEQrggpO0rCgWK92dPyIZNL8OZRZ5fuhFkzYlL/dRA8IzGi1z5yEKccQMOVb7hORQsGhryyImcgQr7JcV4Xqdu37mFPC4LD60=  ;
Message-ID: <447A90DA.3020502@yahoo.com.au>
Date: Mon, 29 May 2006 16:12:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH (try #3)] mm: avoid unnecessary OOM kills
References: <200605230032.k4N0WCIU023760@calaveras.llnl.gov> <4472A006.2090006@yahoo.com.au> <7.0.0.16.2.20060523094646.02429fd8@llnl.gov> <44739E2D.60406@yahoo.com.au> <7.0.0.16.2.20060524073251.0237c250@llnl.gov>
In-Reply-To: <7.0.0.16.2.20060524073251.0237c250@llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:
> At 04:43 PM 5/23/2006, Nick Piggin wrote:

>>>I agree it's desirable to keep the OOM killing logic as encapsulated
>>>as possible.  However unless you are holding the oom kill semaphore
>>>when you make your final attempt to allocate memory it's a bit racy.
>>>Holding the OOM kill semaphore guarantees that our final allocation
>>>failure before invoking the OOM killer occurred _after_ any previous
>>>OOM kill victim freed its memory.  Thus we know we are not shooting
>>>another process prematurely (i.e. before the memory-freeing effects
>>>of our previous OOM kill have been felt).
>>
>>But there is so much fudge in it that I don't think it matters:
>>pages could be freed from other sources, some reclaim might happen,
>>the point at which OOM is declared is pretty arbitrary anyway, etc.
> 
> 
> There's definitely some fudge in it.  However the main scenario I'm
> concerned with is where one big process is hogging most of the memory
> (as opposed to a case where the collective memory-hogging effect of
> lots of little processes triggers the OOM killer).  In the first case
> we want to shoot the one big process and leave the little processes
> undisturbed.
> 
> If the final allocation failure before invoking the OOM killer
> occurs when we don't yet hold the OOM kill semaphore then I'd
> be concerned about processes queueing up on the OOM kill semaphore
> after they fail their memory allocations.  If only one of these
> ends up getting awakened _after_ the death of the big memory hog,
> then that process will enter the OOM killer and shoot a little
> process unnecessarily.
> 
> Alternately (perhaps less likely), if your kernel is preemptible,
> after the memory hog has been shot but not yet expired a process
> may get preempted between its final allocation failure and its
> choosing an OOM kill victim (with the memory hog expiring before
> the preempted process gets rescheduled).  Then the preempted
> process shoots a little process when rescheduled.

But just call into the oom killer, and let it queue up and/or do
nothing according to whether there is still a task being shot or
not.

page allocation would then just try again.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
