Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129482AbQK1Sa7>; Tue, 28 Nov 2000 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130312AbQK1Sat>; Tue, 28 Nov 2000 13:30:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:61707 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129482AbQK1Sai>;
        Tue, 28 Nov 2000 13:30:38 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrew Morton <andrewm@uow.edu.au>
Date: Tue, 28 Nov 2000 18:59:54 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: OOps in exec_usermodehelper
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <E29780A2645@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 00 at 1:53, Andrew Morton wrote:

> hmm..  Quite a few things fixed here.
> 
> Could you please test this patch?  It's against 2.4.0-test12-pre2,
> should be OK against test11.

I upgraded to 12-pre2 already ;-) It looks like that it works.
 
> - keventd is now capable of reaping dead children.  I will be all ears
>   if someone can tell me how to get a kernel thread to accept signals
>   without having to install a handler with
> 
>     sa.sa_handler = (__sighandler_t)100;

Is there any reason why not set sa.sa_handler to SIG_IGN? According
to arch/i386/kernel/signal.c:do_signal(), signal manpage and my memory,
kernel does automatic child reaping in such configuration. So you
could even remove waitpid() loop from keventd. I did not tried it yet,
but it looks like obvious solution... 

BTW, are you sure that kernel does not try to deliver SIGSEGV to 
keventd() when signal arrives. It looks like that it should, but it
probably fails somewhere during way due to non-existent userspace for
this process.
 
> +   sa.sa.sa_handler = (__sighandler_t)100;     /* Surely there's a better way? */
> +   sa.sa.sa_flags = 0;

SA_RESTART? SA_NOCLDSTOP ?

> +   do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
>  
>     for (;;) {
> -       current->state = TASK_INTERRUPTIBLE;
> +       __set_task_state(curtask, TASK_INTERRUPTIBLE);
>         add_wait_queue(&context_task_wq, &wait);
>  
>         /*
> @@ -46,15 +59,19 @@
>             schedule();
>  
>         remove_wait_queue(&context_task_wq, &wait);
> -       current->state = TASK_RUNNING;
> +       __set_task_state(curtask, TASK_RUNNING);
>         run_task_queue(&tq_context);
> +       if (signal_pending(curtask)) {
> +           while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
> +               ;
> +           flush_signals(curtask);
> +           recalc_sigpending(curtask);
> +       }

                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
