Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDHR7N>; Sun, 8 Apr 2001 13:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDHR7D>; Sun, 8 Apr 2001 13:59:03 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:47122 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132576AbRDHR6q>;
	Sun, 8 Apr 2001 13:58:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104081758.VAA15670@ms2.inr.ac.ru>
Subject: Re: softirq buggy [Re: Serial port latency]
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 8 Apr 2001 21:58:35 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001301c0c050$69f69be0$5517fea9@local> from "Manfred Spraul" at Apr 8, 1 07:21:54 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But with a huge overhead. I'd prefer to call it directly from within the
> idle functions, the overhead of schedule is IMHO too high.


+	if (current->need_resched) {
+		return 0;
		^^^^^^^^
+	}
+	if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id())) {
+		do_softirq();
+		return 0;
		^^^^^^^^^
You return one value in both casesand I decided it means "schedule". 8)
Apparently you meaned return 1 in the first case. 8)

But in this case it becomes wrong. do_softirq() can raise need_reshed
and moreover irqs arrive during it. Order of check should be different.


BTW what's about overhead... I suspect it is _lower_ in the case
of schedule(). In the case of networking at least, when softirq
most likely wakes some socket.

Alexey
