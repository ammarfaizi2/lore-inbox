Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVJBHCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVJBHCT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVJBHCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:02:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51654 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750984AbVJBHCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:02:19 -0400
Date: Sun, 2 Oct 2005 00:01:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Ok to change cpuset flags for sched domains? (was [PATCH 1/3]
 CPUMETER ...)
Message-Id: <20051002000159.3f15bf7a.pj@sgi.com>
In-Reply-To: <20050927084905.7d77bdde.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinikar,

How much grief will it cause you if I make the following incompatible
change to the special boolean files in each cpuset directory?

I think I goofed in encouraging you to overload "cpu_exclusive"
with defining dynamic scheduler domains.  I should have asked for a
separate flag to be added for that, say "sched_domain", which would
require "cpu_exclusive=1" as a precondition.  Other attributes that
require cpu_exclusive or mem_exclusive are showing up, and it makes
more sense for each of them to get their own boolean, and leave the
"*_exclusive" flags to specify just the exclusive (no overlap with
sibling) attribute.

I don't have much code built on top of this yet, so it won't matter
much to me.  But I worry about the affect that such an incompatible
change would have on your user code.

Here is the proposed change, as I first described it in Takahiro-san's
thread on cpumeter:

=====================================================================

The above proposal makes it more obvious than ever that I am starting
to overload the meaning of cpu_exclusive and mem_exclusive perhaps a
bit too much.

One or the other of the two *_exclusive flags should be required
preconditions for some of these special properties (sched domains,
GFP_KERNEL memory allocation confinement, oom killer confinement, cpu
metering and memory metering), but perhaps actually enabling any of
these special properties should be an additional and distinct choice.

Therefore I propose some new cpuset flags:
 * 'sched_domain' to mark sched domains (now done by the cpu_exclusive
   flag),
 * 'kernel_memory' to mark the constraints on GFP_KERNEL allocations,
 * 'oom_killer' to mark the constraints on oom killing,
 * your 'meter_cpu' flag to mark a set of metered cpus, and
 * your 'meter_mem' flag to mark a set of metered mems.

Each of these new flags would require the appropriate cpu_exclusive or
mem_exclusive flag on the same cpuset to already be set, but just
setting the *_exclusive flags by themselves would not be enough to get
you the special behaviour.  You would also have to set the appropriate
one of these new flags.

So, for example, the condition to define a sched domain would change,
from just being the lowest level cpuset marked cpu_exclusive (or the
left over CPUs not marked exclusive), to being both that -and- having
its "sched_domain" flag marked True (or being the left over CPUs,
again).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
