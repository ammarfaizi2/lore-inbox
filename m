Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTDVTpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDVTpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:45:34 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:49862 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263409AbTDVTpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:45:32 -0400
Date: Tue, 22 Apr 2003 21:57:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ANNOUNCE] Linux 2.5.68-ce2
Message-ID: <20030422195732.GD12947@wohnheim.fh-wedel.de>
References: <200304221430_MC3-1-357B-1D59@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304221430_MC3-1-357B-1D59@compuserve.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 April 2003 14:26:21 -0400, Chuck Ebbert wrote:
> diff -u --exclude-from=/home/me/.exclude -r a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
> --- a/arch/i386/kernel/entry.S	Sat Mar 29 09:16:32 2003
> +++ b/arch/i386/kernel/entry.S	Sun Apr 20 14:29:01 2003
> @ -382,10 +382,11 @
>  ENTRY(interrupt)
>  .text
>  
> +	.align 16,0x90			# make ENTRY have correct address
>  vector=0
>  ENTRY(irq_entries_start)
>  .rept NR_IRQS
> -	ALIGN
> +	.align 16,0x90			# should be cacheline-aligned?
>  1:	pushl $vector-256
>  	jmp common_interrupt
>  .data
> @ -394,17 +395,18 @
>  vector=vector+1
>  .endr
>  
> -	ALIGN
> +	.align 16,0x90
>  common_interrupt:
>  	SAVE_ALL
>  	call do_IRQ
>  	jmp ret_from_intr
>  
>  #define BUILD_INTERRUPT(name, nr)	\
> +	.align 16,0x90;			\
>  ENTRY(name)				\
>  	pushl $nr-256;			\
>  	SAVE_ALL			\
> -	call smp_/**/name;	\
> +	call smp_/**/name;		\
>  	jmp ret_from_intr;
>  
>  /* The include is where all of the SMP etc. interrupts come from */

How about the following?

+#include <linux/cache.h>
+#define CACHELINE_ALIGN .align L1_CACHE_BYTES,0x90
...
-	ALIGN
+	CACHELINE_ALIGN
...

Or was this a bad guess of what you wanted to do?

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
