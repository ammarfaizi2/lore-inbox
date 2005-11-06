Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVKFVeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVKFVeb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKFVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:34:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6279 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932232AbVKFVea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:34:30 -0500
Date: Sun, 6 Nov 2005 22:34:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: swsusp not able to stop tasks
Message-ID: <20051106213411.GJ29901@elf.ucw.cz>
References: <4368BDA7.6060401@drzeus.cx> <20051102133825.GG30194@elf.ucw.cz> <4368DB5C.7070609@drzeus.cx> <20051102210326.GC23943@elf.ucw.cz> <4369CEA9.4030008@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4369CEA9.4030008@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>What is this kauditd? Try turning auditing off in kernel config, and
> >>>it should go away. If it does, add try_to_freeze() at place where
> >>>sleep is possible into kauditd...
> >>>      
> >>That it did. And the machine suspends fine with audit removed. I'll have 
> >>a look at inserting those try_to_freeze().
> >>    
> >
> >Good.

> The following did the trick:

Looks good to me. I'm not sure, but whitespace looks slightly wrong to
me. Can you write changelog, sign it off, add my acked-by, and send it
to akpm?

								Pavel

> diff --git a/kernel/audit.c b/kernel/audit.c
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -291,8 +291,10 @@ int kauditd_thread(void *dummy)
>                        set_current_state(TASK_INTERRUPTIBLE);
>                        add_wait_queue(&kauditd_wait, &wait);
> 
> -                       if (!skb_queue_len(&audit_skb_queue))
> +                       if (!skb_queue_len(&audit_skb_queue)) {
> +                               try_to_freeze();
>                                schedule();
> +                       }
> 
>                        __set_current_state(TASK_RUNNING);
>                        remove_wait_queue(&kauditd_wait, &wait);

-- 
Thanks, Sharp!
