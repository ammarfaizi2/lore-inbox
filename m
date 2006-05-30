Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWE3Bgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWE3Bgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWE3BbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932102AbWE3Ba7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:30:59 -0400
Date: Mon, 29 May 2006 18:34:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 22/61] lock validator:  add per_cpu_offset()
Message-Id: <20060529183458.ebb74ff8.akpm@osdl.org>
In-Reply-To: <20060529212457.GV3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212457.GV3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:57 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> add the per_cpu_offset() generic method. (used by the lock validator)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  include/asm-generic/percpu.h |    2 ++
>  include/asm-x86_64/percpu.h  |    2 ++
>  2 files changed, 4 insertions(+)
> 
> Index: linux/include/asm-generic/percpu.h
> ===================================================================
> --- linux.orig/include/asm-generic/percpu.h
> +++ linux/include/asm-generic/percpu.h
> @@ -7,6 +7,8 @@
>  
>  extern unsigned long __per_cpu_offset[NR_CPUS];
>  
> +#define per_cpu_offset(x) (__per_cpu_offset[x])
> +
>  /* Separate out the type, so (int[3], foo) works. */
>  #define DEFINE_PER_CPU(type, name) \
>      __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
> Index: linux/include/asm-x86_64/percpu.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/percpu.h
> +++ linux/include/asm-x86_64/percpu.h
> @@ -14,6 +14,8 @@
>  #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
>  #define __my_cpu_offset() read_pda(data_offset)
>  
> +#define per_cpu_offset(x) (__per_cpu_offset(x))
> +
>  /* Separate out the type, so (int[3], foo) works. */
>  #define DEFINE_PER_CPU(type, name) \
>      __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name

I can tell just looking at it that it'll break various builds.I assume that
things still happen to compile because you're presently using it in code
which those architectures don't presently compile.

But introducing a "generic" function invites others to start using it.  And
they will, and they'll ship code which "works" but is broken, because they
only tested it on x86 and x86_64.

I'll queue the needed fixups - please check it.
