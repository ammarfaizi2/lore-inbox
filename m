Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVCWMEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVCWMEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCWMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:04:24 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:57300 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261401AbVCWMEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:04:21 -0500
Date: Wed, 23 Mar 2005 13:04:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: bstroesser@fujitsu-siemens.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: S390: bug in signal frame set up when using SA_ONSTACK
Message-ID: <20050323120436.GA4577@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bodo,

> If a signal handler is set to use the signal stack (SA_ONSTACK), but
> the signal stack is disabled, the signal frame should be written to
> the current stack without stack switching.
> S390 doesn't note, that the signal stack is disabled, so it does
> stack switching to a stack at 0, size 0. Then it writes the
> signal frame
> to "0x00000000 - sizeof(sigframe)".
> If a further signal comes in, while the handler is running, the next
> signal frame even will overwrite the previous one.

Yes, that's a bug that needs fixing

> The reason for the bug is get_sigframe() using on_sig_stack() instead
> of sas_ss_flags(), which would be ok. (Oneliner patch attached)

and sas_ss_flags is the correct fix for it. Patch is fine.

> AFAICS, the problem is in 2.4 and 2.6 kernels.

Ok, I need to check our 2.4 repository.

> If the error occurs, bit 0 of stack pointer gpr15 is set. In
> arch/s390/kernel/signal.c, there is no masking of gpr15 before passing
> it to do_sigaltstack() or on_sig_stack()/sas_ss_flags().  Wouldn't it
> be better to reset bit 0, to avoid possible problems?

I don't think so. The problem starts with an invalid stack pointer,
masking bit 2^31 from %r15 doesn't make it valid. It's the subtraction
of sizeof(sigframe) that makes the value in %r15 negative / sets the
high order bit. The content of register %r15 for normal program
execution is an address without bit 2^31, both in kernel and user space.
While it is true that bit 2^31 gets ignored by the processor in 31 bit
mode, nobody should set the bit in %r15. The address with the bit set
isn't a valid stack address anymore. A process that deliberatly set
the bit deserves to get killed for it, the important things is that the
kernel doesn't get into trouble because of it.

blue skies,
  Martin.

