Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbUKQUul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUKQUul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUKQUs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:48:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:11659 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262530AbUKQUq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:46:56 -0500
Date: Wed, 17 Nov 2004 12:46:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1 - detect-atomic-counter-underflows.patch
Message-Id: <20041117124640.08bac623.akpm@osdl.org>
In-Reply-To: <200411171803.iAHI3wIG018055@turing-police.cc.vt.edu>
References: <200411171803.iAHI3wIG018055@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> Now, I *may* have simply shot myself in the foot, but when I tried booting
> 2.6.10-rc2-mm1, I got spewed *thousands* of messages triggered by this:
> 
> diff -puN include/asm-i386/atomic.h~detect-atomic-counter-underflows include/asm-i386/atomic.h
> --- 25/include/asm-i386/atomic.h~detect-atomic-counter-underflows       Wed Nov  3 15:27:37 2004
> +++ 25-akpm/include/asm-i386/atomic.h   Wed Nov  3 15:27:37 2004
> @@ -132,6 +132,10 @@ static __inline__ int atomic_dec_and_tes
>  {
>         unsigned char c;
>  
> +       if (!atomic_read(v)) {
> +               printk("BUG: atomic counter underflow at:\n");
> +               dump_stack();
> +       }
>         __asm__ __volatile__(
>                 LOCK "decl %0; sete %1"
>                 :"=m" (v->counter), "=qm" (c)
> 
> Somehow, warning a *counter* is non-zero doesn't seem right (calling it an
> underflow 4 times if the value goes 4, 3, 2, 1 and then NOT complain when it
> hits zero?) , and I'm not flooded if it says:
> 
> 	if (atomic_read(v) < 0) {

No, the code is OK.  It's telling us that we're about to take the counter
negative, and that's a good predictor of a bug somewhere.

> So is this code wrong, or did I introduce an now-detected underflow with some
> self-inflicted patch that this is picking up?

Dunno.  What was in the traces?
