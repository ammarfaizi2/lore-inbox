Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUCIVho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUCIVho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:37:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:22156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbUCIVgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:36:39 -0500
Date: Tue, 9 Mar 2004 13:38:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] call_usermodehelper needs to wait longer
Message-Id: <20040309133835.2343565c.akpm@osdl.org>
In-Reply-To: <20040309135143.GB26645@in.ibm.com>
References: <20040309135143.GB26645@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> During my testing of call_usermodehelper, I noticed that 
> if it is called from a workqueue function, it does really wait
> (when asked to) for the usermodehelper to exit.
> 
> Patch below should fix it. It has been tested against 2.6.4-rc2-mm1
> on a 4-way x86 SMP box.
> 
> --- kmod.c.org  2004-03-09 18:52:19.000000000 +0530
> +++ kmod.c      2004-03-09 18:52:38.000000000 +0530
> @@ -258,10 +258,13 @@
>         if (current_is_keventd()) {
>                 /* We can't wait on keventd! */
>                 __call_usermodehelper(&sub_info);
> -       } else {
> +               if (!wait)
> +                       goto out;
> +       } else
>                 schedule_work(&work);
> -               wait_for_completion(&done);
> -       }
> +
> +       wait_for_completion(&done);
> +
>  out:
>         return sub_info.retval;
>  }

I'm not so sure about this.  There are deadlock potentials if the usermode
application wants to perform some function which requires keventd services
to complete - the application cannot complete because keventd is itself
waiting for the application.

Can we think of any circumstances under which keventd _should_
synchronously wait for the userspace app?

btw: your patch had whitespace where the tabs should be (email client
problem), and `patch -p1' format is (much) preferred.
