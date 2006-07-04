Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWGDVWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWGDVWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWGDVWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:22:12 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:23197 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751089AbWGDVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:22:11 -0400
Date: Tue, 4 Jul 2006 17:19:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap
  in ctxsw
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607041719_MC3-1-C420-EC5A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060704072939.GC5902@frankl.hpl.hp.com>

On Tue, 4 Jul 2006 00:29:39 -0700, Stephane Eranian wrote:

> Following my discussion with Andi. Here is a patch that introduces
> two new TIF flags to simplify the context switch code in __switch_to().
> The idea is to minimize the number of cache lines accessed in the common
> case, i.e., when neither the debug registers nor the I/O bitmap are used.

I get a 5-10% speedup in task switch times with this patch.
Some very minor comments:


> <signed-off-by>: eranian@hpl.hp.com

Should be: Signed-off-by: Stephane Eranian <eranian@hpl.hp.com>


> +	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP) == 0) {

preferred:

	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {


> @@ -674,18 +692,9 @@ struct task_struct fastcall * __switch_t
>  	/*
>  	 * Now maybe reload the debug registers
>  	 */

 	/*
 	 * Now maybe reload the debug registers and/or IO bitmap
 	 */


And this should be added to the patch:

--- 2.6.17-nb.orig/arch/i386/kernel/process.c
+++ 2.6.17-nb/arch/i386/kernel/process.c
@@ -360,13 +360,12 @@ EXPORT_SYMBOL(kernel_thread);
  */
 void exit_thread(void)
 {
-	struct task_struct *tsk = current;
-	struct thread_struct *t = &tsk->thread;
-
 	/* The process may have allocated an io port bitmap... nuke it. */
-	if (unlikely(NULL != t->io_bitmap_ptr)) {
+	if (unlikely(test_thread_flag(TIF_IO_BITMAP))) {
 		int cpu = get_cpu();
 		struct tss_struct *tss = &per_cpu(init_tss, cpu);
+		struct task_struct *tsk = current;
+		struct thread_struct *t = &tsk->thread;
 
 		kfree(t->io_bitmap_ptr);
 		t->io_bitmap_ptr = NULL;
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
