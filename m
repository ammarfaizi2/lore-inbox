Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWGDIJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWGDIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGDIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:09:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbWGDIJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:09:58 -0400
Date: Tue, 4 Jul 2006 01:04:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: kaos@sgi.com, torvalds@osdl.org, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Message-Id: <20060704010455.811eedbc.akpm@osdl.org>
In-Reply-To: <44AA1D7A.2060202@sgi.com>
References: <21169.1151991139@kao2.melbourne.sgi.com>
	<44AA1D7A.2060202@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2006 09:49:14 +0200
Jes Sorensen <jes@sgi.com> wrote:

> Keith Owens wrote:
> >> static void invalidate_bh_lrus(void)
> >> {
> >> -	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
> >> +	/*
> >> +	 * Need to hand down a copy of the mask or we wouldn't be run
> >> +	 * anywhere due to the original mask being cleared
> >> +	 */
> >> +	cpumask_t mask = lru_in_use;
> >> +	cpus_clear(lru_in_use);
> >> +	schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
> >> }
> > 
> > Racy?  Start with an empty lru_in_use.
> > 
> > Cpu A                         Cpu B
> > invalidate_bh_lrus()
> > mask = lru_in_use;
> > preempted
> >                               block I/O
> > 			      bh_lru_install()
> > 			      cpu_set(cpu, lru_in_use);
> > resume
> > cpus_clear(lru_in_use);
> > schedule_on_each_cpu_mask() - does not send IPI to cpu B
> 
> I guess the real question is whether the device is still valid for new
> IO by the time we hit the invalidate function. If not, and that was my,
> possibly flawed, assumption, then it's not an issue. Whatever bh's are
> left in the lrus from other devices will be handled on the next hit.
> 

The problem is that we can actually lose bits in invalidate_bh_lrus().

CPU0				CPU1

mask = lru_in_use;
				cpu_set(lru_in_use, 1);
cpus_clear(lru_in_use);

Now we have a stray bh which nobody knows about.
