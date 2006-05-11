Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWEKQSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWEKQSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWEKQSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:18:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030315AbWEKQSs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:18:48 -0400
Date: Thu, 11 May 2006 09:15:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?U+liYXN0aWVuIER1Z3Xp?= <sebastien.dugue@bull.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
Message-Id: <20060511091541.05160b2c.akpm@osdl.org>
In-Reply-To: <20060510112701.7ea3a749@frecb000686>
References: <20060510112701.7ea3a749@frecb000686>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué <sebastien.dugue@bull.net> wrote:
>
> 
> 
>   In futex_requeue(), when the 2 futexes keys hash to the same bucket, there
> is no need to move the futex_q to the end of the bucket list.
> 
> ...
> 
> Index: linux-2.6.16-rt20/kernel/futex.c
> ===================================================================
> --- linux-2.6.16-rt20.orig/kernel/futex.c	2006-05-04 10:58:38.000000000 +0200
> +++ linux-2.6.16-rt20/kernel/futex.c	2006-05-04 10:58:55.000000000 +0200
> @@ -835,17 +835,20 @@ static int futex_requeue(u32 __user *uad
>  		if (++ret <= nr_wake) {
>  			wake_futex(this);
>  		} else {
> -			list_move_tail(&this->list, &hb2->chain);
> -			this->lock_ptr = &hb2->lock;
> +			/*
> +			 * If key1 and key2 hash to the same bucket, no
> +			 * need to requeue.
> +			 */
> +			if (likely(head1 != &hb2->chain)) {
> +				list_move_tail(&this->list, &hb2->chain);
> +				this->lock_ptr = &hb2->lock;
> +			}
>  			this->key = key2;
>  			get_key_refs(&key2);
>  			drop_count++;
>  
>  			if (ret - nr_wake >= nr_requeue)
>  				break;
> -			/* Make sure to stop if key1 == key2: */
> -			if (head1 == &hb2->chain && head1 != &next->list)
> -				head1 = &this->list;
>  		}
>  	}

For some reason I get a reject when applying this.  Which is odd, because I
see no differences in there.  Oh well - please try to work out what went
wrong and double-check that the patch which I applied still makes sense.

Should the futex code be using hlist_heads for that hashtable?
