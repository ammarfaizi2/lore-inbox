Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUCRTCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUCRTCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:02:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:15829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262866AbUCRTCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:02:01 -0500
Date: Thu, 18 Mar 2004 11:01:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318110159.321754d8.akpm@osdl.org>
In-Reply-To: <s5hlllycgz3.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> > These fixes from Takashi Iwai brings 2.6 back in line with 2.4, I
> > suggested to use EIP dumps from interrupts to get the hotspots, he
> > promptly used the RTC for that and he could fixup all the spots, great
> > job he did since now we've a very low worst case sched latency in 2.6
> > too:
> > 
> > --- linux/fs/mpage.c-dist	2004-03-10 16:26:54.293647478 +0100
> > +++ linux/fs/mpage.c	2004-03-10 16:27:07.405673634 +0100
> > @@ -695,6 +695,7 @@ mpage_writepages(struct address_space *m
> >  			unlock_page(page);
> >  		}
> >  		page_cache_release(page);
> > +		cond_resched();
> >  		spin_lock(&mapping->page_lock);
> >  	}
> >  	/*
> 
> the above one is the major source of RT-latency.

This one's fine.

> for ext3, these two spots are relevant.
> 
> --- linux-2.6.4-8/fs/jbd/commit.c-dist	2004-03-16 23:00:40.000000000 +0100
> +++ linux-2.6.4-8/fs/jbd/commit.c	2004-03-18 02:42:41.043448624 +0100
> @@ -290,6 +290,9 @@ write_out_data_locked:
>  			commit_transaction->t_sync_datalist = jh;
>  			break;
>  		}
> +
> +		if (need_resched())
> +			break;
>  	} while (jh != last_jh);
>  
>  	if (bufs || need_resched()) {

This one I need to think about.  Perhaps we can remove the yield point a
few lines above.

One needs to be really careful with the lock-dropping trick - there are
weird situations in which the kernel fails to make any forward progress. 
I've been meaning to do another round of latency tuneups for ages, so I'll
check this one out, thanks.

There's also the SMP problem: this CPU could be spinning on a lock with
need_resched() true, but the other CPU is hanging on the lock for ages
because its need_resched() is false.  In the 2.4 ll patch I solved that via
the scary hack of broadcasting a reschedule instruction to all CPUs if an
rt-prio task just became runnable.  In 2.6-preempt we use
preempt_spin_lock().

But in 2.6 non-preempt we have no solution to this, so worst-case
scheduling latencies on 2.6 SMP CONFIG_PREEMPT=n are high.


Last time I looked the worst-case latency is in fact over in the ext3
checkpoint code.  It's under spinlock and tricky to fix.

> --- linux-2.6.4-8/fs/ext3/inode.c-dist	2004-03-18 02:33:38.000000000 +0100
> +++ linux-2.6.4-8/fs/ext3/inode.c	2004-03-18 02:33:40.000000000 +0100
> @@ -1987,6 +1987,7 @@ static void ext3_free_branches(handle_t 
>  	if (is_handle_aborted(handle))
>  		return;
>  
> +	cond_resched();
>  	if (depth--) {
>  		struct buffer_head *bh;
>  		int addr_per_block = EXT3_ADDR_PER_BLOCK(inode->i_sb);
> 

This one's OK.

btw, several months ago we discussed the idea of adding a sysctl to the
ALSA drivers which would cause a dump_stack() to be triggered if the audio
ISR detected a sound underrun.

This would be a very useful feature, because it increases the number of
low-latency developers from O(2) to O(lots).  If some user is complaining
of underruns we can just ask them to turn on the sysctl and we get a trace
pointing at the culprit code.

And believe me, we need the coverage.  There are all sorts of weird code
paths which were found during the development of the 2.4 low-latency patch.
i2c drivers, fbdev drivers, all sorts of things which you and I don't
test.

I know it's a matter of

	if (sysctl_is_set)
		dump_stack();

in snd_pcm_update_hw_ptr_post() somewhere, but my brain burst when working
out the ALSA sysctl architecture.

Is this something you could add please?

