Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDRBNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 21:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDRBNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 21:13:01 -0400
Received: from dp.samba.org ([66.70.73.150]:36763 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262689AbTDRBM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 21:12:59 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16031.13262.665030.500906@nanango.paulus.ozlabs.org>
Date: Fri, 18 Apr 2003 09:07:58 +1000 (EST)
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Paul Larson <plars@linuxtestproject.org>,
       ltp-coverage@lists.sourceforge.net,
       lse-tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Ltp-coverage] 2.5.67-gcov and 2.4.20-gcov
In-Reply-To: <20030417123111.GA29390@wohnheim.fh-wedel.de>
References: <1050502803.8637.1094.camel@plars>
	<20030416164440.GB2305@wohnheim.fh-wedel.de>
	<1050511870.10732.1277.camel@plars>
	<20030417123111.GA29390@wohnheim.fh-wedel.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=81=F6rn?= Engel writes:

> The bit in arch/ppc/kernel/entry.S was necessary for me to compile
> this for a ppc 405gp based system, gcov would grow the kernel beyond
> the relative jump distance for "bnel syscall_trace".
> 
> Paulus, Ben, is the relative jump a wanted optimization or unclean
> code that went unnoticed so far? IOW should this go into mainline or
> remain part of the gcov patch?

What's unclean about bnel?

I think ret_from_fork would be better like this:

	.globl	ret_from_fork
ret_from_fork:
	bl	schedule_tail
	lwz	r0,TASK_PTRACE(r2)
	andi.	r0,r0,PT_TRACESYS
	beq+	ret_from_except
	bl	syscall_trace
	b	ret_from_except

Unless of course you have bloated the kernel beyond 32MB, but then we
would be in all sorts of difficulties.

> +.section ".ctors","aw"
> +.globl  __CTOR_LIST__
> +.type   __CTOR_LIST__,@object
> +__CTOR_LIST__:
> +.section ".dtors","aw"
> +.globl  __DTOR_LIST__
> +.type   __DTOR_LIST__,@object
> +__DTOR_LIST__:

Can't you do this in arch/ppc/vmlinux.lds using PROVIDE() instead of
making the same change to each of the head*.S files?

Paul.
