Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVAVJDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVAVJDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 04:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVAVJDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 04:03:17 -0500
Received: from ozlabs.org ([203.10.76.45]:20611 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262684AbVAVJDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 04:03:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16882.5835.468874.683779@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 20:03:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] PPC: fix stack alignment for signal handlers
In-Reply-To: <200501220756.j0M7u06B021617@magilla.sf.frob.com>
References: <200501220756.j0M7u06B021617@magilla.sf.frob.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath writes:

> For PPC32 signal handlers, while the frame itself was of properly aligned
> size, no alignment of the starting stack pointer was done at all, so that a
> signal handler can still get a misaligned stack pointer if the interrupted
> registers had one, though the kernel isn't gratuitously misaligning good
> ones like it is for PPC64.  I added explicit alignment to fix that.

This part is unnecessary, because arch/ppc/kernel/signal.c:do_signal()
already aligns the stack pointer to a 16-byte boundary:

        if ((ka.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
            && !on_sig_stack(regs->gpr[1]))
                newsp = current->sas_ss_sp + current->sas_ss_size;
        else
                newsp = regs->gpr[1];
        newsp &= ~0xfUL;

        /* Whee!  Actually deliver the signal.  */
        if (ka.sa.sa_flags & SA_SIGINFO)
                handle_rt_signal(signr, &ka, &info, oldset, regs, newsp);
        else
                handle_signal(signr, &ka, &info, oldset, regs, newsp);

The additions to arch/ppc64/kernel/signal32.c are likewise
unnecessary, because do_signal32() also does newsp &= ~0xfUL (in fact
the code there is very similar to the ppc32 code).

You are correct about the 64-bit case though.  I thought we had fixed
that but evidently not.  Your patch looks fine as far as
arch/ppc64/kernel/signal.c is concerned.

Regards,
Paul.
