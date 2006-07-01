Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWGAHX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWGAHX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWGAHX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:23:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964822AbWGAHXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:23:25 -0400
Date: Sat, 1 Jul 2006 00:23:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       tglx@linutronix.de, drepper@redhat.com
Subject: Re: [patch] pi-futex: futex_wake() lockup fix
Message-Id: <20060701002305.7b6b78a4.akpm@osdl.org>
In-Reply-To: <20060701070746.GA22457@elte.hu>
References: <20060701070746.GA22457@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006 09:07:46 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> Subject: pi-futex: futex_wake() lockup fix
> From: Ingo Molnar <mingo@elte.hu>
> 
> fix futex_wake() exit condition bug when handling the robust-list with 
> PI futexes on them.
> 
> (reported by Ulrich Drepper, debugged by the lock validator.)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/futex.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux/kernel/futex.c
> ===================================================================
> --- linux.orig/kernel/futex.c
> +++ linux/kernel/futex.c
> @@ -646,8 +646,10 @@ static int futex_wake(u32 __user *uaddr,
>  
>  	list_for_each_entry_safe(this, next, head, list) {
>  		if (match_futex (&this->key, &key)) {
> -			if (this->pi_state)
> -				return -EINVAL;
> +			if (this->pi_state) {
> +				ret = -EINVAL;
> +				break;
> +			}
>  			wake_futex(this);
>  			if (++ret >= nr_wake)
>  				break;

Well that was rather a howler.

How did the lock validator help in identifying this?
