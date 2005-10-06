Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVJFOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVJFOZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVJFOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:25:47 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:12304 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750992AbVJFOZq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:25:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UQ6PyyImS7XrvJU5IkJ6abzz6fnMOPUwwkDchzx0DT6nTmI1p7JkT+vftpoxDc3+6ddvkAzmcd0VMWs+UH7NKvFQxy6KwLpRIhdkykhNexJfo8UxGB3oMuCMGTrpye1fk0BJapkjgOFHONFxFHzPZASbqZ0fnIewCmmENxHle+g=
Message-ID: <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com>
Date: Thu, 6 Oct 2005 16:25:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: madhu.subbaiah@wipro.com
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128606546.14385.26.camel@penguin.madhu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128606546.14385.26.camel@penguin.madhu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Madhu K.S. <madhu.subbaiah@wipro.com> wrote:
> Hi all,
>
>
> In many application we use select() system call for delay.
>
> example:
> select(0,NULL,NULL,NULL,&t1);
>
>
> select() for delay is very inefficient. I modified sys_select() code for
> efficiency .Here are the changes to fs/select.c.
>
> Please suggest on these changes.
>

A few tiny comments below.


> I know nanosleep() can be used instead of select(), but please suggest
> on my changes.
>
>
> file : fs/select.c
> function : sys_select()
>
Submitting an actual applyable patch is preferred. Makes it possible
to easily apply your changes to test the changes and then the file and
function is also part of the patch so you won't have to spell that out
explicitly.
Use   diff -up

>
>
>
>                           timeout += sec * (unsigned long) HZ;
>                 }
>         }
> -
> +
> +
>         ret = -EINVAL;
>         if (n < 0)
>                 goto out_nofds;
> -
> +       if ( (n == 0) && (inp == NULL) && (outp == NULL) &&
>                 (exp==  NULL)){
No space for the beginning parenthesis and space before the opening
bracket is preferred:
       if ((n == 0) && (inp == NULL) && (outp == NULL) &&
               (exp==  NULL)) {


> +                printf("\n I am inside new select condition timeout
>                         %d\n",timeout);
Having a printk() here certainly won't help performance.

> +                set_current_state(TASK_INTERRUPTIBLE);
> +                ret = 0;
> +                timeout = schedule_timeout(timeout);
> +                if (signal_pending(current))
> +                        ret = -ERESTARTNOHAND;
Wouldn't it make sense to jump out at this point if there's a signal pending?
                if (signal_pending(current)) {
                        ret = -ERESTARTNOHAND;
                        goto out;
                }
Or am I missing something?

> +                if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
> +                        time_t sec = 0, usec = 0;
> +                        if (timeout) {
> +                                sec = timeout / HZ;
> +                                usec = timeout % HZ;
> +                                usec *= (1000000/HZ);
Small style thing:   usec *= (1000000 / HZ);


> +                        }
> +                        put_user(sec, &tvp->tv_sec);
> +                        put_user(usec, &tvp->tv_usec);
> +                }
> +                current->state = TASK_RUNNING;
> +                goto out_nofds;
> +        }
> +
>         /* max_fdset can increase, so grab it once to avoid race */
>         max_fdset = current->files->max_fdset;
>         if (n > max_fdset)
>
[snip]

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
