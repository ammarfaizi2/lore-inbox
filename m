Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHTLvL>; Tue, 20 Aug 2002 07:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSHTLvK>; Tue, 20 Aug 2002 07:51:10 -0400
Received: from ppp-217-133-223-78.dialup.tiscali.it ([217.133.223.78]:15536
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316878AbSHTLvJ>; Tue, 20 Aug 2002 07:51:09 -0400
Subject: Re: [PATCH] (re-xmit): kprobes for i386
From: Luca Barbieri <ldb@ldb.ods.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020819235020.56DF12C483@lists.samba.org>
References: <20020819235020.56DF12C483@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-vazCXNno2ygPvDXDJQXB"
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Aug 2002 13:54:24 +0200
Message-Id: <1029844464.1745.49.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vazCXNno2ygPvDXDJQXB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>  ENTRY(debug)
> +	pushl %eax
> +	SAVE_ALL
> +	movl %esp,%edx
>  	pushl $0
> -	pushl $do_debug
> -	jmp error_code
> +	pushl %edx
> +	call do_debug
> +	addl $8,%esp
> +	testl %eax,%eax 
> +	jnz restore_all
> +	jmp ret_from_exception
How about checking %cs in assembly and branching off for the kernel-mode
case?

Something like this:
ENTRY(debug)
	testl $0x3, 4(%esp)
	jz handle_kernel_mode_debug

> +	/*
> +	 * We singlestepped with interrupts disabled. So, the result on
> +	 * the stack would be incorrect for "pushfl" instruction.
> +	 */
> +	if (current_kprobe->opcode == 0x9c) { /* pushfl */
> +		regs->esp &= ~(TF_MASK | IF_MASK);
> +		regs->esp |= kprobe_old_eflags;
> +	}
This masks the stack pointer. It should mask the value pointer at by the
stack pointer.

> +	if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
> +		return;
>  	if (!(regs->xcs & 3))
>  		goto kernel_trap;
The kprobe check should be after the kernel_trap label.

> +	if (kprobe_running() && kprobe_fault_handler(regs, 13))
> +		return;
>  
>  	if (!(regs->xcs & 3))
>  		goto gp_in_kernel;
Same here.

kernel. Therefore

> -	return;
> +	return 0;
Branching off in assembly would avoid having a return value in do_debug.

> +	if (kprobe_running() && kprobe_fault_handler(&regs, 7))
> +		return;
kprobe_running should be inline.

> +	if (kprobe_running() && kprobe_fault_handler(regs, 14))
> +		return;
> +
Same here.


--=-vazCXNno2ygPvDXDJQXB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Yi3wdjkty3ft5+cRAoOZAJ4iApQrRtUx6ZJJ+DZfOHYA/PjiCACfagrs
YG9Cto/UGJXVdK4t5VE+eCo=
=C7Pj
-----END PGP SIGNATURE-----

--=-vazCXNno2ygPvDXDJQXB--
