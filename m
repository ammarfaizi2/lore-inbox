Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHaPe0>; Sat, 31 Aug 2002 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSHaPeZ>; Sat, 31 Aug 2002 11:34:25 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:22026 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317541AbSHaPeZ>; Sat, 31 Aug 2002 11:34:25 -0400
Date: Sat, 31 Aug 2002 14:00:08 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32-bug
Message-ID: <20020831140007.C781@nightmaster.csn.tu-chemnitz.de>
References: <E17ktU0-00035E-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E17ktU0-00035E-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Aug 30, 2002 at 10:39:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Fri, Aug 30, 2002 at 10:39:12PM +0100, Russell King wrote:
> This patch appears not to be in 2.5.32, but applies cleanly.
> 
> This patch moves BUG() and PAGE_BUG() from asm/page.h into asm/bug.h.
> 
> We also fix up linux/dcache.h, which included asm/page.h for the sole
> purpose of getting the BUG() definition.
> 
> Since linux/kernel.h makes use of BUG(), asm/bug.h is included there
> as well.
> --- orig/include/asm-cris/bug.h	Thu Jan  1 01:00:00 1970
> +++ linux/include/asm-cris/bug.h	Sun Jan  6 11:46:09 2002
> @@ -0,0 +1,12 @@
> +#ifndef _CRIS_BUG_H
> +#define _CRIS_BUG_H
> +
> +#define BUG() do { \
> +  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> +} while (0)
> +
> +#define PAGE_BUG(page) do { \
> +         BUG(); \
> +} while (0)
> +
> +#endif

These kind of implementation of BUG() is not very useful. Callers
of BUG() and BUG_ON() assume, that the thread is aborted and do
nothing to fixup after BUG(). 

That makes sense, because that way BUG reduces code size and
simplifies actual code by omitting the error handling for errors
which are in the in kernel caller.

So please consider using panic() instead of printk() here to
encourage fixing of BUGs.

Maybe we should even officially define, whether BUG() is an
execution barrier or not. 

I would vote for YES, because of code size reductions under this
assumption.


Thanks & Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
