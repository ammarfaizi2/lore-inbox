Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVILOjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVILOjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVILOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:39:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751122AbVILOjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:39:17 -0400
Date: Mon, 12 Sep 2005 07:38:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050912043943.5795d8f8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Sep 2005, Andrew Morton wrote:
> 
> Better, but still hacky.  The rest of the kernel manages to avoid the need
> for nestable semaphores by getting the locking design sorted out.  Can
> cpusets do that sometime?

Well, if you "rest of the kernel" you ignore the BKL, then yes.

Nesting isn't wrong per se - sometimes it allows things that would 
otherwise be very nasty to code around. We've been very strict with not 
allowing nesting for the low-level primitives (ie spinlocks etc), and 
instead requiring that people use them very carefully, but I don't think 
nesting is necessarily wrong for high-level constructs.

Personally, the thing that makes me think the patch is ugly is the fact 
that the different parts of the nested semaphore are all separate. I'd 
prefer to see a 

	struct nested_semaphore {
		struct semaphore sem;
		struct task_struct *owner;
		unsigned int count;
	};

and then operate on _that_ level instead. 

But keep it internal to the cpuset stuff - while I don't think nested 
semaphores are evil, they _are_ sometimes an excuse to be lazy and do 
things wrong just because it's easier.

Maybe that's the case in cpusets too, and Andrew may be right about this.

		Linus
