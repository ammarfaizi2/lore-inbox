Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUFNQRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUFNQRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUFNQRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:17:53 -0400
Received: from colin2.muc.de ([193.149.48.15]:40974 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263191AbUFNQRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:17:50 -0400
Date: 14 Jun 2004 18:17:49 +0200
Date: Mon, 14 Jun 2004 18:17:49 +0200
From: Andi Kleen <ak@muc.de>
To: Anton Blanchard <anton@samba.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, lse-tech@lse.sourceforge.net
Subject: Re: NUMA API observations
Message-ID: <20040614161749.GA62265@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614153638.GB25389@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[right list for numactl discussions is lse-tech, not linux-kernel.
Adding cc]

On Tue, Jun 15, 2004 at 01:36:38AM +1000, Anton Blanchard wrote:
> Now if I try and interleave across all, the task gets OOM killed:
> 
> # numactl --interleave=all /bin/sh
> Killed
> 
> in dmesg: VM: killing process sh

interleave should always fall back to other nodes. Very weird.

Needs to be investigated. What were the actual arguments passed
to the syscalls? 

> 
> It works if I specify the nodes with memory:

That's probably a user space bug. Can you check what it passes
for "all" to the system calls? Maybe another bug in the sysfs
parser.

(you're using the latest version right? Previous ones were buggy)

> 
> # numactl --interleave=0,1 /bin/sh
> 
> Is this expected or do we want it to fallback when there is lots of
> memory on other nodes?

interleave should fall back.

> My kernel is compiled with NR_CPUS=128, the setaffinity syscall must be
> called with a bitmap at least as big as the kernels cpumask_t. I will
> submit a patch for this shortly.

Umm, what a misfeature. We size the buffer up to the biggest
running CPU. That should be enough. 

IMHO that's just a kernel bug. How should a user space
application sanely discover the cpumask_t size needed by the kernel?
Whoever designed that was on crack.

I will probably make it loop and double the buffer until EINVAL ends or it 
passes a page and add a nasty comment.

> 
> Next I looked at the numactl --show info:
> 
> # numactl --show
> policy: default
> preferred node: 0
> interleavemask:
> interleavenode: 0
> nodebind: 0 1 2 3
> membind: 0 1 2 3 4 5 6 7
> 
> Whats the difference between nodebind and membind? Why dont i see all 8

nodebind = cpubind 

Basically sched_setaffinity, but with node numbes.

That's actually the option to use too, just the documentation
is wrong (will fix). Even --cpubind always works with node numbers. 

-Andi
