Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUFON1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUFON1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUFON1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:27:35 -0400
Received: from zero.aec.at ([193.170.194.10]:37893 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265517AbUFON1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:27:21 -0400
To: Thomas Zehetbauer <thomasz@hostmaster.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA API observations
References: <271SM-3DT-7@gated-at.bofh.it> <27lI4-29E-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 15 Jun 2004 15:27:15 +0200
In-Reply-To: <27lI4-29E-19@gated-at.bofh.it> (Thomas Zehetbauer's message of
 "Tue, 15 Jun 2004 15:00:24 +0200")
Message-ID: <m3wu29kl3g.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer <thomasz@hostmaster.org> writes:

> Looking at these numastat results and the default policy it seems that
> memory is primarily allocated on the first node which in turn means a
> unnecessarily large amount of page faults on the second node.

NUMA memory policy has nothing to do with page faults.

If you get most allocations on the first node it either means most 
programs run on the first node (assuming they don't use NUMA API
to change their memory affinity) or more likely the programs running
on node 0 need more memory than those running on node 1.

That's easily possible, e.g. a typical desktop uses most of its
memory in the X server. If it runs on node 0 you get such skewed 
statistics. On servers it is often similar.

One way to combat that if it was really a problem would be to run the
X server with interleaving policy (numactl --interleave=all
XFree86)[1], but I would recommend careful benchmarks first if it's
really a win. Normally better local memory latency is the better
choice.

[1] Don't do that with startx or xinit, the rest of the X session should
probably not use that.

> I wonder if it is possible to better balance processes among the nodes
> by e.g. setting nodeAffinity = pid mod nodeCount

I assume you mean scheduling not memory affinity here. execve() and
clone() do that kind of (but based on node loads, not pids), but not fork.

-Andi

