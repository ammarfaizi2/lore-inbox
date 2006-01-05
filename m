Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752190AbWAETym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbWAETym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbWAETym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:54:42 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:48496 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752185AbWAETyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:54:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=iVwI0DQCcQS1a2/0wPYTHv6xH4DTY9bIvVC5p+q5bEAylKfVwUDZOGL73durm7JQbClEgd8LhalpKNTlCrWdqK0jOOTiyN2/QrddwKO1GbRvONHqBKIBtM6/Ua7+qi8rPruYcD9GAmmVSMZjgZTXNa5kqErDdAGm437fr2D044E=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: + uml-sigwinch-handling-cleanup.patch added to -mm tree
Date: Thu, 5 Jan 2006 20:54:37 +0100
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>
References: <200601042323.k04NNti4021942@shell0.pdx.osdl.net>
In-Reply-To: <200601042323.k04NNti4021942@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601052054.37512.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 00:25, akpm@osdl.org wrote:
> The patch titled
>
>      uml: SIGWINCH handling cleanup
>
> has been added to the -mm tree.  Its filename is
>
>      uml-sigwinch-handling-cleanup.patch

Please hold, should be fixed.

> From: Jeff Dike <jdike@addtoit.com>
>
> Code cleanup - unregister_winch and winch_cleanup had some duplicate code.
> This is now abstracted out into free_winch.

Meanwhile, the whole content of the new free_winch(), including some syscalls 
on the host, and various other stuff, is brought back under the 
winch_handler_lock.

And this without notice, which means that possibly the author didn't notice 
this. A note "I brought things back under the lock because it was dumb" would 
have made me happier...

I had carefully brought that stuff out keeping only the list access under the 
lock, probably while fixing some "scheduling while atomic" warnings - once 
the element is out of the list it's unreachable thus (IMHO) safely 
accessible.

I'm thinking to some scenarios to verify if this is as true as it seems...

So, list_del should be brought out from free_winch, which would then become 
callable without the spinlock held.

> +static void free_winch(struct winch *winch)
> +{
> +	list_del(&winch->list);
> +
> +	if(winch->pid != -1)
> +		os_kill_process(winch->pid, 1);
> +	if(winch->fd != -1)
> +		os_close_file(winch->fd);
> +
> +	free_irq(WINCH_IRQ, winch);
> +	kfree(winch);
> +}
> +
>  static void unregister_winch(struct tty_struct *tty)
>  {
>  	struct list_head *ele;
> -	struct winch *winch, *found = NULL;
> +	struct winch *winch;
>
>  	spin_lock(&winch_handler_lock);
> +
>  	list_for_each(ele, &winch_handlers){
>  		winch = list_entry(ele, struct winch, list);
>                  if(winch->tty == tty){
> -                        found = winch;
> -                        break;
> +			free_winch(winch);
> +			break;
>                  }
>          }
> -        if(found == NULL)
> -		goto err;
> -
> -	list_del(&winch->list);
> -	spin_unlock(&winch_handler_lock);
> -
> -        if(winch->pid != -1)
> -                os_kill_process(winch->pid, 1);
> -
> -        free_irq(WINCH_IRQ, winch);
> -        kfree(winch);
> -
> -	return;
> -err:
>  	spin_unlock(&winch_handler_lock);
>  }
>
> -/* XXX: No lock as it's an exitcall... is this valid? Depending on cleanup
> - * order... are we sure that nothing else is done on the list? */
>  static void winch_cleanup(void)
>  {
> -	struct list_head *ele;
> +	struct list_head *ele, *next;
>  	struct winch *winch;
>
> -	list_for_each(ele, &winch_handlers){
> +	spin_lock(&winch_handler_lock);
> +
> +	list_for_each_safe(ele, next, &winch_handlers){
>  		winch = list_entry(ele, struct winch, list);
> -		if(winch->fd != -1){
> -			/* Why is this different from the above free_irq(),
> -			 * which deactivates SIGIO? This searches the FD
> -			 * somewhere else and removes it from the list... */
> -			deactivate_fd(winch->fd, WINCH_IRQ);
> -			os_close_file(winch->fd);
> -		}
> -		if(winch->pid != -1)
> -			os_kill_process(winch->pid, 1);
> +		free_winch(winch);
>  	}
> +
> +	spin_unlock(&winch_handler_lock);
>  }
>  __uml_exitcall(winch_cleanup);
>
> _
>
> Patches currently in -mm which might be from jdike@addtoit.com are
>
> uml-use-kstrdup.patch
> uml-non-void-functions-should-return-something.patch
> uml-formatting-changes.patch
> uml-use-array_size.patch
> uml-remove-unneeded-structure-field.patch
> uml-move-mconsole-support-out-of-generic-code.patch
> uml-add-static-initializations-and-declarations.patch
> uml-line_setup-interface-change.patch
> uml-move-console-configuration.patch
> uml-simplify-console-opening-closing-and-irq-registration.patch
> uml-fix-flip_buf-full-handling.patch
> uml-add-throttling-to-console-driver.patch
> uml-separate-libc-dependent-umid-code.patch
> uml-umid-cleanup.patch
> uml-sigwinch-handling-cleanup.patch
> uml-better-diagnostics-for-broken-configs.patch
> uml-add-mconsole_reply-variant-with-length-param.patch
> uml-capture-printk-output-for-mconsole-stack.patch
> uml-capture-printk-output-for-mconsole-sysrq.patch
> uml-fix-whitespace-in-mconsole-driver.patch
> uml-free-network-irq-correctly.patch
> add-block_device_operationsgetgeo-block-device-method.patch
> fix-possible-page_cache_shift-overflows.patch
> tty-layer-buffering-revamp-uml-fix.patch

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
