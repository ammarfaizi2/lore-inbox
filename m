Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUIIFlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUIIFlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 01:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269351AbUIIFlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 01:41:16 -0400
Received: from ozlabs.org ([203.10.76.45]:61107 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269346AbUIIFlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 01:41:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
Date: Thu, 9 Sep 2004 15:42:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane,

Just got a chance to look at the new out-of-line spinlock stuff
(better late than never :).  I see a couple of problems there.  First,
we now go two levels deep on SMP && PREEMPT: spin_lock is _spin_lock,
which is out of line in kernel/sched.c.  That calls
__preempt_spin_lock, which is out of line in kernel/sched.c, and isn't
in the .text.lock section.  So if we get a timer interrupt in there,
we won't attribute the profile tick to the original caller.

The second problem is that __preempt_spin_lock doesn't do the yield to
the hypervisor which we need to do on shared processor systems.  This
is actually a long-standing problem, not one you have just introduced,
but I have only just noticed it.  I can't make cpu_relax do the yield
because the yield is a directed yield to a specific other virtual cpu
(it says "give the rest of my timeslice to that guy over there") and I
need the value in the lock variable in order to know who is holding
the lock.

Regards,
Paul.
