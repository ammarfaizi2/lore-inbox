Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVCIMDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVCIMDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCIMDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:03:30 -0500
Received: from colin2.muc.de ([193.149.48.15]:25604 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262326AbVCIMCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:02:52 -0500
Date: 9 Mar 2005 13:02:51 +0100
Date: Wed, 9 Mar 2005 13:02:51 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, roland@redhat.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Bad patch to schedule()
Message-ID: <20050309120251.GA4374@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just see that this patch went into mainline.

[PATCH] posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls

This patch provides support for thread and process CPU time clocks in the
....

 /*
+ * This is called on clock ticks and on context switches.
+ * Bank in p->sched_time the ns elapsed since the last tick or switch.
+ */
+static inline void update_cpu_clock(task_t *p, runqueue_t *rq,
+				    unsigned long long now)
+{
+	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
+	p->sched_time += now - last;
+}
+

called from schedule(). The problem with this is that it completely
messes up the register allocation for i386 schedule() because it 
does long long arithmetic. This causes gcc to spill everything
else because it needs four registers, and i386 only has 6 usable
ones.

I think a critical path like the scheduler needs a little bit more
care.  Also it is totally unclear if this obscure POSIX feature
is really worth making schedule() slower. I think not.

In case it is kept it should be done in a way that doesn't impact
i386 unduly e.g. by avoiding long long arithmetic here and 
making sure fast paths stay fast.

I would propose to back this patch out again until this is resolved.

-Andi


