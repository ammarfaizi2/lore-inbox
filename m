Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFTXQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFTXQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFTXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:16:41 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:63976 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261819AbVFTXON convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:14:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IBky+gJb3CzOpXH7/TIyPfE4BnObXSMH00QwjJlXHRpu5HBlOz60wwvn+OBQYwt7dMV7V7k/twVJGtm5AUtWW2tpmMf9wYXdbd1HgAxqmijXn4pMWPQ1qaLlPGmP1tmEf6yvNK68Cyf5wzExd+st2T+fSWREIqis5EdIyzo2t5U=
Message-ID: <9a87484905062016141082daff@mail.gmail.com>
Date: Tue, 21 Jun 2005 01:14:11 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "domen@coderock.org" <domen@coderock.org>
Subject: Re: [patch 2/4] cdrom/aztcd: remove sleep_on() usage
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20050620215148.561754000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620215148.561754000@nd47.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, domen@coderock.org <domen@coderock.org> wrote:
> From: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> 
> 
> Directly use wait-queues instead of the deprecated sleep_on().
> This required adding a local waitqueue. Patch is compile-tested.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
>  aztcd.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletion(-)
> 
> Index: quilt/drivers/cdrom/aztcd.c
> ===================================================================
> --- quilt.orig/drivers/cdrom/aztcd.c
> +++ quilt/drivers/cdrom/aztcd.c
> @@ -179,6 +179,7 @@
>  #include <linux/ioport.h>
>  #include <linux/string.h>
>  #include <linux/major.h>
> +#include <linux/wait.h>
> 
>  #include <linux/init.h>
> 
> @@ -429,9 +430,12 @@ static void dten_low(void)
>  #define STEN_LOW_WAIT   statusAzt()
>  static void statusAzt(void)
>  {
> +       DEFINE_WAIT(wait);
>         AztTimeout = AZT_STATUS_DELAY;
>         SET_TIMER(aztStatTimer, HZ / 100);
> -       sleep_on(&azt_waitq);
> +       prepare_to_wait(&azt_waitq, &wait, TASK_UNINTERRUPTIBLE);
> +       schedule();
> +       finish_wait(&azt_waitq, &wait);
>         if (AztTimeout <= 0)
>                 printk("aztcd: Error Wait STEN_LOW_WAIT command:%x\n",
>                        aztCmd);
> 

Hmm, now that noone's sleeping on azt_waitq the two
wake_up(&azt_waitq); calls in aztStatTimer() don't seem to make much
sense any more... Can they just go away or?  If they can go away then
axt_waitq itself would seem to be a goner as well...   It might just
be me missing something, but this patch looks incomplete and not
completely thought through to me.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
