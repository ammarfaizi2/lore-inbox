Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268909AbTGJEU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 00:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268910AbTGJEU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 00:20:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268909AbTGJEUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 00:20:24 -0400
Date: Wed, 9 Jul 2003 21:30:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: rmk@arm.linux.org.uk, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: 2.5.74-mm3 yenta-socket oops back
Message-Id: <20030709213010.1882a898.akpm@osdl.org>
In-Reply-To: <200307101127.32590.mflt1@micrologica.com.hk>
References: <200307060039.34263.daniel.ritz@gmx.ch>
	<20030706231551.B16820@flint.arm.linux.org.uk>
	<200307101127.32590.mflt1@micrologica.com.hk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mflt1@micrologica.com.hk> wrote:
>
> 2.5.74-mm3 yenta-socket oopsed on the first boot at the same spot. 
> 
> I have successfully used both patches below with -mm1.
> 
> --- 1.50/drivers/pcmcia/cs.c    Mon Jun 30 22:22:30 2003
> +++ edited/cs.c Sat Jul  5 23:58:07 2003
> @@ -338,13 +338,13 @@
>         socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
>         INIT_LIST_HEAD(&socket->cis_cache);
>         spin_lock_init(&socket->lock);
> -
> -       init_socket(socket);
> -
>         init_completion(&socket->thread_done);
>         init_waitqueue_head(&socket->thread_wait);
>         init_MUTEX(&socket->skt_sem);
>         spin_lock_init(&socket->thread_lock);
> +
> +       init_socket(socket);
> +
>         ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
>         if (ret < 0)
>                 return ret;
> 

This one is clearly correct.

> and my patch (may apply with some offset, which I'm about to check
> into bk anyway):
> 
> --- linux/drivers/pcmcia/cs.c.old       Fri Jul  4 10:21:50 2003
> +++ linux/drivers/pcmcia/cs.c   Sun Jul  6 23:04:10 2003
> @@ -870,11 +870,13 @@
>  
>  void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
>  {
> -       spin_lock(&s->thread_lock);
> -       s->thread_events |= events;
> -       spin_unlock(&s->thread_lock);
> +       if (s->thread) {
> +               spin_lock(&s->thread_lock);
> +               s->thread_events |= events;
> +               spin_unlock(&s->thread_lock);
>  
> -       wake_up(&s->thread_wait);
> +               wake_up(&s->thread_wait);
> +       }
>  } /* pcmcia_parse_events */

This one may not be.  How did we get here with no thread to handle the
event?  Do you have an oops trace on this one?

Or just stick a

	if (!s->thread)
		dump_stack();

in there as well.

