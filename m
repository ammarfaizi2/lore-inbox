Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWJBUZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWJBUZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWJBUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:25:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964974AbWJBUZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:25:10 -0400
Date: Mon, 2 Oct 2006 13:21:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
Message-Id: <20061002132116.2663d7a3.akpm@osdl.org>
In-Reply-To: <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 17:21:09 +0100
David Howells <dhowells@redhat.com> wrote:

> Maintain a per-CPU global "struct pt_regs *" variable which can be used instead
> of passing regs around manually through all ~1800 interrupt handlers in the
> Linux kernel.
>
> ...
>
>  1086 files changed, 2634 insertions(+), 2968 deletions(-)
>

heh.

It's presumably too large a lump for vger to swallow so I put a copy at
http://userweb.kernel.org/~akpm/irq-maintain-regs-pointer-globally-rather-than-passing-to-irq-handlers.patch

I disagree with the implementation of get_irq_regs() and set_irq_regs():

+DECLARE_PER_CPU(struct pt_regs *, __irq_regs);
+
+static inline struct pt_regs *get_irq_regs(void)
+{
+	struct pt_regs *regs = get_cpu_var(__irq_regs);
+	put_cpu_var(__irq_regs);
+	return regs;
+}
+
+#define irq_regs (get_irq_regs())
+
+static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
+{
+	struct pt_regs *old_regs, **pp_regs = &get_cpu_var(__irq_regs);
+
+	old_regs = *pp_regs;
+	*pp_regs = new_regs;
+	put_cpu_var(__irq_regs);
+	return old_regs;
+}

These should just use __get_cpu_var().  If someone calls these from
preemptible code, they're already buggy, because they now have a pointer to
possibly-another-cpus registers.  Using get_cpu_var() simply covers that
bug up.

And could we please remove the irq_regs macro?  It's only used in three
places so simply open-coding that is simpler.


Patches #1 and #2 don't come vaguely close to applying on top of all the
IRQ changes we still have queued for 2.6.19 so that will need redoing
please.  I'd expect to have that lot sent Linuswards around 48 hours from
now.

I think the change is good.  But I don't want to maintain this whopper
out-of-tree for two months!  If we want to do this, we should just smash it
in and grit our teeth.  But I am a bit concerned about the non-x86
architectures.  I assume they'll continue to compile-and-work?

What does Ingo think?

> Some notes on the interrupt handling in the drivers:
> 
>  (*) input_dev() is now gone entirely.  The regs pointer is no longer stored in
>      the input_dev struct.
> 
>  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
>      something different depending on whether it's been supplied with a regs
>      pointer or not.
> 
>  (*) Various IRQ handler function pointers have been moved to type
>      irq_handler_t.
> 

Cc's added.
