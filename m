Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUFRWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUFRWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUFRWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:02:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:39917 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263731AbUFRWAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:00:54 -0400
Date: Fri, 18 Jun 2004 15:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: sivanich@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-Id: <20040618150337.2b3db85b.akpm@osdl.org>
In-Reply-To: <40D358C5.9060003@colorfullife.com>
References: <40D08225.6060900@colorfullife.com>
	<20040616180208.GD6069@sgi.com>
	<40D09872.4090107@colorfullife.com>
	<20040617131031.GB8473@sgi.com>
	<20040617214035.01e38285.akpm@osdl.org>
	<20040618143332.GA11056@sgi.com>
	<20040618134045.2b7ce5c5.akpm@osdl.org>
	<40D358C5.9060003@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> I'll write something:
> - allow to disable the DMA kmalloc caches for archs that do not need them.
> - increase the timer frequency and scan only a few caches in each timer.
> - perhaps a quicker test for cache_reap to notice that nothing needs to 
> be done. Right now four tests are done (!flags & _NO_REAP, 
> ac->touched==0, ac->avail != 0, global timer not yet expired). It's 
> possible to skip some tests. e.g. move the _NO_REAP caches on a separate 
> list, replace the time_after(.next_reap,jiffies) with a separate timer.

Come to think of it, replacing the timer with schedule_delayed_work() and
doing it all via keventd should work OK.  Doing everything in a single pass
is the most CPU-efficient way of doing it, and as long as we're preemptible
and interruptible the latency issues will be solved.
