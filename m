Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWEOSt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWEOSt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWEOSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:49:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751623AbWEOStn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:49:43 -0400
Date: Mon, 15 May 2006 11:52:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-Id: <20060515115208.57a11dcb.akpm@osdl.org>
In-Reply-To: <20060515182855.GB18652@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org>
	<20060515140811.GA23750@shadowen.org>
	<20060515175306.GA18185@elte.hu>
	<20060515110814.11c74d70.akpm@osdl.org>
	<20060515182855.GB18652@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > (which has nothing to do with x86_64 anyway)
> > 
> > True.
> > 
> > I guess the concern here is that we don't want people building these 
> > frankenkernels and then sending us bug reports against them.
> 
> sure - lets simply turn it into a printk, as per the patch below.
> 
> it's not like we are being swamped with these bugreports, it seems i was 
> the only one who tried. So lets not over-react it. (and the panic was 
> the worst possible thing we could do.)
> 
> 	Ingo
> 
> ---
> 
> warn users that running CONFIG_NUMA on non-x440 boxes is barely tested.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>  arch/i386/kernel/srat.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux/arch/i386/kernel/srat.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/srat.c
> +++ linux/arch/i386/kernel/srat.c
> @@ -267,12 +267,9 @@ int __init get_memcfg_from_srat(void)
>  	int i = 0;
>  
>  	extern int use_cyclone;

argh.

If we didn't do this lazy-ass put-the-declaration-in-the-C-file thing, we'd
have noticed that the declaration of use_cyclone is in
include/asm-i386/mach-summit/mach_mpparse.h.

use_cyclone isn't defined if !CONFIG_X86_CYCLONE_TIMER.
arch/i386/kernel/srat.c is only compiled if X86_SUMMIT || X86_GENERICARCH.

<tries to break it>

I have a config here which has NUMA=y, ACPI_SRAT=y, X86_SUMMIT=n (and
X86_SUMMIT_NUMA=y!!) and, for some reason it set X86_CYCLONE_TIMER=y, which
is dumb.  But it will manage to link with this patch applied.

But still, referencing a variable which is implemented in
arch/i386/kernel/timers/timer_cyclone.c from within arch/i386/kernel/srat.c
is asking for trouble, no?
