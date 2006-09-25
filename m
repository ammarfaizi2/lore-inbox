Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWIYPrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWIYPrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWIYPrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:47:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18886 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751032AbWIYPrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:47:24 -0400
Date: Mon, 25 Sep 2006 17:39:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060925153949.GA10285@elte.hu>
References: <200609251123_MC3-1-CC21-A7D1@compuserve.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <200609251123_MC3-1-CC21-A7D1@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Chuck,

i cannot email you because the mail always bounces ...

the kprobes benchmark is a simple "NOP" function:

 static int counter = 0;

 static int probe_pre_handler (struct kprobe * kp,
                               struct pt_regs * regs)
 {
         counter++;
         return 0;
 }

i've attached it.

	Ingo

* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060918151713.GA11495@elte.hu>
> 
> On Mon, 18 Sep 2006 17:17:13 +0200, Ingo Molnar wrote:
> 
> > yeah - and i dont think the kprobes overhead is a fundamental thing - i 
> > posted a few kprobes-speedup patches as a reply to your measurements.
> 
> Where is the source code for the kprobes benchmarks you used?
> 
> -- 
> Chuck

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="noop_kprobe.c"

/*
 * no-op kprobe handler
 * Copyright (c) 2005 Hitachi,Ltd.,
 * Created by Masami Hiramatsu<hiramatu@sdl.hitachi.co.jp>
 */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/kprobes.h>

MODULE_AUTHOR("M.Hiramatsu");
MODULE_LICENSE("GPL");

static unsigned long addr = 0;
module_param(addr, ulong, 0444);

static struct kprobe kp;
static int counter=0;

static int probe_pre_handler (struct kprobe * kp,
			      struct pt_regs * regs)
{
	counter++;
	return 0;
}

static int install_probe(void) 
{
	int ret = -10000;
	if (addr) {
		kp.pre_handler = probe_pre_handler;
		kp.addr = (void *)addr;
		printk("probe install to %p\n", (void*)addr);
		ret = register_kprobe(&kp);
	}
	if (ret) {
		printk("probe install error: %d\n",ret);
	}
	return ret;
}

static void uninstall_probe(void)
{
	if (kp.addr) {
		printk("uninstall from %p\n", (void*)kp.addr);
		unregister_kprobe(&kp);
	}
	printk("count:%d\n",counter);
}

module_init(install_probe);
module_exit(uninstall_probe);

--2fHTh5uZTiUOsy+g--
