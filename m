Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273295AbTG3THq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273297AbTG3TGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:06:31 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20743 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S273295AbTG3TG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:06:27 -0400
Date: Wed, 30 Jul 2003 21:05:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: torvalds@osdl.org, akpm@osdl.org, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/riscom8.c: cli/sti removal
Message-ID: <20030730210550.A5015@electric-eye.fr.zoreil.com>
References: <3F2804CC.90602@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F2804CC.90602@terra.com.br>; from felipewd@terra.com.br on Wed, Jul 30, 2003 at 02:47:56PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio <felipewd@terra.com.br> :
[cli+restore/spinlock conversioni for riscom8]
> --- linux-2.6.0-test2/drivers/char/riscom8.c.orig	Wed Jul 30 14:39:11 2003
> +++ linux-2.6.0-test2/drivers/char/riscom8.c	Wed Jul 30 14:42:44 2003
[...]
> @@ -1084,7 +1090,7 @@
>  	if (!port || rc_paranoia_check(port, tty->name, "close"))
>  		return;
>  	
> -	save_flags(flags); cli();
> +	spin_lock_irqsave(&rc_lock, flags);
>  	if (tty_hung_up_p(filp))
>  		goto out;
>  	

   1111         tty->closing = 1;
   1112         if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
   1113                 tty_wait_until_sent(tty, port->closing_wait);
                        ^^^^^^^^^^^^^^^^^^^ -> may sleep
[...]
   1132                 while(port->IER & IER_TXEMPTY)  {
   1133                         current->state = TASK_INTERRUPTIBLE;
   1134                         schedule_timeout(port->timeout);
                                ^^^^^^^^^^^^^^^^ -> <blink>BOOM</blink>

If you haven't read Documentation/DocBook/kernel-locking.tmpl, please give
it a try. If you have, well, double-check your code.

Regards

--
Ueimor
