Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWHASQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWHASQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWHASQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:16:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:5827 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751752AbWHASQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:16:17 -0400
Subject: Re: [Patch] kernel: bug fixing for kernel/kmod.c
From: Steven Rostedt <rostedt@goodmis.org>
To: kenny <nek.in.cn@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20060801172024.GA24303@kenny>
References: <20060801172024.GA24303@kenny>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:15:59 -0400
Message-Id: <1154456159.25983.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 01:20 +0800, kenny wrote:
> I think there is a bug in kmod.c. In __call_usermodehelper(), when 
> kernel_thread(wait_for_helper, ...) return success, since
> wait_for_helper() might call complete() at any time, the sub_info should
> not be used any more.

Good catch!

The sub_info is on the stack of call_usermodehelper_keys and with wait
set, the wait_for_helper is called as a thread and does the complete and
there is a chance that the call_usermodehelper_keys will return and use
its stack for something else, before the helper finishes, making the
wait not valid anymore, and worst, using a bad complete.

On a normal case, the wait_for_helper will call something in userland
and this would most likely allow the caller to finish with a correct
wait.  But still this in incorrect code, since there can definitely be a
race here.

OK, now on submitting a patch :-)

1. read Documentation/SubmittingPatches

2. Linus will probably not even read this (although he might).
  So try to find a maintainer. And even on this file you see at the 
  top:

	call_usermodehelper wait flag, and remove exec_usermodehelper.
	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003

Which means that Rusty was probably the one who wrote the code.

3. Use a -p1 patch format to submit.  IOW the files to compare against
should have been a/kernel/kmod.c  and not /tmp/kmod.c.

If you want a cool tool for making patches get quilt:

http://savannah.nongnu.org/projects/quilt

4. sign off your work by adding a "Signed-off-by: Full name <email@address>"


So please, fix up your patch and send it again properly :)

-- Steve


> 
> the following patch is made in 2.6.17.7
> 
> --- kmod.c      2006-07-25 11:36:01.000000000 +0800
> +++ /tmp/kmod.c 2006-08-02 01:01:42.702054000 +0800
> @@ -198,6 +198,7 @@ static void __call_usermodehelper(void *
>  {
>         struct subprocess_info *sub_info = data;
>         pid_t pid;
> +       int wait = sub_info->wait;
> 
>         /* CLONE_VFORK: wait until the usermode helper has execve'd
>          * successfully We need the data structures to stay around
> @@ -212,7 +213,7 @@ static void __call_usermodehelper(void *
>         if (pid < 0) {
>                 sub_info->retval = pid;
>                 complete(sub_info->complete);
> -       } else if (!sub_info->wait)
> +       } else if (!wait)
>                 complete(sub_info->complete);
>  }


