Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVLTVI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLTVI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLTVI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:08:57 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:24087 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932109AbVLTVI5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:08:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XGT2dHdGaEmE/Z9/5lOB9kRDAvVG0UHAF/DQ+ONRwRHcf0J9ieZoLdH6UjUWkfMowHA+C73dCX9U78lb4AtTn1nLWP0ZiaZrv7oHFrPaslrnhX8W1ngM7GUxXmE+UybzQBfhkUPZb1qfPfchrI3hUejG713zm3sBsHd5Kyo4Hu0=
Message-ID: <9a8748490512201308u7b6ebc2bo59f3bc4601c58657@mail.gmail.com>
Date: Tue, 20 Dec 2005 22:08:52 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "borsa77@libero.it" <borsa77@libero.it>
Subject: Re: [PATCH] Correction to kmod.c control loop
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <43A87B16.12387.487781@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A87B16.12387.487781@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/05, borsa77@libero.it <borsa77@libero.it> wrote:
> I tried this patch on my system Slackware 10.1 with the version kernel
> 2.4.29 with any problem, below it is in broken form to allow comment
> to the source.
>

2.4.29 is a pretty old kernel.

If you want to work on 2.4.x, then work against the latest version -
2.4.32 currently.

Even better is to work on 2.6.x instead (or both 2.6 & 2.4), and if
you do you should generally send patches against latest Linus kernel -
currently that's 2.6.15-rc5-git1

Working against an old kernel like 2.4.29 is often a waste of time
since whatever you are trying to fix may very well already be fixed in
a newer kernel (something you should at the very least check), so by
working against the latest kernel you save both your own and everyone
elses time.

Anyway, a few comments below.


> --- ./kmod.bak  2005-12-19 12:48:56.000000000 +0100
> +++ ../kernel/kmod.c    2005-12-19 13:29:44.000000000 +0100

Please make patches that can be applied with  patch -p1


> @@ -175,13 +175,11 @@
>   */
>  int request_module(const char * module_name)
>  {
> -       pid_t pid;
> -       int waitpid_result;
> +       pid_t pid, waitpid_result;

Why are you changing the type of waitpid_result ?


>         sigset_t tmpsig;
>         int i;
>         static atomic_t kmod_concurrent = ATOMIC_INIT(0);
> -#define MAX_KMOD_CONCURRENT 50 /* Completely arbitrary
> value - KAO */
> -       static int kmod_loop_msg;
> +       static int MAX_KMOD_CONCURRENT, kmod_loop_msg;
>
Please don't name variables all upper case, that's how we name
constants (#define's).

> The man page for waitpid function tells the return type is pid_t.
>
>         /* Don't allow request_module() before the root fs is mounted!  */
>         if ( ! current->fs->root ) {
> @@ -192,7 +190,7 @@
>
>
>         /* If modprobe needs a service that is in a module, we get a
> recursive
>          * loop.  Limit the number of running kmod threads to
> max_threads/2 or
> -        * MAX_KMOD_CONCURRENT, whichever is the smaller.  A
> cleaner method
> +        * MAX_KMOD_CONCURRENT, whichever is the larger.  A
> cleaner method
>          * would be to run the parents of this process, counting how
> many times
>          * kmod was invoked.  That would mean accessing the internals
> of the
>          * process tables to get the command line, proc_pid_cmdline is
> static
> @@ -200,7 +198,7 @@
>          * KAO.
>          */
>         i = max_threads/2;
> -       if (i > MAX_KMOD_CONCURRENT)
> +       if (i < MAX_KMOD_CONCURRENT)

You changed MAX_KMOD_CONCURRENT from a constant to a variable above,
but you never assign a value to it, so here you are comparing i to an
uninitialized variable, not good.


>                 i = MAX_KMOD_CONCURRENT;
>         atomic_inc(&kmod_concurrent);
>         if (atomic_read(&kmod_concurrent) > i) {
> @@ -208,6 +206,7 @@
>                         printk(KERN_ERR
>                                "kmod: runaway modprobe loop assumed
> and stopped\n");
>                 atomic_dec(&kmod_concurrent);
> +               MAX_KMOD_CONCURRENT =
> 2*MAX_KMOD_CONCURRENT+1;

why multiply by two and add 1 here?


>                 return -ENOMEM;
>         }
>
> Two advantages: (i) you do not worry about the choice of an arbitrary
> value, (ii) you can reiterate modprobe command until the module is
> loaded because MAX_KMOD_CONCURRENT grows with arithmetic
> progression.
>
> @@ -237,6 +236,7 @@
>         if (waitpid_result != pid) {
>                 printk(KERN_ERR "request_module[%s]: waitpid(%d,...)
> failed, errno %d\n",
>                        module_name, pid, -waitpid_result);
> +               return waitpid_result;

Ehh, the function returns an int, but you just changed the type of
waitpid_result to pid_t above...


>         }
>         return 0;
>  }
>
> I think here the exit point was omitted because originally the check was
> before the unblock of the signals, now it is safe because it is at the end
> so the errorcode should be handled.
>
> If you believe these corrections are valid, please you will send me
> feedback. Otherwise I am sorry for this lack of time.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
