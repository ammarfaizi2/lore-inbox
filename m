Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVHKW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVHKW6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVHKW6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:58:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932468AbVHKW6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:58:19 -0400
Message-Id: <20050811225649.386948000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, rusty@rustcorp.com.au,
       Daniel Drake <dsd@gentoo.org>, Chris Wright <chrisw@osdl.org>
Subject: [patch 8/8] [PATCH] Module per-cpu alignment cannot always be met
Content-Disposition: inline; filename=module-per-cpu-alignment-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------


The module code assumes noone will ever ask for a per-cpu area more than
SMP_CACHE_BYTES aligned.  However, as these cases show, gcc asks sometimes
asks for 32-byte alignment for the per-cpu section on a module, and if
CONFIG_X86_L1_CACHE_SHIFT is 4, we hit that BUG_ON().  This is obviously an
unusual combination, as there have been few reports, but better to warn
than die.

See:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0768.html
  
And more recently:
	http://bugs.gentoo.org/show_bug.cgi?id=97006
  
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 kernel/module.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-2.6.12.y/kernel/module.c
===================================================================
--- linux-2.6.12.y.orig/kernel/module.c
+++ linux-2.6.12.y/kernel/module.c
@@ -249,13 +249,18 @@ static inline unsigned int block_size(in
 /* Created by linker magic */
 extern char __per_cpu_start[], __per_cpu_end[];
 
-static void *percpu_modalloc(unsigned long size, unsigned long align)
+static void *percpu_modalloc(unsigned long size, unsigned long align,
+			     const char *name)
 {
 	unsigned long extra;
 	unsigned int i;
 	void *ptr;
 
-	BUG_ON(align > SMP_CACHE_BYTES);
+	if (align > SMP_CACHE_BYTES) {
+		printk(KERN_WARNING "%s: per-cpu alignment %li > %i\n",
+		       name, align, SMP_CACHE_BYTES);
+		align = SMP_CACHE_BYTES;
+	}
 
 	ptr = __per_cpu_start;
 	for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
@@ -347,7 +352,8 @@ static int percpu_modinit(void)
 }	
 __initcall(percpu_modinit);
 #else /* ... !CONFIG_SMP */
-static inline void *percpu_modalloc(unsigned long size, unsigned long align)
+static inline void *percpu_modalloc(unsigned long size, unsigned long align,
+				    const char *name)
 {
 	return NULL;
 }
@@ -1554,7 +1560,8 @@ static struct module *load_module(void _
 	if (pcpuindex) {
 		/* We have a special allocation for this section. */
 		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
-					 sechdrs[pcpuindex].sh_addralign);
+					 sechdrs[pcpuindex].sh_addralign,
+					 mod->name);
 		if (!percpu) {
 			err = -ENOMEM;
 			goto free_mod;

--
