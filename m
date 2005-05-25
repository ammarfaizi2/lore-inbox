Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVEYORn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVEYORn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVEYORn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:17:43 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:35809 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262329AbVEYORl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:17:41 -0400
Message-ID: <4294891E.4070702@vc.cvut.cz>
Date: Wed, 25 May 2005 16:18:06 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: arjan@pentafluge.infradead.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Add "FORTIFY_SOURCE" to the linux kernel
References: <20050525084332.GA16865@pentafluge.infradead.org>
In-Reply-To: <20050525084332.GA16865@pentafluge.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@pentafluge.infradead.org wrote:

> diff -purN linux-2.6.12-rc5/include/asm-ppc/uaccess.h linux-fortify/include/asm-ppc/uaccess.h
> --- linux-2.6.12-rc5/include/asm-ppc/uaccess.h	2005-05-25 10:10:45.000000000 +0200
> +++ linux-fortify/include/asm-ppc/uaccess.h	2005-05-25 10:23:00.000000000 +0200
> @@ -330,8 +330,18 @@ copy_to_user(void __user *to, const void
>  	return n;
>  }
>  
> +extern void __chk_fail(void);
> +
>  static inline unsigned long __copy_from_user(void *to, const void __user *from, unsigned long size)
>  {
> +#ifdef CONFIG_FORTIFY_SOURCE
> +	/* 
> +	 * if we know the size of "to" then we can validate that we don't overrun the buffer.
> +	 * note that if __nbytes is known at compiletime this check is nicely optimized out
> +         */
> +	if (__bos0 (to) != (size_t) -1 && size > __bos0 (to))
> +		__chk_fail();
> +#endif
>  	return __copy_tofrom_user((__force void __user *)to, from, size);
>  }
>  
> +EXPORT_SYMBOL_GPL(__chk_fail);

Hello,
   how is this going to comply with rule that no existing symbols will be turned
into GPLONLY symbols, as stated by Linus couple of time, and mentioned for example
at http://www.tux.org/lkml/#s1-19 ?  To me it looks that no non-GPL module can work
on such kernel anymore, as memcpy/strcpy/... functions now, although themselves non-GPL
accessible (but inline...), depend on GPLONLY symbols.  Can you explain this to
me?

   And if you think that it is right thing to do, would not it be simpler for
everybody changing module loader so it just refuses to load non-GPL modules ?
Final functionality would be same in both cases...
							Thanks,
								Petr Vandrovec

