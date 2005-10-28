Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVJ1AIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVJ1AIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVJ1AIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:08:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1942 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932698AbVJ1AIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:08:37 -0400
To: Alex Lyashkov <umka@sevcity.net>
Cc: fastboot@osdl.org, OBATA Noboru <noboru.obata.ar@hitachi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH] [KDUMP] pending interrupts problem
References: <20051027.165027.97297370.noboru.obata.ar@hitachi.com>
	<m1y84farz7.fsf@ebiederm.dsl.xmission.com>
	<1130429164.3360.1.camel@berloga.shadowland>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 27 Oct 2005 18:08:03 -0600
In-Reply-To: <1130429164.3360.1.camel@berloga.shadowland> (Alex Lyashkov's
 message of "Thu, 27 Oct 2005 19:06:04 +0300")
Message-ID: <m1u0f2bj18.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Lyashkov <umka@sevcity.net> writes:

> seems to bad patch. you dereference pointer (1) before check to NULL(2).

Duh.  I forgot to delete the earlier references. 
That should have been...

---

 arch/i386/kernel/smp.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

applies-to: e6a6c8ed12ba1ef7fa376fa3993e3c329e9f294a
50119a3947498cd8112455e8111f0579f5b8a232
diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
index 218d725..b0fb524 100644
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -560,6 +560,7 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			cpu_relax();
+	call_data = NULL;
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -604,11 +605,19 @@ fastcall void smp_reschedule_interrupt(s
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
 {
-	void (*func) (void *info) = call_data->func;
-	void *info = call_data->info;
-	int wait = call_data->wait;
+	void (*func) (void *info);
+	void *info;
+	int wait;
 
 	ack_APIC_irq();
+
+	/* Ignore spurious IPIs */
+	if (!call_data)
+		return;
+
+	func = call_data->func;
+	info = call_data->info;
+	wait = call_data->wait;
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
---
0.99.8.GIT
