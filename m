Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWJWMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWJWMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWJWMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:31:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751930AbWJWMbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:31:34 -0400
Date: Sat, 21 Oct 2006 14:44:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
Subject: Re: [linux-pm] [PATCH] Quieten freezer if !CONFIG_PM_DEBUG.
Message-ID: <20061021124438.GB10892@elf.ucw.cz>
References: <1161433364.7644.9.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161433364.7644.9.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The freezing of processes is currently very noisy. This patch makes the
> noise dependant upon CONFIG_PM_DEBUG.
> 
> Prepared against current git.
>     
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 29be608..6829612 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -15,6 +15,12 @@ #include <linux/module.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  
> +#ifdef CONFIG_PM_DEBUG
> +#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
> +#else
> +#define freezer_message(msg, a...) do { } while(0)
> +#endif
> +

No. We already have pr_debug().

And having stopping tasks: ============== line does not seem that bad
to me. Drivers are so noisy that this is very minor. Feel free to
adjust loglevels so that message is hidden.

...all the messages you modified should probably be fixed to be KERN_INFO...

> @@ -158,18 +164,18 @@ void thaw_processes(void)
>  {
>  	struct task_struct *g, *p;
>  
> -	printk( "Restarting tasks..." );
> +	freezer_message( "Restarting tasks..." );
>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
>  		if (!freezeable(p))
>  			continue;
>  		if (!thaw_process(p))
> -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> +			freezer_message(KERN_INFO " Strange, %s not
stopped\n", p->comm );

This one definitely needs to stay, maybe should be promoted to
KERN_WARNING or something.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
