Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWDRERa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWDRERa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 00:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDRERa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 00:17:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751394AbWDRER3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 00:17:29 -0400
Date: Mon, 17 Apr 2006 21:16:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: BUG: spinlock lockup/wrong CPU/recursion -- when reading
 numa_maps on 2.6.17-rc1
Message-Id: <20060417211633.5ddfa0df.akpm@osdl.org>
In-Reply-To: <20060418000042.GA7376@kevlar.burdell.org>
References: <20060418000042.GA7376@kevlar.burdell.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao <sonny@burdell.org> wrote:
>
>  Hi, I ran into a deadlock on 2.6.16-mm2 when I was running a
>  multi-threaded application and was reading /proc/<pid>/numa_maps for
>  the app. 
> 
>  I recompiled with DEBUG_SPINLOCK and I can get various error messages
>  on kernels ranging from 2.6.17-rc1 to serveral mm kernels including
>  2.6.16-mm[12] and 2.6.16-rc5-mm[23] (mm kernels before this seem to break
>  a lot on my box)
> 
>  My current guess, based on my rudimentary understanding of the code, is
>  that  we are rescheduling while holding a spinlock in
>  check_pte_range() which is called from show_numa_map() in mempolicy.c.  
> 
>  Specifically, the gather_stats() function which is called inside
>  check_pte_range() has a cond_resched() at the end.  Maybe that line
>  should be changed to cond_resched_lock() or should simply be removed.   
> 
>  I'll try removing it and see what happens.

Yes, that's a bug and that cond_resched() needs to go.

We would have found this quite quickly if cond_resched() had a
might_sleep() in it.  It really should have such a check, but we cannot do
this because in some configurations, might_sleep() calls cond_resched().
That was rather nasty or us.  Ingo, can you think of a fix please?

This bug would also have been exposed as a scheduling-while-atomic warning
on those rare occasions when the cond_resched() actually calls schedule(). 
But that won't be enabled unless the NUMA guys actually test with all debug
options, as I repeatedly and apparently ineffectively have suggested.

