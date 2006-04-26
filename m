Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWDZPKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWDZPKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWDZPKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:10:21 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:8855 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932466AbWDZPKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:10:21 -0400
In-Reply-To: <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com>
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
Date: Wed, 26 Apr 2006 16:06:31 +0100
To: Hugh Dickins <hugh@veritas.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Apr 2006, at 15:46, Hugh Dickins wrote:

> If that's so (I don't trust my judgement on matters of speculative
> execution), then I think you'd do better to replace the *ptep = 
> __pte(0)
> by pte_clear(mm, addr, ptep), and so avoid your ugly #ifdef'ing: please
> check, but I think you'll find that reduces to just the barrier you 
> want.
> CC'ed Zach since it's his optimization, and he'll judge that 
> spexecution.

In more detail the problem is that, since we're still running on the 
page tables while clearing them, the CPU may choose to prefetch a 
half-cleared pte into its TLB, and then execute speculative memory 
accesses based on that mapping (including ones that may write-allocate 
cachelines, leading to problems like the AMD AGP GART deadlock Linux 
had a year or so back).

The barrier is needed to ensure that the bottom half is cleared before 
the top half. In fact it probably ought to be wmb() -- that's clearer 
in intent and actually reduces to barrier() on all PAE-capable 
platforms.

We cannot use pte_clear() unless we redefine it for PAE. Currently it 
reduces to set_pte() which explicitly uses the wrong ordering (sets 
high *then* low, because it's normally used to introduce a mapping).

Also, I think wmb() should be used in PAE's set_pte(), rather than the 
current smp_wmb(). They reduce to the same thing, but wmb() makes it 
clear this is is not an issue specific to SMP systems.

  -- Keir

