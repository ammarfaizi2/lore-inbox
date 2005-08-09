Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVHINkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVHINkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVHINkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:40:24 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:16420 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932546AbVHINkX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:40:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JSv60ayXixG6iD41Kv+WDruaNK2+S4fCE/18DRycOT+z5O51M0w+c7mt9yJYm2cbJZfb/t60YdRPi3sw7jZoPeLl8ANV0w1k1Rw939cCRV6MHgDCpfzcuQBTSH19MrYUuYcxkwNcRVnMt05xMEfjzScnLlLukKtc6slWwzJNboY=
Message-ID: <9a87484905080906402da1455f@mail.gmail.com>
Date: Tue, 9 Aug 2005 15:40:22 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATHC] remove redundant variable in sys_prctl
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <9a874849050809044575466fa1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a874849050809044575466fa1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> The `sig' variable in kernel/sys.c::sys_prctl() is completely
> redundant, we might as well get rid of it.
> Patch below for review (also attached since gmail's webmail interface
> will most certainly mangle the inline one).
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> --- linux-2.6.13-rc6/kernel/sys.c~      2005-08-09 13:35:40.000000000 +0200
> +++ linux-2.6.13-rc6/kernel/sys.c       2005-08-09 13:35:40.000000000 +0200
> @@ -1711,7 +1711,6 @@ asmlinkage long sys_prctl(int option, un
>                           unsigned long arg4, unsigned long arg5)
>  {
>         long error;
> -       int sig;
> 
>         error = security_task_prctl(option, arg2, arg3, arg4, arg5);
>         if (error)
> @@ -1719,12 +1718,11 @@ asmlinkage long sys_prctl(int option, un
> 
>         switch (option) {
>                 case PR_SET_PDEATHSIG:
> -                       sig = arg2;
> -                       if (!valid_signal(sig)) {
> +                       if (!valid_signal(arg2)) {
>                                 error = -EINVAL;
>                                 break;
>                         }
> -                       current->pdeath_signal = sig;
> +                       current->pdeath_signal = arg2;
>                         break;
>                 case PR_GET_PDEATHSIG:
>                         error = put_user(current->pdeath_signal, (int
> __user *)arg2);
> 
> 

There is a slight difference made by this patch. since arg2 is
'unsigned long' and sig was a 'signed int', for sufficiently large
values the assignment to the signed int variable would have changed
the value.  Does this matter?  I don't think it does, but it just hit
me that it might..

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
