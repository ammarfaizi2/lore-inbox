Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVLSAT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVLSAT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVLSAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:19:58 -0500
Received: from waste.org ([64.81.244.121]:40082 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030191AbVLSAT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:19:57 -0500
Date: Sun, 18 Dec 2005 16:12:49 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Light-weight dynamically extended stacks
Message-ID: <20051219001249.GD11856@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the time for this has come and gone, but it occurred to me
that it should be relatively straightforward to make a form of
dynamically extended stacks that are appropriate to the kernel.

While we have a good handle on most of the worst stack offenders, we
can still run into trouble with pathological cases (say, symlink
recursion for XFS on a RAID built from loopback mounts over NFS
tunneled over IPSEC through GRE). So there's probably no
one-size-fits-all when it comes to stack size.

Rather than relying on guard pages and VM faults like userspace, we
can use a cooperative scheme where we "label" call paths that might be
extra deep (recursion through the block layer, network tunnels,
symlinks, etc.) with something like the following:

	  ret = grow_stack(function, arg, GFP_ATOMIC);

This is much like cond_resched() except for stack usage rather than
CPU usage. grow_stack() checks if we're in the danger zone for stack
usage (say 1k remaining), and if so, allocates a new stack and
swizzles the stack pointer over to it.

Then, whether we allocated a new stack page or not, we call
function(arg) to continue with our operation. When function() returns,
we deallocate the new stack (if we built one), switch back to the old
one, and propagate function's return value.

We only get into trouble with this scheme when we can't allocate a new
stack, which will only happen when we're completely out of memory[1]
and we can't sleep waiting for more. In which case, we print a warning
of impending doom and proceed to run with our current stack. This is
the same as our current behavior but with a warning message. For
safety, we can keep a small mempool of extra stacks on hand to avoid
hitting this wall when dealing with OOM in an atomic context.

We can also easily instrument the scheme to print warnings when a
process has allocated more than a couple stacks, with a hard limit to
catch any unbounded recursion.

[1] Assuming we're using 4k stacks, where fragmentation is not an
issue. But there's no reason not to use single-page stacks with this
scheme.
-- 
Mathematics is the supreme nostalgia of our time.
