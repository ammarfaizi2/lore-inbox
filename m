Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVILLlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVILLlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVILLlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:41:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750742AbVILLln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:41:43 -0400
Date: Mon, 12 Sep 2005 04:39:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, Simon.Derr@bull.net, pj@sgi.com,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050912043943.5795d8f8.akpm@osdl.org>
In-Reply-To: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  +static struct task_struct *cpuset_sem_owner;
>  +static int cpuset_sem_depth;
>   
>   /*
>    * The global cpuset semaphore cpuset_sem can be needed by the
>  @@ -200,16 +202,19 @@ static DECLARE_MUTEX(cpuset_sem);
>   
>   static inline void cpuset_down(struct semaphore *psem)
>   {
>  -	if (current->cpuset_sem_nest_depth == 0)
>  +	if (cpuset_sem_owner != current) {
>   		down(psem);
>  -	current->cpuset_sem_nest_depth++;
>  +		cpuset_sem_owner = current;
>  +	}
>  +	cpuset_sem_depth++;
>   }

Better, but still hacky.  The rest of the kernel manages to avoid the need
for nestable semaphores by getting the locking design sorted out.  Can
cpusets do that sometime?

