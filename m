Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVEaB02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEaB02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVEaB02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:26:28 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:63391 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261856AbVEaBZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:25:23 -0400
Date: Mon, 30 May 2005 18:25:11 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: more thread_info patches
Message-Id: <20050530182511.434b0e97.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0505310113370.10977@scrub.home>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
	<42676B76.4010903@ppp0.net>
	<Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
	<20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
	<20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.61.0505310113370.10977@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 01:48:28 +0200 (CEST) Roman Zippel wrote:

| Hi,
| 
| On Thu, 21 Apr 2005, Al Viro wrote:
| 
| > 	thread_info, part 1:
| 
| Here are some possible followup patches. Since it's already some time ago 
| here are the original posts for everyone else:
| http://marc.theaimsgroup.com/?l=linux-kernel&m=111410539627881&w=2
| 
| This introduces an additional stack variable in task_struct. It's 
| basically redundant with the thread_info pointer, but in the long term I'd 
| like to get of the latter (with the following patches).
| 
| ---
| 
|  include/linux/init_task.h |    1 +
|  include/linux/sched.h     |    1 +
|  kernel/fork.c             |    1 +
|  3 files changed, 3 insertions(+)
| 
| Index: linux-2.6-mm/include/linux/sched.h
| ===================================================================
| --- linux-2.6-mm.orig/include/linux/sched.h	2005-05-31 01:19:01.636591190 +0200
| +++ linux-2.6-mm/include/linux/sched.h	2005-05-31 01:19:05.913856451 +0200
| @@ -617,6 +617,7 @@ struct mempolicy;
|  struct task_struct {
|  	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
|  	struct thread_info *thread_info;
| +	void *stack;

Any reason this is void * instead of being more strongly typed?
Does the actual type vary?


And a general comments about the 4 emails:
they all have the same subject.  :(

I guess you need to read & follow:
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
and
http://linux.yyz.us/patch-format.html

so that Andrew doesn't have to keep saying this over and over again
(no, it's not just you).


|  	atomic_t usage;
|  	unsigned long flags;	/* per process flags, defined below */
|  	unsigned long ptrace;
| Index: linux-2.6-mm/include/linux/init_task.h
| ===================================================================
| --- linux-2.6-mm.orig/include/linux/init_task.h	2005-05-31 01:19:01.636591190 +0200
| +++ linux-2.6-mm/include/linux/init_task.h	2005-05-31 01:19:05.913856451 +0200
| @@ -71,6 +71,7 @@ extern struct group_info init_groups;
|  {									\
|  	.state		= 0,						\
|  	.thread_info	= &init_thread_info,				\
| +	.stack		= &init_stack,					\
|  	.usage		= ATOMIC_INIT(2),				\
|  	.flags		= 0,						\
|  	.lock_depth	= -1,						\
| Index: linux-2.6-mm/kernel/fork.c
| ===================================================================
| --- linux-2.6-mm.orig/kernel/fork.c	2005-05-31 01:19:01.636591190 +0200
| +++ linux-2.6-mm/kernel/fork.c	2005-05-31 01:19:29.954726757 +0200
| @@ -173,6 +173,7 @@ static struct task_struct *dup_task_stru
|  	*tsk = *orig;
|  	setup_thread_info(tsk, ti);
|  	tsk->thread_info = ti;
| +	tsk->stack = ti;
|  	ti->task = tsk;
|  
|  	/* One for us, one for whoever does the "release_task()" (usually parent) */
| -

---
~Randy
