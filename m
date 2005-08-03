Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVHCKsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVHCKsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVHCKsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:48:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8896 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262206AbVHCKsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:48:10 -0400
Date: Wed, 3 Aug 2005 12:48:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Subject: Re: [Question] arch-independent way to differentiate between user and kernel
Message-ID: <20050803104856.GA10118@elte.hu>
References: <1122931238.4623.17.camel@dhcp153.mvista.com> <1122944010.6759.64.camel@localhost.localdomain> <20050802101920.GA25759@elte.hu> <1123011928.1590.43.camel@localhost.localdomain> <1123025895.25712.7.camel@dhcp153.mvista.com> <1123027226.1590.59.camel@localhost.localdomain> <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123036936.1590.69.camel@localhost.localdomain> <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123065472.1590.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123065472.1590.84.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi all,
> 
> I'm dealing with a problem where I want to know from __do_IRQ in 
> kernel/irq/handle.c if the interrupt occurred while the process was in 
> user space or kernel space.  But the trick here is that it must work 
> on all architectures.
> 
> Does anyone know of some way that that function can tell if it had 
> interrupted the kernel or user space?  I know of serveral 
> arch-dependent ways, but that's not acceptable right now.

i dont think there's any. user_mode(regs) gets the closest - it might 
make sense to generalize it over all arches.

update_process_times() gets an arch-independent 'was the tick user-space 
or kernel-space' flag, so the best starting point would be to look at 
the output of:

 for N in `find . -name '*.c' | xargs grep update_process_times |
  grep arch`; do echo $N; done | grep update_process_times |
   sort | uniq -c

which gives:

      2 update_process_times()
      1 update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)),
      6 update_process_times(user);
      1 update_process_times(user_mode(fp));
     33 update_process_times(user_mode(regs));
      2 update_process_times(user_mode_vm(regs));

so ~33 calls use user_mode(regs), and the rest needs to be reviewed and 
possibly changed. Looks doable.

	Ingo
