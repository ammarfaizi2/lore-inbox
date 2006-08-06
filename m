Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWHFHPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWHFHPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWHFHPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:15:45 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:10714 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751067AbWHFHPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:15:44 -0400
Date: Sun, 6 Aug 2006 03:11:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Dave Jones <davej@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <200608060314_MC3-1-C73C-AEAE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608060805.06821.ak@suse.de>

On Sun, 6 Aug 2006 08:05:06 +0200, Andi Kleen wrote:

> Hmm, actually I applied it but then I had doubts it actually 
> works -- I think you don't need _stext but the code before
> the first call in head. Since head.S doesn't do a call
> that's probably start_kernel

But head.S does do a call (on i386 but not x86_64 AFAICT):

| #ifdef CONFIG_SMP
|        movb ready, %cl
|        movb $1, ready
|        cmpb $0,%cl
|        je 1f                   # the first CPU calls start_kernel
|                                # all other CPUs call initialize_secondary
|        call initialize_secondary
|        jmp L6
| 1:
| #endif /* CONFIG_SMP */
|        call start_kernel
| L6:
|        jmp L6                  # main should never return here, but
|                                # just in case, we know what happens.

And the backtraces I saw ended up at L6:

| DWARF2 unwinder stuck at 0xc0100210

System.map on i386 SMP says:

| c0100210 t L6

-- 
Chuck

