Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUHKQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUHKQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHKQj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:39:57 -0400
Received: from zero.aec.at ([193.170.194.10]:13061 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268122AbUHKQgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:36:40 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [3/4] Jumper Probes patch to provide function arguments
References: <2s3ZE-7Zq-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 11 Aug 2004 18:36:33 +0200
In-Reply-To: <2s3ZE-7Zq-29@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Wed, 11 Aug 2004 18:20:10 +0200")
Message-ID: <m3brhh4ooe.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

+void jprobe_return(void)
+{
+	preempt_enable_no_resched();
+	asm volatile ("       xchgl   %%ebx,%%esp     \n"
+		      "       int3			\n"::"b"
+		      (jprobe_saved_esp):"memory");
+}

whatever the preempt disable is protecting against, why isn't it a 
problem during the xchgl ? 

> +#define MAX_STACK_SIZE 64
> +#define MIN_STACK_SIZE(ADDR) ((((ADDR) + MAX_STACK_SIZE) <  \
> +	(((ADDR) & PAGE_MASK) + PAGE_SIZE) ? ((ADDR) + MAX_STACK_SIZE) \
> +	: (((ADDR) & PAGE_MASK) + PAGE_SIZE )) - (ADDR))

What is this macro doing exactly? 

If it is an attempt to not read beyond the kernel stack top  i think
it is wrong. It will also randomly fail on 8k stacks at top-4K 

Use something like

max_t(unsigned long,MAX_STACK_SIZE, current_thread_info() + THREAD_SIZE - addr)


The rest looks ok.

-Andi

