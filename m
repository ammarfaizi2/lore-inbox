Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWAKWr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWAKWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWAKWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:47:56 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:21382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932488AbWAKWry convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:47:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ipyt6Ulkx+WT4c4n2GmfDOwNEziEfUh1kgy2JNkineoO3LWtOgiIUo5spm1DLB+qLIvE9ET+tmQQmNRCmb/hjpbKT8XxInMW087My2JGysazzgo0frmF20lY4yU4l4GQUX4CEtwPudSF7lz5oyiIp/M6TZtgK2UBM5NirVtzImg=
Message-ID: <9a8748490601111447s25ee4f68vace2077eae05b6ae@mail.gmail.com>
Date: Wed, 11 Jan 2006 23:47:53 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, linux-kernel@vger.kernel.org, sct@redhat.com, mingo@elte.hu
In-Reply-To: <20060111224013.GA8277@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601112126.59796.ak@suse.de>
	 <20060111124617.5e7e1eaa.akpm@osdl.org>
	 <1137012917.2929.78.camel@laptopd505.fenrus.org>
	 <20060111130728.579ab429.akpm@osdl.org>
	 <1137014875.2929.81.camel@laptopd505.fenrus.org>
	 <20060111224013.GA8277@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Pavel Machek <pavel@suse.cz> wrote:
> On St 11-01-06 22:27:55, Arjan van de Ven wrote:
> > > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > > to return zero.
> >
> > you are correct, and the x86-64 mutex.h is buggy
> >
> > --- linux-2.6.15/include/asm-x86_64/mutex.h.org       2006-01-11 22:25:37.000000000 +0100
> > +++ linux-2.6.15/include/asm-x86_64/mutex.h   2006-01-11 22:25:43.000000000 +0100
> > @@ -104,7 +104,7 @@
> >  static inline int
> >  __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> >  {
> > -     if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
> > +     if (likely(atomic_cmpxchg(count, 1, 0) == 1))
> >               return 1;
> >       else
> >               return 0;
> >
> > changes the asm to be the correct one for me.
> > This is odd/evil though..
>
> likely is the evil part here. What about this? Should make this bug
> impossible to do....
>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -59,8 +59,8 @@ extern void __chk_io_ptr(void __iomem *)
>   * specific implementations come from the above header files
>   */
>
> -#define likely(x)      __builtin_expect(!!(x), 1)
> -#define unlikely(x)    __builtin_expect(!!(x), 0)
> +#define likely(x)      (__builtin_expect(!!(x), 1))
> +#define unlikely(x)    (__builtin_expect(!!(x), 0))
>
>  /* Optimization barrier */
>  #ifndef barrier
> diff --git a/kernel/sched.c b/kernel/sched.c
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -367,7 +367,7 @@ repeat_lock_task:
>         local_irq_save(*flags);
>         rq = task_rq(p);
>         spin_lock(&rq->lock);
> -       if (unlikely(rq != task_rq(p))) {
> +       if unlikely(rq != task_rq(p)) {

This is confusing to read. Why not keep the parenthesis around
(unlikely(...)) ?  Yes, it's an extra set of parenthesis that are not
strictly needed now that you've added them to the likely/unlikely
macros, but they don't do any harm either and make the code less
surprising to read...   I know that I at least think *BUG* at once
when I read a line like
   if unlikely(rq != task_rq(p)) {
and then when I find that it actually compiles fine I go dig for the
reason for that, find the macro and see that all is well, but that
just wasted a lot of time.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
