Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935753AbWLAHvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935753AbWLAHvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935687AbWLAHvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:51:11 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:40861 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S935686AbWLAHvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:51:09 -0500
Date: Fri, 1 Dec 2006 16:50:50 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avr32: Fixup kprobes preemption handling.
Message-ID: <20061201075050.GA30051@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on SH kprobes, I noticed that avr32 got the preemption
handling wrong in the no probe case. The idea is that upon entry of
kprobe_handler() preemption is disabled outright across the life of the
kprobe, only to be re-enabled in post_kprobe_handler().

However, in the event that the probe is never activated, there's never
any chance of hitting the post probe handler, which allows for the
current avr32 implementation to disable preemption indefinitely, as it's
currently missing a re-enable when no probe is activated.

Patch follows.

--

diff --git a/arch/avr32/kernel/kprobes.c b/arch/avr32/kernel/kprobes.c
index ca41fc1..d0abbca 100644
--- a/arch/avr32/kernel/kprobes.c
+++ b/arch/avr32/kernel/kprobes.c
@@ -154,6 +154,7 @@ ss_probe:
 	return 1;
 
 no_kprobe:
+	preempt_enable_no_resched();
 	return ret;
 }
