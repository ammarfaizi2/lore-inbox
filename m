Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVAXRyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVAXRyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVAXRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:54:17 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:7335 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261552AbVAXRxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:53:38 -0500
Date: Mon, 24 Jan 2005 16:11:13 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.11-rc2-mm1 [compile fix]
Message-ID: <20050124151113.GA12312@ens-lyon.fr>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
> - Lots of updates and fixes all over the place.
> 
> 
> Changes since 2.6.11-rc1-mm2:
> 
> [snip]
> 
> +kernel-forkc-make-mm_cachep-static.patch
> 
>  Little fixes.
> 
>
It breaks compilation with gcc-4.0

kernel/fork.c:1249: error: static declaration of ‘mm_cachep’ follows non-static declaration
include/linux/slab.h:117: error: previous declaration of ‘mm_cachep’ was here
make[1]: *** [kernel/fork.o] Error 1
make: *** [kernel] Error 2

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux/include/linux/slab.h	2005-01-24 11:36:33.000000000 +0100
+++ linux/include/linux/slab.h.new	2005-01-24 12:24:46.000000000 +0100
@@ -114,7 +114,6 @@ extern int FASTCALL(kmem_ptr_validate(km
 
 /* System wide caches */
 extern kmem_cache_t	*vm_area_cachep;
-extern kmem_cache_t	*mm_cachep;
 extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
--- linux-clean/kernel/fork.c	2005-01-24 12:44:48.000000000 +0100
+++ linux/kernel/fork.c	2005-01-24 12:38:27.000000000 +0100
@@ -81,6 +81,24 @@ int nr_processes(void)
 static kmem_cache_t *task_struct_cachep;
 #endif
 
+/* SLAB cache for signal_struct structures (tsk->signal) */
+kmem_cache_t *signal_cachep;
+
+/* SLAB cache for sighand_struct structures (tsk->sighand) */
+kmem_cache_t *sighand_cachep;
+
+/* SLAB cache for files_struct structures (tsk->files) */
+kmem_cache_t *files_cachep;
+
+/* SLAB cache for fs_struct structures (tsk->fs) */
+kmem_cache_t *fs_cachep;
+
+/* SLAB cache for vm_area_struct structures */
+kmem_cache_t *vm_area_cachep;
+
+/* SLAB cache for mm_struct structures (tsk->mm) */
+static kmem_cache_t *mm_cachep;
+
 void free_task(struct task_struct *tsk)
 {
 	free_thread_info(tsk->thread_info);
@@ -1230,24 +1248,6 @@ long do_fork(unsigned long clone_flags,
 	return pid;
 }
 
-/* SLAB cache for signal_struct structures (tsk->signal) */
-kmem_cache_t *signal_cachep;
-
-/* SLAB cache for sighand_struct structures (tsk->sighand) */
-kmem_cache_t *sighand_cachep;
-
-/* SLAB cache for files_struct structures (tsk->files) */
-kmem_cache_t *files_cachep;
-
-/* SLAB cache for fs_struct structures (tsk->fs) */
-kmem_cache_t *fs_cachep;
-
-/* SLAB cache for vm_area_struct structures */
-kmem_cache_t *vm_area_cachep;
-
-/* SLAB cache for mm_struct structures (tsk->mm) */
-static kmem_cache_t *mm_cachep;
-
 void __init proc_caches_init(void)
 {
 	sighand_cachep = kmem_cache_create("sighand_cache",

