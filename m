Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbUJYQ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUJYQ2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbUJYQZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:25:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38296 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262039AbUJYQYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:24:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: Fw: BUG_ONs in signal.c?
Date: Mon, 25 Oct 2004 09:23:54 -0700
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200410230429.i9N4TOZK027399@magilla.sf.frob.com>
In-Reply-To: <200410230429.i9N4TOZK027399@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410250923.54067.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 22, 2004 9:29 pm, Roland McGrath wrote:
> Oh, duh.  The race is obvious.  Sorry for the confusion there.
> I think this is the way to fix it.
>
> --- linux-2.6/kernel/signal.c 19 Oct 2004 15:03:02 -0000 1.143
> +++ linux-2.6/kernel/signal.c 23 Oct 2004 04:23:31 -0000
> @@ -1909,22 +1910,16 @@ relock:
>     * Anything else is fatal, maybe with a core dump.
>     */
>    current->flags |= PF_SIGNALED;
> -  if (sig_kernel_coredump(signr) &&
> -      do_coredump((long)signr, signr, regs)) {
> +  if (sig_kernel_coredump(signr)) {
>     /*
> -    * That killed all other threads in the group and
> -    * synchronized with their demise, so there can't
> -    * be any more left to kill now.  The group_exit
> -    * flags are set by do_coredump.  Note that
> -    * thread_group_empty won't always be true yet,
> -    * because those threads were blocked in __exit_mm
> -    * and we just let them go to finish dying.
> -    */
> -   const int code = signr | 0x80;
> -   BUG_ON(!current->signal->group_exit);
> -   BUG_ON(current->signal->group_exit_code != code);
> -   do_exit(code);
> -   /* NOTREACHED */
> +    * If it was able to dump core, this kills all
> +    * other threads in the group and synchronizes with
> +    * their demise.  If we lost the race with another
> +    * thread getting here, it set group_exit_code
> +    * first and our do_group_exit call below will use
> +    * that value and ignore the one we pass it.
> +    */
> +   do_coredump((long)signr, signr, regs);
>    }
>
>    /*

Yeah, this looks good, although we'll end up calling do_group_exit instead of 
do_exit for the dumped task, is that ok?

> While looking at this, I noticed a bug (not directly related) in
> do_coredump. It was setting the "core dumped" flag even when the format
> dumping hook failed (e.g. for memory allocation failures).
>
>
> --- linux-2.6/fs/exec.c 19 Oct 2004 15:05:13 -0000 1.146
> +++ linux-2.6/fs/exec.c 23 Oct 2004 04:23:42 -0000
> @@ -1417,7 +1417,8 @@ int do_coredump(long signr, int exit_cod
>
>   retval = binfmt->core_dump(signr, regs, file);
>
> - current->signal->group_exit_code |= 0x80;
> + if (retval)
> +  current->signal->group_exit_code |= 0x80;
>  close_fail:
>   filp_close(file, NULL);
>  fail_unlock:

Yeah, saw this too, sorry I forgot to mention it.

Thanks,
Jesse
