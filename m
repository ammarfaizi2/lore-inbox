Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUHLWCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUHLWCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUHLV7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:59:06 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:61830 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268812AbUHLV53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:57:29 -0400
Date: Thu, 12 Aug 2004 23:56:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: suspend2 with smp
Message-ID: <20040812215644.GA20021@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

At some point I claimed that SMP support in suspend2 is "probably
broken". I guess I should post more data:

It is broken in theory.

+/*
+ * Save and restore processor state for secondary processors.
+ * IRQs (and therefore preemption) are already disabled
+ * when we enter here (IPI).
+ */
+
+void smp_suspend2_lowlevel(void * info)
+{
+       smp_mb();
+       barrier();
+       if (now_resuming) {
+               __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
+
+               kernel_fpu_begin();
+               atomic_inc(&suspend_cpu_counter);
+               smp_mb();
+               barrier();
#+               while ((software_suspend_state & SOFTWARE_SUSPEND_FREEZE_SMP) ||
#+                       (atomic_read(&suspend_cpu_counter) != smp_processor_id())) {
#+                       cpu_relax();
#+                       smp_mb();
+               }
+               my_saved_context = (unsigned char *) (suspend2_saved_contexts + smp_processor_id());
+               for (loop = sizeof(struct suspend2_saved_context); loop--; loop)
+                       *(((unsigned char *) &suspend2_saved_context) + loop - 1) = *(my_saved_context + loop - 1);
+               restore_processor_context();
+               FLUSH_LOCAL_TLB();
+               atomic_dec(&suspend_cpu_counter);

CPU is basically looping in loop marked by #, while its memory is
being overwriten. Now, the code probably works in practice, but it
should be really written in assembly so that compiler can not do
something stupid.

Compilers are not designed to deal with their stack (etc) randomly
overwritten, so compiler may do anything it wants here. I see that -O0
may help a lot here, but it simply is not the right thing to do.

At least /* FIXME: should be rewritten to assembly */ should be added there.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
