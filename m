Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUDALfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUDALfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:35:37 -0500
Received: from holomorphy.com ([207.189.100.168]:13229 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262864AbUDALff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:35:35 -0500
Date: Thu, 1 Apr 2004 03:35:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: fix get_wchan() FIXME wrt. order of functions
Message-ID: <20040401113532.GC791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040401095526.GB791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401095526.GB791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 01:55:26AM -0800, William Lee Irwin III wrote:
> This addresses the issue with get_wchan() that the various functions
> acting as scheduling-related primitives are not, in fact, contiguous
> in the text segment. It creates an ELF section for scheduling primitives
> to be placed in, and places currently-detected (i.e. skipped during stack
> decoding) scheduling primitives and others like io_schedule() and down(),
> which are currently missed by get_wchan() code, into this section also.
> The net effects are more reliability of get_wchan()'s results and the
> new ability, made use of by this code, to arbitrarily place scheduling
> primitives in the source code without disturbing get_wchan()'s accuracy.
> Suggestions by Arnd Bergmann and Matthew Wilcox regarding reducing the
> invasiveness of the patch were incorporated during prior rounds of review.
> I've at least tried to sweep all arches in this patch.
> vs. 2.6.5-rc3. Rediffing vs. -mm would be easy for me.

Brown paper bag patch. Should fix the missing relocations you saw.


Index: sched-2.6.5-rc3/arch/i386/kernel/semaphore.c
===================================================================
--- sched-2.6.5-rc3.orig/arch/i386/kernel/semaphore.c	2004-03-31 18:34:02.000000000 -0800
+++ sched-2.6.5-rc3/arch/i386/kernel/semaphore.c	2004-04-01 03:13:48.000000000 -0800
@@ -188,7 +188,7 @@
  * value..
  */
 asm(
-".section sched.text\n"
+".section .sched.text\n"
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
