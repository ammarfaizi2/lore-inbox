Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVHIVAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVHIVAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVHIVAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:00:34 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:15532 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964964AbVHIVAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:00:34 -0400
Subject: [PATCH] Fix i386 signal handling of NODEFER, should not affect
	sa_mask (was: Re: Signal handling possibly wrong)
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <20050809204928.GH7991@shell0.pdx.osdl.net>
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <1123612016.3167.3.camel@localhost.localdomain>
	 <42F8F6CC.7090709@fujitsu-siemens.com>
	 <1123612789.3167.9.camel@localhost.localdomain>
	 <42F8F98B.3080908@fujitsu-siemens.com>
	 <1123614253.3167.18.camel@localhost.localdomain>
	 <1123615983.18332.194.camel@localhost.localdomain>
	 <42F906EB.6060106@fujitsu-siemens.com>
	 <1123617812.18332.199.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 17:00:23 -0400
Message-Id: <1123621223.9553.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 13:49 -0700, Chris Wright wrote:

> 
> SA_NODEFER
>     [XSI] If set and sig is caught, sig shall not be added to the thread's
>     signal mask on entry to the signal handler unless it is included in
>     sa_mask. Otherwise, sig shall always be added to the thread's signal
>     mask on entry to the signal handler.
> 
> Brodo, is this what you mean?
> 
> thanks,
> -chris
> --
> 
> Subject: [PATCH] fix SA_NODEFER signals to honor sa_mask
> 
> When receiving SA_NODEFER signal, kernel was inapproriately not applying
> the sa_mask.  As pointed out by Brodo Stroesser.
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> ---
> 
> diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
> --- a/arch/i386/kernel/signal.c
> +++ b/arch/i386/kernel/signal.c
> @@ -577,13 +577,12 @@ handle_signal(unsigned long sig, siginfo
>  	else
>  		ret = setup_frame(sig, ka, oldset, regs);
>  
> -	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
> -		spin_lock_irq(&current->sighand->siglock);
> -		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
> +	spin_lock_irq(&current->sighand->siglock);
> +	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
> +	if (ret && !(ka->sa.sa_flags & SA_NODEFER))
>  		sigaddset(&current->blocked,sig);
> -		recalc_sigpending();
> -		spin_unlock_irq(&current->sighand->siglock);
> -	}
> +	recalc_sigpending();
> +	spin_unlock_irq(&current->sighand->siglock);
>  
>  	return ret;
>  }


Hmm, I think you want this patch. You still need to check the return of
setting up the frames.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git1/arch/i386/kernel/signal.c.orig	2005-08-09 16:54:36.000000000 -0400
+++ linux-2.6.13-rc6-git1/arch/i386/kernel/signal.c	2005-08-09 16:55:24.000000000 -0400
@@ -577,10 +577,11 @@ handle_signal(unsigned long sig, siginfo
 	else
 		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}


