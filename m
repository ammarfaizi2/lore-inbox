Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268934AbTGJFab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbTGJFaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:30:30 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:44162
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S268934AbTGJFa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:30:28 -0400
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
From: Piet Delaney <piet@www.piet.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20030709021849.31eb3aec.akpm@osdl.org>
References: <20030708223548.791247f5.akpm@osdl.org>
	<200307091106.00781.schlicht@uni-mannheim.de> 
	<20030709021849.31eb3aec.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Jul 2003 22:44:50 -0700
Message-Id: <1057815890.22772.19.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 02:18, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
.
.
. 
> Seems complex.  I just have this:
> 
> 
> diff -puN arch/i386/kernel/apm.c~cpumask-apm-fix-2 arch/i386/kernel/apm.c
> --- 25/arch/i386/kernel/apm.c~cpumask-apm-fix-2	2003-07-08 23:09:23.000000000 -0700
> +++ 25-akpm/arch/i386/kernel/apm.c	2003-07-08 23:28:50.000000000 -0700
> @@ -528,7 +528,7 @@ static inline void apm_restore_cpus(cpum
>   *	No CPU lockdown needed on a uniprocessor
>   */
>   
> -#define apm_save_cpus()	0
> +#define apm_save_cpus()		CPU_MASK_NONE
>  #define apm_restore_cpus(x)	(void)(x)

I tried this and got a parse error. So I assumed perhaps I
needed to upgrade to the latest C compiler to be able
to handle the assignment of a inline static initializer:

      #define CPU_MASK_NONE   { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }

I was disappointed that using gcc 3.3 didn't fix the problem:
----------------------------------------------------------------------
  CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function `apm_bios_call':
arch/i386/kernel/apm.c:599: error: parse error before '{' token
arch/i386/kernel/apm.c: In function `apm_bios_call_simple':
arch/i386/kernel/apm.c:642: error: parse error before '{' token
arch/i386/kernel/apm.c: In function `apm_power_off':
arch/i386/kernel/apm.c:920: warning: braces around scalar initializer
arch/i386/kernel/apm.c:920: warning: (near initialization for
`(anonymous)')
arch/i386/kernel/apm.c:920: error: array index in non-array initializer
arch/i386/kernel/apm.c:920: error: (near initialization for
`(anonymous)')
arch/i386/kernel/apm.c:920: error: invalid initializer
arch/i386/kernel/apm.c:920: error: (near initialization for
`(anonymous)')
------------------------------------------------------------------------------

I'll settle for Matt Mackall <mpm@selenic.com> fix for now:

    +#define apm_save_cpus()        (current->cpus_allowed)

I wonder why other, like Thomas Schlichter <schlicht@uni-mannheim.de>,
had no problem with the CPU_MASK_NONE fix.

I tried adding the #include <linux/cpumask.h> that Marc-Christian
Petersen <m.c.p@wolk-project.de> sugested but it didn't help. Looks
like Jan De Luyck <lkml@kcore.org> had a similar result. 

-piet
 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
-- 
piet@www.piet.net

