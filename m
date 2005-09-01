Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVIAVHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVIAVHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIAVHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:07:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030373AbVIAVHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:07:19 -0400
Date: Thu, 1 Sep 2005 14:09:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [PATCH]kprobes fix bug when probed on task and isr functions
Message-Id: <20050901140938.69909683.akpm@osdl.org>
In-Reply-To: <20050901134937.A29041@unix-os.sc.intel.com>
References: <20050901134937.A29041@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
>
> 	This patch fixes a race condition where in system used to hang
> or sometime crash within minutes when kprobes are inserted on 
> ISR routine and a task routine.

It's desirable that the patch descriptions tell us _how_ a bug was fixed,
as well as what the bug was.  It means that people don't have to ask
questions like:

>  void __kprobes lock_kprobes(void)
>  {
> +	unsigned long flags = 0;
> +
> +	local_irq_save(flags);
>  	spin_lock(&kprobe_lock);
>  	kprobe_cpu = smp_processor_id();
> + 	local_irq_restore(flags);
>  }

what is this change trying to do?  If a lock is taken from both process and
irq contexts then local IRQs must be disabled for the entire period when the
lock is held, not just for a little blip like this.  If IRQ-context code is
running this function then the code is deadlockable.

Now, probably there's deep magic happening here and I'm wrong.  If so then
please explain the code's magic via a comment patch so the question doesn't
arise again, thanks.

