Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVI2WAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVI2WAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVI2WAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:00:48 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:6623 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750797AbVI2WAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:00:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Fri, 30 Sep 2005 00:01:08 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <200509281624.29256.rjw@sisk.pl> <200509282224.43397.rjw@sisk.pl> <20050928170031.D30088@unix-os.sc.intel.com>
In-Reply-To: <20050928170031.D30088@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300001.10258.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 29 of September 2005 02:00, Siddha, Suresh B wrote:
> On Wed, Sep 28, 2005 at 10:24:42PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 28 of September 2005 21:18, Andi Kleen wrote:
> > > Also Suresh S. has a patch out to turn the initial page tables
> > > into initdata. It'll probably conflict with that. Needs to be coordinated
> > > with him.
> > 
> > Do you mean the patch at:
> > http://www.x86-64.org/lists/discuss/msg07297.html ?
> > Unfortunately it interferes with the current swsusp code, which uses
> > init_level4_pgt anyway.
> > 
> > Could we please treat my patch as a (very much needed) urgent bugfix
> > and make the whole swsusp code in line with the Suresh's patch later on?
> > 
> > Suresh, could you please say what you think of it?
> 
> My patch as such shouldn't change the behavior of the existing swsup
> code. I am making only boot_level4_pgt as initdata. But not the 
> init_level4_pgt.

Suresh, unfortunately the kernel does not boot with your patch, because
it clears init_level4_pgt.  I think the patch that follows should be applied on
top of it.

If I am right, than your patch does not conflict with mine (just tested).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git7/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.14-rc2-git7.orig/arch/x86_64/mm/init.c	2005-09-29 22:13:34.000000000 +0200
+++ linux-2.6.14-rc2-git7/arch/x86_64/mm/init.c	2005-09-29 22:13:55.000000000 +0200
@@ -313,7 +313,7 @@
 void __cpuinit zap_low_mappings(int cpu)
 {
 	if (cpu == 0) {
-		pgd_t *pgd = pgd_offset_k(0UL);
+		pgd_t *pgd = boot_level4_pgt;
 		pgd_clear(pgd);
 	} else {
 		/*
Index: linux-2.6.14-rc2-git7/include/asm-x86_64/proto.h
===================================================================
--- linux-2.6.14-rc2-git7.orig/include/asm-x86_64/proto.h	2005-09-21 11:04:24.000000000 +0200
+++ linux-2.6.14-rc2-git7/include/asm-x86_64/proto.h	2005-09-29 22:22:19.000000000 +0200
@@ -22,6 +22,7 @@
 #define mtrr_bp_init() do {} while (0)
 #endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
+extern void zap_low_mappings(int cpu);
 
 extern void system_call(void); 
 extern int kernel_syscall(void);
