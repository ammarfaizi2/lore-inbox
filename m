Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270604AbTGNRfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270446AbTGNRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:35:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26520 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270765AbTGNRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:32:29 -0400
Date: Mon, 14 Jul 2003 13:45:55 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714134555.O15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com> <20030715025252.17ec8d6f.sfr@canb.auug.org.au> <20030714130024.M15481@devserv.devel.redhat.com> <20030715031123.5c8e0c96.sfr@canb.auug.org.au> <20030714131400.N15481@devserv.devel.redhat.com> <20030715032552.672d21ea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030715032552.672d21ea.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Tue, Jul 15, 2003 at 03:25:52AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 03:25:52AM +1000, Stephen Rothwell wrote:
> > Then that pad needs to be #ifdef __s390x__ as well.
> 
> But why pad at all since we have now increased the size of the siginfo
> structure in the 64bit case (maybe I am being thick as it is 3:25am here
> :-)).

Decreased, from 136 bytes when __ARCH_SI_PREAMBLE_SIZE is (3 * sizeof(int))
to 128 bytes with (4 * sizeof(int)).
The pad in rt_sigframe is certainly open for discussion. GCC does on s390x:
        struct ucontext_                                                \
          {                                                             \
            unsigned long     uc_flags;                                 \
            struct ucontext_ *uc_link;                                  \
            unsigned long     uc_stack[3];                              \
            sigregs_          uc_mcontext;                              \
          } *uc_ = (CONTEXT)->cfa + 8 + 128;                            \
                                                                        \
        regs_ = &uc_->uc_mcontext;                                      \
(128 stands for sizeof(siginfo_t)).
This means it does not work on any kernels so far, if we don't add a pad
to the kernel and just fix __ARCH_SI_PREAMBLE_SIZE on s390x, then GCC
will suddenly work with all newer kernels but will never work with older
kernels.
If pad is added to the kernel at the same time as __ARCH_SI_PREAMBLE_SIZE
is increased, it would need to be added to GCC as well, so older GCCs
would not work on any kernels while patched/newer GCCs would work on all
kernels.

	Jakub
