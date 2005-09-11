Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVIKQFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVIKQFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVIKQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:05:45 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18890 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S964827AbVIKQFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:05:44 -0400
Date: Mon, 12 Sep 2005 01:02:24 +0900 (JST)
Message-Id: <20050912.010224.112611776.taka@valinux.co.jp>
To: pj@sgi.com
Cc: magnus.damm@gmail.com, kurosawa@valinux.co.jp, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050910015209.4f581b8a.pj@sgi.com>
References: <20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Well, I suspect I don't understand yet.
> 
> Nice picture though - that gives me some idea what you mean.
> 
> Do notice that the basic rule of cpu_exclusive cpusets is that their
> CPUs don't overlap their siblings.  Your Cpusets 1, 2, and 3 seem to be
> marked cpu_exclusive in your picture, but all contain the same CPUs 2
> and 3, overlapping each other.

Yes, I know the current design of cpu_exclusive.
I just thought if I could enhance cpu_exclusive to cover a group of
cpusets to make the hierarchy as flat as possible.

> I'm guessing what you are trying to draw is:
> 
>   Tasks on CPUs 0 and 1 have no resource control limits.

I thought CPU 1 could have resource control limits.

>   Tasks on CPUs 2 and 3 have resource control limits specifying
> 	what percentage of the CPUs 2 and 3 is available to them.
> 
> I might draw my solution to that as:

I understand your idea clearly, which is essentially the same as
Korosawa's design. Your design looks very straight and I have
no objection to it.

My only concern is that it would become harder to control resources
between CPUSET 1a,1b and 1c if some processes are assigned to CPUSET 1
directly. But I just get an idea that it would be OK if CPUSET 1 can
have meter_cpu=1 to share the resources.

>      +-----------------------------------+
>      |                                   |
>   CPUSET 0                            CPUSET 1         
>   sched domain A                      sched domain B   
>   cpus: 0, 1                          cpus: 2, 3       
>   cpu_exclusive=1                     cpu_exclusive=1
>   meter_cpu=0                         meter_cpu=0
>                                          |
>                         +----------------+----------------+
>                         |                |                |
>                      CPUSET 1a        CPUSET 1b        CPUSET 1c
>                      cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
> 		     cpu_exclusive=0  cpu_exclusive=0  cpu_exclusive=0
>                      meter_cpu=1      meter_cpu=1      meter_cpu=1
>                      meter_cpu_*      meter_cpu_*      meter_cpu_*
> 
> The meter_cpu_* files in each of Cpusets 1a, 1b, and 1c control what
> proportion of the CPU resources in that Cpuset can be used by the tasks
> in that Cpuset.
> 
> If meter_cpu is false (0) then the meter_cpu_* files do not appear,
> which is equivalent to allowing 100% of the CPUs in that Cpuset to
> be used by the tasks in that Cpuset (and descendents, of course.)
> 
> Don't forget - this all seems like it has significant mission overlap
> with CKRM.  I hate to repeat this, but the relation of your work to
> CKRM needs to be understood before I am likely to agree to accepting
> your work into the kernel (not that my acceptance is required; you
> really just need Linus to agree, though he of course considers the
> positions of others to some inscrutable degree.)

OK.

Thanks,
Hirokazu Takahashi.
