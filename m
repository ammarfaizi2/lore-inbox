Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSA3IXN>; Wed, 30 Jan 2002 03:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSA3IXK>; Wed, 30 Jan 2002 03:23:10 -0500
Received: from are.twiddle.net ([64.81.246.98]:32662 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S288977AbSA3IWW>;
	Wed, 30 Jan 2002 03:22:22 -0500
Date: Wed, 30 Jan 2002 00:22:04 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
Message-ID: <20020130002204.A4480@are.twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
In-Reply-To: <3C57207E.28598C1F@zip.com.au> <E16VivB-0005sI-00@wagner.rustcorp.com.au> <3C57430B.8B6DFD9F@zip.com.au> <20020130130026.13803fda.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130130026.13803fda.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Jan 30, 2002 at 01:00:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:00:26PM +1100, Rusty Russell wrote:
> +#define per_cpu(var, cpu)						  \
> +(*((__typeof__(&var))((void *)&var + per_cpu_offset(cpu))))

Have we already forgotten the ppc reloc flamefest?  Better
written as

#define per_cpu(var, cpu)					\
  ({ __typeof__(&(var)) __ptr;					\
     __asm__ ("" : "=g"(__ptr)					\
	      : "0"((void *)&(var) + per_cpu_offset(cpu)));	\
     *__ptr; })

> +/* Created by linker magic */
> +extern char __per_cpu_start, __per_cpu_end;
[...]
> +	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)

Will fail on targets (e.g. alpha and mips) that have a notion of a
"small data area" that can be addressed with special relocs.

Better written as

  extern char __per_cpu_start[], __per_cpu_end[];
  per_cpu_size = (__per_cpu_end - __per_cpu_start) ...


r~
