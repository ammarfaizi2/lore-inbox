Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUG1VRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUG1VRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUG1VRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:17:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:62406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263943AbUG1VRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:17:07 -0400
Date: Wed, 28 Jul 2004 14:20:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Per kthread freezer flags
Message-Id: <20040728142026.79860177.akpm@osdl.org>
In-Reply-To: <1090999301.8316.12.camel@laptop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> At the moment, all kthreads have PF_NOFREEZE set, meaning that they're
> not refrigerated during a suspend. This isn't right for some threads.
> They should be frozen while suspending. The attached patch implements
> per-kthread freezer flags. It does this by adding a new parameter to the
> create_workqueue call and its siblings. The new parameter contains the
> process flags relevant to suspending to be set. At the moment, this only
> means PF_FREEZE, but when I send the freezer improvements, a
> PF_SYNCTHREAD flag will also be valid here. The new parameter is passed
> down through the calls and applied (after masking invalid bits) once the
> thread is created.
> 
> Pavel has seen the code and requested that I send it.
> 
> Regards,
> 
> Nigel
> 
> diff -ruN linux-2.6.8-rc1-mm1/drivers/acpi/osl.c linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/acpi/osl.c
> --- linux-2.6.8-rc1-mm1/drivers/acpi/osl.c	2004-07-28 16:37:46.000000000 +1000
> +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/acpi/osl.c	2004-07-28 16:43:48.000000000 +1000
> @@ -81,7 +81,7 @@
>  		return AE_NULL_ENTRY;
>  	}
>  #endif
> -	kacpid_wq = create_singlethread_workqueue("kacpid");
> +	kacpid_wq = create_singlethread_workqueue("kacpid", 0);

hm.  In some ways I'd prefer to see new
create_singlethread_workqueue_freezer(char *) or whatever, rather than
adding an extra argument.  That's neater, smaller code and
forward-compatible.

But then again, the advantage of breaking the build for unconverted code is
that it makes people think about what their threads should be doing, so
let's go your way.

The one concern I'd have is that $RANDOM_KERNEL_DEVELOPER probably doesn't
have a clue whether or not his kernel thread should be setting PF_NOFREEZE.
What are the guidelines here?

wrt your "Add missing refrigerator support" patch: I'll suck that up, but
be aware that there's a big i2o patch in -mm which basically rips out the
driver which you just fixed up.  Perhaps you can send Markus Lidel
<Markus.Lidel@shadowconnect.com> and I a fix for that version of the driver
sometime?

