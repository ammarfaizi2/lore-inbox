Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVDWKLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVDWKLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDWKLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 06:11:39 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:22000 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261529AbVDWKLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 06:11:36 -0400
Date: Sat, 23 Apr 2005 12:12:51 +0200
From: Juergen Quade <quade@hsnr.de>
To: linux-kernel@vger.kernel.org
Cc: quade@hsnr.de
Subject: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050423101251.GA327@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing around with kprobe I noticed, that "kprobing"
the function "do_gettimeofday" completly freezes the
system (2.6.12-rc3). Other functions like "do_fork" or
"do_settimeofday" are doing well.

Does anybody know the reason for it?

           Juergen.

=================================
// BEWARE: THIS CODE MAY FREEZE YOUR SYSTEM
#include <linux/module.h>
#include <linux/kprobes.h>
#include <linux/kallsyms.h>

static int call_count = 0;

static int pre_probe(struct kprobe *p, struct pt_regs *regs)
{
	++call_count;
	return 0;
}

static struct kprobe kp = {
	.pre_handler = pre_probe,
	.post_handler = NULL,
	.fault_handler = NULL,
	.addr = (kprobe_opcode_t *) NULL,
};

static int __init probe_init(void)
{
	kp.addr = (kprobe_opcode_t *) kallsyms_lookup_name("do_gettimeofday");

	if (kp.addr == NULL) {
		printk("kallsyms_lookup_name could not find address"
			"for the specified symbol name\n");
		return 1;
	}
	register_kprobe(&kp);
	printk("kprobe registered address %p\n", kp.addr);
	return 0;
}

static void __exit probe_exit(void)
{
  unregister_kprobe(&kp);
  printk("do_gettimeofday() called %d times.\n", call_count);
}

module_init( probe_init );
module_exit( probe_exit );
MODULE_LICENSE("GPL");
