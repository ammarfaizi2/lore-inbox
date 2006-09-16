Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWIPW5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWIPW5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWIPW5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:57:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbWIPW5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:57:45 -0400
Date: Sat, 16 Sep 2006 15:56:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-Id: <20060916155657.a233b54d.akpm@osdl.org>
In-Reply-To: <20060916204342.GA5208@elte.hu>
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home>
	<20060915200559.GB30459@elte.hu>
	<20060915202233.GA23318@Krystal>
	<450BCAF1.2030205@sgi.com>
	<20060916172419.GA15427@Krystal>
	<20060916173552.GA7362@elte.hu>
	<20060916175606.GA2837@Krystal>
	<20060916191043.GA22558@elte.hu>
	<20060916193745.GA29022@elte.hu>
	<20060916202939.GA4520@elte.hu>
	<20060916204342.GA5208@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 22:43:42 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> --- linux.orig/arch/i386/kernel/kprobes.c
> +++ linux/arch/i386/kernel/kprobes.c
> @@ -354,9 +354,8 @@ no_kprobe:
>   */
>  fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
>  {
> -        struct kretprobe_instance *ri = NULL;
> -        struct hlist_head *head;
> -        struct hlist_node *node, *tmp;
> +        struct kretprobe_instance *ri = NULL, *tmp;
> +        struct list_head *head;
>  	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;

Wanna fix the whitespace wreckage while you're there??

i386's kprobe_handler() appears to forget to reenable preemption in the
if (p->pre_handler && p->pre_handler(p, regs)) case?
