Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTD1Vsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTD1Vsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:48:52 -0400
Received: from zero.aec.at ([193.170.194.10]:29455 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261324AbTD1Vsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:48:51 -0400
Date: Tue, 29 Apr 2003 00:00:00 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030428220000.GA9152@averell>
References: <20030427022346.GA27933@averell> <20030428091616.GA27064@fs.tum.de> <20030428114717.GA6904@averell> <20030428121920.GE27064@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428121920.GE27064@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 02:19:20PM +0200, Adrian Bunk wrote:
> Your approach as well as the approach I'm currently working on breaks
> the current semantics that a plain M386 produces a kernel that runs on
> CPUs.

You seem to be completely confused about what the patch is doing. 
CONFIG_X86_GENERIC does not break anything.

A kernel compiled with it will still run fine on the 386 (or whatever
the main CPU selection was). All it does is to make the worst case 
of the kernel running on a CPU with larger cache sizes that your "main" CPU
not as bad.

In fact if you read my patchkits in the last days they are all aimed
at making kernels run on more CPUs, not less. The eventual 
goal is to make Athlon kernels run on all 686+ class CPUs, and P4 kernels run
on all 686+ CPUs, and 386 kernels run well on all CPUs without bad
performance penalties.

M386 is a quite bad example here anyways. The standard situation 
is that people compile an SMP kernel for the P2 (which seems to be "the generic cpu" 
these days[1]). That kernel is compiled with a cache size of 32bytes.

This 32byte cache size is used to avoid false sharing in a lot of data structures;
e.g. arrays of per CPU data are usually padded to cache line size to make
sure each CPU has its own cache line in the array. This unfortunately does
not work when you run it on a CPU with a bigger cache line; like an Athlon
with 64byte cache line or an P4 with 128 byte cache. In this case a lot 
of performance will be lost on SMP because multiple CPUs will fight
for the data on a single cache line ("false sharing"). Always padding
to the worst case cache line size avoids this problem.

The issue is not an SMP only problem. Some device drivers already use
the cache line size to optimize PCI bus performance, and they have penalties
when the data is incorrectly padded.

Increasing the cache line size costs a bit of memory for more padding,
but overall the overhead is quite reasonable.

As far Jamies point: if you don't want your 386 kernel to be optimized
for the worst case just don't enable the X86_GENERIC option.

-Andi

[1] ignoring K6 and C3, which are too poor to have CMOV.

