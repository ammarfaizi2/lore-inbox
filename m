Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWIZVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWIZVeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWIZVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:34:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964833AbWIZVeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:34:11 -0400
Date: Tue, 26 Sep 2006 14:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata.hirokazu@renesas.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Hirokazu Takata <takata@linux-m32r.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-Id: <20060926143344.f036aa76.akpm@osdl.org>
In-Reply-To: <swf8xk8l75h.wl%takata.hirokazu@renesas.com>
References: <swfzmcse7mm.wl%takata@linux-m32r.org>
	<20060924062036.GB30273@parisc-linux.org>
	<swf8xk8l75h.wl%takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 16:47:22 +0900
Hirokazu Takata <takata.hirokazu@renesas.com> wrote:

> Andrew, please drop and replace the previous my patch with the following
> Matthew's fix.
> 
> Thank you.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> --
>  include/asm-m32r/spinlock.h |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-m32r/spinlock.h b/include/asm-m32r/spinlock.h
> index f94c1a6..f9f9072 100644
> --- a/include/asm-m32r/spinlock.h
> +++ b/include/asm-m32r/spinlock.h
> @@ -298,7 +298,14 @@ #endif	/* CONFIG_CHIP_M32700_TS1 */
>  	);
>  }
>  
> -#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
> +static inline int __raw_read_trylock(raw_rwlock_t *lock)
> +{
> +	atomic_t *count = (atomic_t*)lock;
> +	if (atomic_dec_return(count) >= 0)
> +		return 1;
> +	atomic_inc(count);
> +	return 0;
> +}

We don't have a changelog for this patch.  My usual technique when this
happens is to mutter something unprintable then go on a hunt through the
mailing list archives.

But all I have is "Matthew Wilcox pointed out that
generic__raw_read_trylock() is unfit for use.".

What's wrong with it?
