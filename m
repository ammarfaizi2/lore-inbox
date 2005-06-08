Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVFHVr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVFHVr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVFHVr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:47:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:59851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262007AbVFHVrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:47:00 -0400
Date: Wed, 8 Jun 2005 14:46:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
Message-Id: <20050608144630.6d167813.akpm@osdl.org>
In-Reply-To: <42A73ED8.9040505@fujitsu-siemens.com>
References: <42A07BAA.4050303@fujitsu-siemens.com>
	<20050603160629.2acc4558.akpm@osdl.org>
	<42A5AD4A.6080100@fujitsu-siemens.com>
	<20050607120811.6527a9ff.akpm@osdl.org>
	<42A73ED8.9040505@fujitsu-siemens.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <martin.wilck@fujitsu-siemens.com> wrote:
>
> Hello Andrew,
> 
> > The semaphore is initialised with the limit level, so once it has been
> > down()ed more than `limit' times, processes will block until someone does
> > up().
> 
> Oh - of course. Neat.
> 
> >>It appears to run much more 
> >> smoothly now, perhaps because wakeup_bdflush() isn't called any more. 
> >> Are you still interested in more data?
> > 
> > Perhaps the newer kernel has writeback thresholding fixes so it's not
> > possible to dirty as much memory with write().
> 
> I have collected more data and the behavior with 2.6.12-rc5-mm2 is 
> flawless, there is a continuous writeback flow close to the maximum rate 
> possible, and the bounce buffer usage never gets anywhere near the limit 
> where it'd become dangerous. At least not in my test setup. The latest 
> fedora kernel 2.6.11-1.27 also behaves ok, although it doesn't adapt to 
> changing io load as smoothly as 2.6.12-rc5-mm2 does, and the writeback 
> rate is oscillating more strongly.
> 
> The kernels where I observe the problem are 2.6.9 kernels from RedHat 
> EL4. I have posted this here because I saw that the highmem bounce 
> buffer/memory pool implementation was identical between the 2.6.9 kernel 
> and all but the very latest development kernels, and I concluded 
> prematurely that the behavior under my scenario must also be the same -- 
> which it wasn't. I apologize for not having looked more closely.
> 
> Many thanks for looking into this anyway. From a theoretical point of 
> view, I still think I had a valid point :-/.
> 
> Your patch sure looks good to me.

Well.  As I said, I think what you're seeing here is recent changes to
mm/page-writeback.c which reduce the amount of memory which we'll permit to
be dirtied due to write() calls.  You'll probably find that the bounce
buffer problem is also fixable by reducing /proc/sys/vm/dirty_ratio in
2.6.9, for the same reasons.

What concerns me is that there are other ways of dirtying lots of memory
apart from write(): namely mmap(MAP_SHARED).  If someone dirties 90% of all
memory via mmap() then we might again get into bounce buffer starvation.

