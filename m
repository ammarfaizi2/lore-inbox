Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUJKMmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUJKMmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJKMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:41:32 -0400
Received: from zero.aec.at ([193.170.194.10]:63247 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268894AbUJKMkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:40:47 -0400
To: Tim Cambrant <cambrant@acc.umu.se>
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: 2.6.9-rc4-mm1
References: <2O5L3-5Jq-11@gated-at.bofh.it> <2O6Ho-6ra-51@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 11 Oct 2004 14:40:35 +0200
In-Reply-To: <2O6Ho-6ra-51@gated-at.bofh.it> (Tim Cambrant's message of
 "Mon, 11 Oct 2004 13:40:26 +0200")
Message-ID: <m3zn2tv35o.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant <cambrant@acc.umu.se> writes:

> On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>>
>> optimize-profile-path-slightly.patch
>>   Optimize profile path slightly
>>
>
> I'm still getting an oops at startup with this patch. After reversing
> it, everything is fine. Weren't you supposed to remove that from your
> tree until it was fixed?

There's a fixed version around. I thought Andrew had merged that one?

-Andi

-------------------------------------

Fixed version of profile optimization


Index: linux/kernel/profile.c
===================================================================
--- linux.orig/kernel/profile.c	2004-09-30 10:35:51.%N +0200
+++ linux/kernel/profile.c	2004-10-07 13:22:33.%N +0200
@@ -181,20 +181,27 @@
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
-void profile_hit(int type, void *__pc)
+static inline void __profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
 
-	if (prof_on != type || !prof_buffer)
-		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
 
+void profile_hit(int type, void *pc)
+{
+	if (prof_on != type || !prof_buffer)
+		return;
+	__profile_hit(type, pc);
+}
+
 void profile_tick(int type, struct pt_regs *regs)
 {
 	if (type == CPU_PROFILING)
 		profile_hook(regs);
+	if (prof_on != type || !prof_buffer)
+		return;
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

