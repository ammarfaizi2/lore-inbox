Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVDDUnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDDUnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDDUnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:43:32 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30449 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261389AbVDDUmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:42:08 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050404200043.GA16736@elte.hu>
References: <200504011419.20964.gene.heskett@verizon.net>
	 <424D9F6A.8080407@cybsft.com> <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
	 <20050402203550.GB16230@elte.hu>
	 <1112474659.27149.39.camel@localhost.localdomain>
	 <1112479772.27149.48.camel@localhost.localdomain>
	 <1112486812.27149.76.camel@localhost.localdomain>
	 <20050404200043.GA16736@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 04 Apr 2005 16:40:53 -0400
Message-Id: <1112647253.5147.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 22:00 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > So it is probably stuck in some spinning "yield" loop, which was the 
> > reason I was writing this test to begin with!  It's most likely also 
> > waiting for kjournald to do some work, and is starving it in a 
> > schedule or yield loop never actually going to sleep letting kjournald 
> > do the real work.
> 
> actually, what priorities do the yielding tasks have? sched_yield() does 
> not guarantee that the CPU will be given up, of if a highest-prio 
> SCHED_FIFO task is in a yield() loop it will livelock the system.
> 

What scares me is the code in fs/inode.c with that
__wait_on_freeing_inode.  Look at the code in find_inode and
find_inode_fast.  Here you will see that they really are busy loops with
a yield in them, if the inode they are waiting on is I_FREEING or
I_CLEAR and the process doing this hasn't set I_LOCK.  I haven't looked
much at this, but my kernel has livelocked on it.

My custom kernel plays with dynamic priorities. That is tasks jump
around in their priorities based on different situations not part of the
normal linux kernel. So my kernel can find these cases easier since a
path where a process gets bumped up to a high priority happens more
often and causes preemption more often than the normal RT kernel. But
this situation can probably occur in the RT kernel and maybe even the
mainline kernel, since it only needs to have a RT FIFO task get blocked
here, and a lower priority task needing to run to change the state.

Currently my fix is in yield to lower the priority of the task calling
yield and raise it after the schedule.  This is NOT a proper fix. It's
just a hack so I can get by it and test other parts. 

-- Steve


