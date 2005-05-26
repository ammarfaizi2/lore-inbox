Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVEZI5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVEZI5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEZI5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:57:42 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40646 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261286AbVEZI5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:57:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17045.36727.602005.757948@alkaid.it.uu.se>
Date: Thu, 26 May 2005 10:57:27 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc5-mm1 includes Andrea's seccomp-disable-tsc patch,
which I believe is broken on SMP. In process.c we find:

 /*
+ * This function selects if the context switch from prev to next
+ * has to tweak the TSC disable bit in the cr4.
+ */
+static void disable_tsc(struct thread_info *prev,
+			struct thread_info *next)
+{
+	if (unlikely(has_secure_computing(prev) ||
+		     has_secure_computing(next))) {
+		/* slow path here */
+		if (has_secure_computing(prev) &&
+		    !has_secure_computing(next)) {
+			clear_in_cr4(X86_CR4_TSD);
+		} else if (!has_secure_computing(prev) &&
+			   has_secure_computing(next))
+			set_in_cr4(X86_CR4_TSD);
+	}
+}

which it calls from __switch_to().

The problem is that {set,clear}_in_cr4() both update a single
global mmu_cr4_features variable, which is asynchronously written
to all CPUs by {,__}flush_tlb_all(). Hence, the CR4.TSD setting
is at best probabilistic.

I spotted this because perfctr used to flip CR4.PCE in __switch_to()
ages ago, but I had to abandon that when kernel 2.3.40 changed to
the current scheme with a global mmu_cr4_features.
(Another reason was that CR4 writes were and still are very slow.)

/Mikael
