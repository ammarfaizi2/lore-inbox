Return-Path: <linux-kernel-owner+w=401wt.eu-S932540AbXAGNZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbXAGNZu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXAGNZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:25:50 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:16657 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbXAGNZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:25:49 -0500
Subject: Re: +
	spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
	added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       kiran@scalex86.org, ak@suse.de, md@google.com, mingo@elte.hu,
       pravin.shelar@calsoftinc.com, shai@scalex86.org
In-Reply-To: <20070106232641.68511f15.akpm@osdl.org>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>
	 <1168122953.26086.230.camel@imap.mvista.com>
	 <20070106232641.68511f15.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 05:24:45 -0800
Message-Id: <1168176285.26086.241.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 23:26 -0800, Andrew Morton wrote:

> diff -puN include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix include/asm-i386/spinlock.h
> --- a/include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix
> +++ a/include/asm-i386/spinlock.h
> @@ -86,17 +86,19 @@ static inline void __raw_spin_lock_flags
>  static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
>  {
>  	asm volatile("\n1:\t"
> -		     LOCK_PREFIX " ; decb %0\n\t"
> +		     LOCK_PREFIX " ; decb %[slock]\n\t"
>  		     "jns 3f\n"
>  		     STI_STRING "\n"
>  		     "2:\t"
>  		     "rep;nop\n\t"
> -		     "cmpb $0,%0\n\t"
> +		     "cmpb $0,%[slock]\n\t"
>  		     "jle 2b\n\t"
>  		     CLI_STRING "\n"
>  		     "jmp 1b\n"
>  		     "3:\n\t"
> -		     : "+m" (lock->slock) : : "memory");
> +		     : [slock] "+m" (lock->slock)
> +		     : __CLI_STI_INPUT_ARGS
> +		     : "memory" CLI_STI_CLOBBERS);
>  }
>  #endif

Now it fails with CONFIG_PARAVIRT off .

scripts/kconfig/conf -s arch/i386/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/compile.h
  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:88,
                 from include/linux/module.h:10,
                 from include/linux/crypto.h:22,
                 from arch/i386/kernel/asm-offsets.c:8:
include/asm/spinlock.h: In function '__raw_spin_lock_irq':
include/asm/spinlock.h:100: error: expected string literal before '__CLI_STI_INPUT_ARGS'
distcc[2386] ERROR: compile arch/i386/kernel/asm-offsets.c on dwalker2/140 failed
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2


And I get this same error when compiling
arch/i386/boot/compressed/misc.c when CONFIG_PARAVIRT is on. misc.c has
an undef CONFIG_PARAVIRT at the top so I think they are the same issue.

Daniel

