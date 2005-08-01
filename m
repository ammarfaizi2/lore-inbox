Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVHAF3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVHAF3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVHAF3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:29:09 -0400
Received: from ozlabs.org ([203.10.76.45]:9167 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262338AbVHAF1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:27:19 -0400
Subject: Re: percpu_modalloc oops when loading netfilter modules
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <42EAC06A.5080807@gentoo.org>
References: <42EAC06A.5080807@gentoo.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 15:27:17 +1000
Message-Id: <1122874037.7496.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 00:48 +0100, Daniel Drake wrote:
> Pete, Rusty,
> 
> I found a snippet of a previous discussion of yours here:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/2901.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0768.html
> 
> Did anything become of this issue?
> 
> A Gentoo user has reported what appears to be the same problem on 2.6.12:
> http://bugs.gentoo.org/show_bug.cgi?id=97006

Name: Module per-cpu alignment cannot always be met.
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)

The module code assumes noone will ever ask for a per-cpu area more
than SMP_CACHE_BYTES aligned.  However, as these cases show, gcc asks
sometimes asks for 32-byte alignment for the per-cpu section on a
module, and if CONFIG_X86_L1_CACHE_SHIFT is 4, we hit that BUG_ON().
This is obviously an unusual combination, as there have been few
reports, but better to warn than die.

See:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0768.html

And more recently:
	http://bugs.gentoo.org/show_bug.cgi?id=97006

Index: linux-2.6.13-rc4-git3-Netfilter/kernel/module.c
===================================================================
--- linux-2.6.13-rc4-git3-Netfilter.orig/kernel/module.c	2005-08-01 14:58:44.000000000 +1000
+++ linux-2.6.13-rc4-git3-Netfilter/kernel/module.c	2005-08-01 15:21:30.000000000 +1000
@@ -250,13 +250,18 @@
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
@@ -348,7 +353,8 @@
 }	
 __initcall(percpu_modinit);
 #else /* ... !CONFIG_SMP */
-static inline void *percpu_modalloc(unsigned long size, unsigned long align)
+static inline void *percpu_modalloc(unsigned long size, unsigned long align,
+				    const char *name)
 {
 	return NULL;
 }
@@ -1644,7 +1650,8 @@
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
A bad analogy is like a leaky screwdriver -- Richard Braakman

