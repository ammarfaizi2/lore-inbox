Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCMUKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCMUKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCMUKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:10:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46556 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261444AbVCMUKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:10:45 -0500
Date: Sun, 13 Mar 2005 21:10:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
Message-ID: <20050313201020.GB8231@elf.ucw.cz>
References: <42348474.7040808@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42348474.7040808@aknet.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -257,8 +265,31 @@
>  	movl TI_flags(%ebp), %ecx
>  	testw $_TIF_ALLWORK_MASK, %cx	# current->work
>  	jne syscall_exit_work
> +
>  restore_all:
> -	RESTORE_ALL
> +	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
> +	movb OLDSS(%esp), %ah
> +	movb CS(%esp), %al
> +	andl $(VM_MASK | (4 << 8) | 3), %eax
> +	cmpl $((4 << 8) | 3), %eax
> +	je ldt_ss			# returning to user-space with LDT SS

All common linux apps use same %ss, no? Perhaps it would be more
efficient to just check if %ss == 0x7b, and proceed directly to
restore_nocheck if not?

Or perhaps we could only enable this code after application loads
custom ldt?

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
