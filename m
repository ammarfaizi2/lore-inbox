Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSL0Rh7>; Fri, 27 Dec 2002 12:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0Rh7>; Fri, 27 Dec 2002 12:37:59 -0500
Received: from khms.westfalen.de ([62.153.201.243]:20914 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S265074AbSL0Rh6>; Fri, 27 Dec 2002 12:37:58 -0500
Date: 27 Dec 2002 18:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8cdBgxoHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 23.12.02 in <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>:

> Something like the appended, perhaps?
>
> 		Linus
>
> ===== arch/i386/kernel/entry.S 1.45 vs edited =====
> --- 1.45/arch/i386/kernel/entry.S	Wed Dec 18 14:42:17 2002
> +++ edited/arch/i386/kernel/entry.S	Mon Dec 23 20:02:10 2002
> @@ -233,7 +233,7 @@
>  #endif
>
>  /* Points to after the "sysenter" instruction in the vsyscall page */
> -#define SYSENTER_RETURN 0xffffe00a
> +#define SYSENTER_RETURN 0xffffe010
>
>  	# sysenter call handler stub
>  	ALIGN
> ===== arch/i386/kernel/sysenter.c 1.5 vs edited =====
> --- 1.5/arch/i386/kernel/sysenter.c	Sun Dec 22 21:12:23 2002
> +++ edited/arch/i386/kernel/sysenter.c	Mon Dec 23 20:04:33 2002
> @@ -57,12 +57,17 @@
>  		0x51,			/* push %ecx */
>  		0x52,			/* push %edx */
>  		0x55,			/* push %ebp */
> +	/* 3: backjump target */
>  		0x89, 0xe5,		/* movl %esp,%ebp */
>  		0x0f, 0x34,		/* sysenter */
> -		0x00,			/* align return point */

Also 0x90 here?

> -	/* System call restart point is here! (SYSENTER_RETURN - 2) */
> -		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
> -	/* System call normal return point is here! (SYSENTER_RETURN in entry.S)
> */ +
> +	/* 7: align return point with nop's to make disassembly easier */
> +		0x90, 0x90, 0x90, 0x90,
> +		0x90, 0x90, 0x90,
> +
> +	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
> +		0xeb, 0xf3,		/* jmp to "movl %esp,%ebp" */
> +	/* 16: System call normal return point is here! (SYSENTER_RETURN in
> entry.S) */  		0x5d,			/* pop %ebp */
>  		0x5a,			/* pop %edx */
>  		0x59,			/* pop %ecx */


MfG Kai
