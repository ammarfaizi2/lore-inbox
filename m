Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314545AbSDTEUc>; Sat, 20 Apr 2002 00:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSDTEUb>; Sat, 20 Apr 2002 00:20:31 -0400
Received: from [195.223.140.120] ([195.223.140.120]:19981 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314545AbSDTEUa>; Sat, 20 Apr 2002 00:20:30 -0400
Date: Sat, 20 Apr 2002 06:21:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420062149.G1291@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44.0204191637570.20973-100000@home.transmeta.com> <3CC0B16F.1050501@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 08:08:15PM -0400, Brian Gerst wrote:
> diff -urN linux-2.5.8/arch/i386/kernel/i387.c linux/arch/i386/kernel/i387.c
> --- linux-2.5.8/arch/i386/kernel/i387.c	Thu Mar  7 21:18:32 2002
> +++ linux/arch/i386/kernel/i387.c	Fri Apr 19 19:35:14 2002
> @@ -31,13 +31,21 @@
>   * value at reset if we support XMM instructions and then
>   * remeber the current task has used the FPU.
>   */
> -void init_fpu(void)
> +void init_fpu(struct task_struct *tsk)
>  {
> -	__asm__("fninit");
> -	if ( cpu_has_xmm )
> -		load_mxcsr(0x1f80);
> -		
> -	current->used_math = 1;
> +	if (cpu_has_fxsr) {
> +		memset(&tsk->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
> +		tsk->thread.i387.fxsave.cwd = 0x37f;
> +		if (cpu_has_xmm)
> +			tsk->thread.i387.fxsave.mxcsr = 0x1f80;
> +	} else {
> +		memset(&tsk->thread.i387.fsave, 0, sizeof(struct i387_fsave_struct));
> +		tsk->thread.i387.fsave.cwd = 0xffff037f;
> +		tsk->thread.i387.fsave.swd = 0xffff0000;
> +		tsk->thread.i387.fsave.twd = 0xffffffff;
> +		tsk->thread.i387.fsave.fos = 0xffff0000;
> +	}
> +	tsk->used_math = 1;
>  }
>  
>  /*
> diff -urN linux-2.5.8/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
> --- linux-2.5.8/arch/i386/kernel/traps.c	Sun Apr 14 23:48:18 2002
> +++ linux/arch/i386/kernel/traps.c	Fri Apr 19 18:22:12 2002
> @@ -757,13 +757,12 @@
>   */
>  asmlinkage void math_state_restore(struct pt_regs regs)
>  {
> +	struct task_struct *tsk = current;
>  	clts();		/* Allow maths ops (or we recurse) */
>  
> -	if (current->used_math) {
> -		restore_fpu(current);
> -	} else {
> -		init_fpu();
> -	}
> +	if (!tsk->used_math)
> +		init_fpu(tsk);
> +	restore_fpu(tsk);
>  	set_thread_flag(TIF_USEDFPU);	/* So we fnsave on switch_to() */
>  }
>  

I don't think it's good enough for merging yet. If you really want to do
the fxrestor, you should at least do the init_fpu only once during
bootup. The fxrestor is probably just overkill, but the memset + the
initializations is completly superflous in a fast path, I'd also use the
proper set_fpu_cwd and friends instead of doing it by hand.  Even better
is to merge the:

			/* Simulate an empty FPU. */
			set_fpu_cwd(child, 0x037f);
			set_fpu_swd(child, 0x0000);
			set_fpu_twd(child, 0xffff);
			set_fpu_mxcsr(child, 0x1f80);

			/* Simulate an empty FPU. */
			set_fpu_cwd(child, 0x037f);
			set_fpu_swd(child, 0x0000);
			set_fpu_twd(child, 0xffff);

in ptrace.c in a single function instead of duplicating functionality by
hand.

I still think the xor will be faster, no dcache pollution at all and
less I/O to ram. Future features can require change to the "empty FPU"
state anyways.

Andrea
