Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVH2Rk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVH2Rk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVH2Rk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:40:59 -0400
Received: from spirit.analogic.com ([208.224.221.4]:36100 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751156AbVH2Rk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:40:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200508291931.00764.jesper.juhl@gmail.com>
References: <200508291931.00764.jesper.juhl@gmail.com>
X-OriginalArrivalTime: 29 Aug 2005 17:40:37.0570 (UTC) FILETIME=[C4391220:01C5ACC0]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] convert verify_area to access_ok in xtensa/kernel/signal.c
Date: Mon, 29 Aug 2005 13:39:42 -0400
Message-ID: <Pine.LNX.4.61.0508291337570.4864@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] convert verify_area to access_ok in xtensa/kernel/signal.c
Thread-Index: AcWswMRAIGUewKUGRPab+d+tai8H9g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Chris Zankel" <chris@zankel.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Aug 2005, Jesper Juhl wrote:

>
> verify_area() is deprecated and has been for quite a while.
> I thought I had cleaned up all users and was planning to submit the final
> patches to get rid of it completely, but when I did a final check I found
> that xtensa has been added after my initial cleanup and it still uses
> verify_area(), so we have to get that cleaned up before I can get on with
> the final verify_area removal.
>
>
> This patch converts all uses of verify_area() in xtensa/kernel/signal.c to
> use access_ok() instead.
>
> Please apply.
>

Isn't access_ok() also gone, handled by the put/get/copy/to/from/user
stuff?

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
> diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/arch/xtensa/kernel/signal.c linux-2.6.13/arch/xtensa/kernel/signal.c
> --- linux-2.6.13-orig/arch/xtensa/kernel/signal.c	2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.13/arch/xtensa/kernel/signal.c	2005-08-29 03:40:12.000000000 +0200
> @@ -104,7 +104,7 @@ sys_sigaction(int sig, const struct old_
>
> 	if (act) {
> 		old_sigset_t mask;
> -		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
> +		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
> 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
> 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
> 			return -EFAULT;
> @@ -116,7 +116,7 @@ sys_sigaction(int sig, const struct old_
> 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> 	if (!ret && oact) {
> -		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
> +		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
> 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
> 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
> 			return -EFAULT;
> @@ -236,7 +236,7 @@ restore_sigcontext(struct pt_regs *regs,
> 	err |= __copy_from_user (regs->areg, sc->sc_areg, XCHAL_NUM_AREGS*4);
> 	err |= __get_user(buf, &sc->sc_cpstate);
> 	if (buf) {
> -		if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
> +		if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
> 			goto badframe;
> 		err |= restore_cpextra(buf);
> 	}
> @@ -357,7 +357,7 @@ asmlinkage int sys_sigreturn(struct pt_r
> 	if (regs->depc > 64)
> 		panic ("Double exception sys_sigreturn\n");
>
> -	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> 		goto badframe;
>
> 	if (__get_user(set.sig[0], &frame->sc.oldmask)
> @@ -394,7 +394,7 @@ asmlinkage int sys_rt_sigreturn(struct p
> 		return 0;
> 	}
>
> -	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
> +	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> 		goto badframe;
>
> 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5591.77 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
