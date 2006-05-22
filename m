Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWEVLvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWEVLvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWEVLvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:43405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750772AbWEVLvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:16 -0400
To: "chaitanya Huilgol" <chaitanya@tidaldata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: cmpxchg hard lockup on AMD64 - ASUS(A8V-MX)
References: <007a01c67d75$b627b8e0$40c8720a@Everest>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:12:54 +0200
In-Reply-To: <007a01c67d75$b627b8e0$40c8720a@Everest>
Message-ID: <p73psi671op.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"chaitanya Huilgol" <chaitanya@tidaldata.com> writes:


> {
>         __asm__ __volatile__ (
>                 "# LFPUSH \n\t"
>                 "1:\t"
>                 "movl %2, (%1) \n"
>                 LOCK "cmpxchg %1, %0 \n\t"
>                 "jnz 1b \n\t"
>                 :
>                 :"m" (*lf), "r" (cl), "a" (lf->top)

You don't tell gcc *lf is modified.

>                 );
> }
> 
> cell* pop (lifo * lf)
> {
>         cell* v=0;
>         __asm__ __volatile__ (
>                 "# LFPOP \n\t"
>                 "testl %%eax, %%eax \n\t"
>                 "jz 20f \n"
>                 "10:\t"
>                 "movl (%%eax), %%ebx \n\t"
>                 "movl %%edx, %%ecx \n\t"
>                 "incl %%ecx \n\t"

Nothing uses the incremented %ecx

>                 LOCK "cmpxchg8b %1 \n\t"
>                 "jz 20f \n\t"
>                 "testl %%eax, %%eax \n\t"
>                 "jnz 10b \n"
>                 "20:\t"
>                 :"=a" (v)
>                 :"m" (*lf),


And you don't tell *lf is modified again.

It could be just a miscompilation caused by your wrong asm constraints.

-Andi
