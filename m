Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSLWX2S>; Mon, 23 Dec 2002 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSLWX2S>; Mon, 23 Dec 2002 18:28:18 -0500
Received: from p039.as-l031.contactel.cz ([212.65.234.231]:27264 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S267007AbSLWX2R>;
	Mon, 23 Dec 2002 18:28:17 -0500
Date: Tue, 24 Dec 2002 00:27:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021223232743.GC2907@ppc.vc.cvut.cz>
References: <Pine.LNX.4.44.0212221050210.2587-100000@home.transmeta.com> <Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 09:03:44PM -0800, Linus Torvalds wrote:
> 
> How does the attached patch work for people? I've verified that
> single-stepping works, and I've also verified that it does improve
> performance for simple system calls. Everything looks quite simple.

> ===== arch/i386/kernel/sysenter.c 1.4 vs edited =====
> --- 1.4/arch/i386/kernel/sysenter.c	Sat Dec 21 16:02:02 2002
> +++ edited/arch/i386/kernel/sysenter.c	Sun Dec 22 20:17:28 2002
> @@ -54,19 +54,18 @@
>  		0xc3			/* ret */
>  	};
>  	static const char sysent[] = {
> -		0x9c,			/* pushf */
>  		0x51,			/* push %ecx */
>  		0x52,			/* push %edx */
>  		0x55,			/* push %ebp */
>  		0x89, 0xe5,		/* movl %esp,%ebp */
>  		0x0f, 0x34,		/* sysenter */
> +		0x00,			/* align return point */
>  	/* System call restart point is here! (SYSENTER_RETURN - 2) */
>  		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */

Hi Linus,

Jump instruction should be 0xeb, 0xf9, with 0xeb, 0xfa it jumps into 
the middle of movl %esp,%ebp because of added alignment.

Maybe glibc tests needs also something to check restarted syscall...
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/arch/i386/kernel/sysenter.c.orig	2002-12-24 00:23:41.000000000 +0100
+++ linux/arch/i386/kernel/sysenter.c	2002-12-24 00:23:50.000000000 +0100
@@ -61,7 +61,7 @@
 		0x0f, 0x34,		/* sysenter */
 		0x00,			/* align return point */
 	/* System call restart point is here! (SYSENTER_RETURN - 2) */
-		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
+		0xeb, 0xf9,		/* jmp to "movl %esp,%ebp" */
 	/* System call normal return point is here! (SYSENTER_RETURN in entry.S) */
 		0x5d,			/* pop %ebp */
 		0x5a,			/* pop %edx */
