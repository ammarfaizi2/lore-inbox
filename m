Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVIGLEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVIGLEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVIGLEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:04:01 -0400
Received: from ruth.realtime.net ([205.238.132.69]:44808 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S932107AbVIGLEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:04:00 -0400
In-Reply-To: <20050907195238.5523dada.sfr@canb.auug.org.au>
References: <20050907195238.5523dada.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ccb92a396938e8c1d00b46d122d6583c@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, Greg Edwards <edwardsg@sgi.com>,
       Anton Blanchard <anton@samba.org>, Linus <torvalds@osdl.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] ppc64: iSeries early printk breakage
Date: Wed, 7 Sep 2005 06:04:36 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.622)
X-Server: High Performance Mail Server - http://surgemail.com r=-224271992
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anything actually break without this patch?

My reading of unregister_console says we will acquire
the console semaphore, walk the list, fail to find the
console, relase the semaphore, and return.


Hmm... unless there is a problem with the console preference
code?  I don't see anything that should deref a bad pointer,
maybe it breaks the preference?

 From get web:

	if (console_drivers == NULL)
		preferred_console = selected_console;
	else if (console->flags & CON_CONSDEV)
		console_drivers->flags |= CON_CONSDEV;

On Sep 7, 2005, at 4:52 AM, Stephen Rothwell wrote:

> The earlier commit 8d9273918635f0301368c01b56c03a6f339e8d51
> (Consolidate early console and PPCDBG code) broke iSeries because
> it caused unregister_console(&udbg_console) to be called
> unconditionally.  iSeries never registers the udbg_console.
>
> This just reverts part of the change.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>
>  arch/ppc64/kernel/udbg.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>
> 234f5032f6ccb4d72e4b74d33af55716b67d8a27
> diff --git a/arch/ppc64/kernel/udbg.c b/arch/ppc64/kernel/udbg.c
> --- a/arch/ppc64/kernel/udbg.c
> +++ b/arch/ppc64/kernel/udbg.c
> @@ -158,14 +158,20 @@ static struct console udbg_console = {
>  	.index	= -1,
>  };
>
> +static int early_console_initialized;
> +
>  void __init disable_early_printk(void)
>  {
> +	if (!early_console_initialized)
> +		return;
>  	unregister_console(&udbg_console);
> +	early_console_initialized = 0;
>  }
>
>  /* called by setup_system */
>  void register_early_udbg_console(void)
>  {
> +	early_console_initialized = 1;
>  	register_console(&udbg_console);
>  }
>

