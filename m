Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVGGK2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVGGK2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVGGK2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:28:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbVGGK0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:26:51 -0400
Date: Thu, 7 Jul 2005 03:25:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: prasanna@in.ibm.com
Cc: ak@suse.de, davem@davemloft.net, systemtap@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/6 PATCH] Kprobes : Prevent possible race conditions generic
 changes
Message-Id: <20050707032537.7588acb9.akpm@osdl.org>
In-Reply-To: <20050707101015.GE12106@in.ibm.com>
References: <20050707101015.GE12106@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> There are possible race conditions if probes are placed on routines within the
> kprobes files and routines used by the kprobes.

So...  don't do that then?  Is it likely that anyone would want to stick a
probe on the kprobe code itself?

> -kprobe_opcode_t *get_insn_slot(void)
> +kprobe_opcode_t * __kprobes get_insn_slot(void)

coding style regression...

> -int register_kprobe(struct kprobe *p)
> +static int __kprobes in_kprobes_functions(unsigned long addr)
> +{
> +	/* Linker adds these: start and end of __kprobes functions */
> +	extern char __kprobes_text_start[], __kprobes_text_end[];

There's an old unix convention that section markers (start, end, edata,
etc) are declared `int'.  For some reason we don't do that in the kernel. 
Oh well.

> +	if ((ret = in_kprobes_functions((unsigned long) p->addr)) !=0)

whitespace broke.

Some people don't like the assign-then-test-it style.

> +		return ret;
>  	if ((ret = arch_prepare_kprobe(p)) != 0) {
>  		goto rm_kprobe;
>  	}

hm, who put the unneeded braces in there?

> --- linux-2.6.13-rc1-mm1/include/linux/kprobes.h~kprobes-exclude-functions-generic	2005-07-06 18:51:16.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/include/linux/kprobes.h	2005-07-06 18:51:16.000000000 +0530
> @@ -42,6 +42,10 @@
>  #define KPROBE_REENTER		0x00000004
>  #define KPROBE_HIT_SSDONE	0x00000008
>  
> +/* Attach to insert probes on any functions which should be ignored*/
> +#define __kprobes	__attribute__((__section__(".kprobes.text")))
> +/* Is this address in the __kprobes functions? */
> +

What's that comment mean?


