Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUKAQsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUKAQsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277845AbUKAQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:48:15 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:3820 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S270491AbUKAQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:47:06 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] user-defined profiling
Date: Tue, 2 Nov 2004 01:49:29 +0900
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
References: <200411020133.53562.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200411020133.53562.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411020149.29505.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 01:33, Akinobu Mita wrote:

> Furthermore I much prefer to insert the user-defined profile point
> with Kprobe. This is why the profile_hits() was exported.

I am using this kernel module to insert user-defined profiling.

$ insmod usrprof.ko probe=<address>


#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/profile.h>
#include <linux/kprobes.h>

#if !defined(__i386__) || !defined(CONFIG_FRAME_POINTER)
#error not supported
#endif

/* copied from arch/i386/traps.c */

static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
{
	return  p > (void *)tinfo &&
		p < (void *)tinfo + THREAD_SIZE - 3;
}

int pre_handler(struct kprobe *p, struct pt_regs *regs) {
	unsigned long ebp = regs->ebp;
	unsigned long addr = ~0UL;
	struct thread_info *context = (struct thread_info *)
		(regs->esp & (~(THREAD_SIZE - 1)));

	if (valid_stack_ptr(context, (void *)ebp))
		addr = *(unsigned long *)(ebp + 4);
		
	profile_hit(USR_PROFILING, (void *)addr);

	return 0;
}

static struct kprobe kp = {
	.pre_handler	= pre_handler,
};

static long probe;
module_param(probe, long, 0);

static int __init init_usrprof(void)
{
	if (!probe) {
		printk(KERN_ERR "%lx: invalid address\n", probe);
		return 1;
	}
	kp.addr = (void *)probe;
	register_kprobe(&kp);
	return 0;
}

static void __exit cleanup_usrprof(void)
{
	unregister_kprobe(&kp);
}

module_init(init_usrprof);
module_exit(cleanup_usrprof);

MODULE_LICENSE("GPL");



