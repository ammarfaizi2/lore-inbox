Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbUCVV4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbUCVV4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:56:10 -0500
Received: from mail.tpgi.com.au ([203.12.160.59]:6842 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263706AbUCVVzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:55:43 -0500
Subject: Re: swsusp problems [was Re: Your opinion on the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040321220050.GA14433@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <20040318193703.4c02f7f5.akpm@osdl.org>
	 <1079661410.15557.38.camel@calvin.wpcb.org.au>
	 <20040318200513.287ebcf0.akpm@osdl.org>
	 <1079664318.15559.41.camel@calvin.wpcb.org.au>
	 <20040321220050.GA14433@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1079988938.2779.18.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 23 Mar 2004 08:55:38 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-03-22 at 10:00, Pavel Machek wrote:
> Now I have _proof_ that eye-candy is harmfull. What is see on screen is:

No, that's not proof; just a bug in the code. It's not using the right
code to display the error message. I'll fix it asap.

>                                                               N
> umber of free pages a[                              ]h! (285723 != 285754)
>  (Press SPACE to continue)

By thw way, to get this message, you probably removed the memory pool
hooks. I'm getting the picture more and more clearly. I need to write a
series of emails explaining why each part of the changes exists. I'll
try to do that shortly.

> Was it really neccessary to rename IOTHREAD to NOFREEZE? This way you

Not really, but I felt that IOTHREAD wasn't a good description of the
way the flag is used. The name implies that it is intended for threads
used for doing I/O, but it is also used for some threads that aren't I/O
related but cannot/should not be refrigerated.

> +/* Save and restore functions for Software Suspend */
> +extern int *mtrr_suspend(void);
> +extern void mtrr_resume(int *ptr);
> +
>  #endif  /*  _LINUX_MTRR_H  */
> 
> This should be done through driver model.

It is; the latest patch removes these declarations, which I missed
before.

> +       suspend_task = 0;
> +       swsusp_state = 0;
> +       STORAGE_UNSUSPEND
> +
> +       /*
> +        * Pause the other processors so we can safely
> +        * change threads' flags
> +        */
> +
> 
> I'd call this macro abuse. Is it because 2.4 compatibility?

Yes, wholy and solely.

>         if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
>                 if (unlikely(in_atomic())) {
> -                       printk(KERN_ERR "bad: scheduling while
> atomic!\n");
> -                       dump_stack();
> +                       if (likely(!(software_suspend_state &
> SOFTWARE_SUSPEND_RUNNING))) {
> +                               printk(KERN_ERR "bad: scheduling while
> atomic!\n");
> +                               dump_stack();
> +                       }
>                 }
>         }
> 
> Were you lazy or is there some reason why scheduling while atomic is
> not bad for swsusp2?

I like the way you're forcing me to remember why I've done things the
way I have :>. I'll need to get look at this again and get back to you.
There is a good reason and I did try to avoid doing this. I just don't
remember the logic right now.

> I believe I worked around this one by drain_local_pages(), which is
> much less intrusive.

Again, I'll look at it again and explain why.

> Why do you need this one? It looks intrusive. If its really
> neccessary (or it cleans up code), this one should be sent
> separately.

Before not-long-ago, I had a separate routine that was essentially a
copy of this aimed at freeing a single page. I thought it was better to
properly merge it in. The point is this: Remember that we save the image
in two parts and that the first part saved consists of LRU pages. While
saving that part, we use the generic I/O routines, which will add the
page we've saved into the LRU. We, however, are trying to keep the image
consistent. We therefore don't want the page added to the LRU and thus
seek the remove it immediately. As I mentioned before, a better solution
might well be to stop it being added in the first place. I need to talk
with the mm guys about that.

Thanks for the comments. I really appreciate them.

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

