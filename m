Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269793AbUJGLYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269793AbUJGLYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbUJGLYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:24:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:21172 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269793AbUJGLYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:24:43 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
References: <20041007015139.6f5b833b.akpm@osdl.org.suse.lists.linux.kernel>
	<200410071041.20723.sandersn@btinternet.com.suse.lists.linux.kernel>
	<20041007025007.77ec1a44.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Oct 2004 13:23:46 +0200
In-Reply-To: <20041007025007.77ec1a44.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73oejeu5z1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Nick Sanders <sandersn@btinternet.com> wrote:
> >
> > On Thursday 07 October 2004 09:51, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
> >  >.9-rc3-mm3/
> >  >
> > 
> >  I get the following oops when booting and it also stops kde (artswrapper) from 
> >  starting with the same call trace. USB seems to be working which is good.
> 
> Could you please do
> 
> 
> cd /usr/src/linux
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
> 
> and retest?

Oops. I forgot the scheduling path indeed. Here's a new patch,
replacing the old. Sorry for the trouble.

-Andi

-------------------------------------------------------------

Fixed version of slight profile path optimization.

Signed-off-by: Andi Kleen <ak@suse.de>

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



