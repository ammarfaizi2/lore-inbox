Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSHSDLx>; Sun, 18 Aug 2002 23:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317581AbSHSDLx>; Sun, 18 Aug 2002 23:11:53 -0400
Received: from dp.samba.org ([66.70.73.150]:34722 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317580AbSHSDLw>;
	Sun, 18 Aug 2002 23:11:52 -0400
Date: Mon, 19 Aug 2002 10:49:29 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: Re: [patch] v2.5.31 nfsctl.c stack usage reduction
Message-Id: <20020819104929.1eabb7ce.rusty@rustcorp.com.au>
In-Reply-To: <20020815173136.D29874@redhat.com>
References: <20020815173136.D29874@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002 17:31:36 -0400
Benjamin LaHaise <bcrl@redhat.com> wrote:

> Heyo,
> 
> The patch below (which depends on the copy_from_user_kmalloc addition) 
> reduces the stack usage in nfsctl.c, which was allocating structures that 
> were 2KB or more on the stack.
> 
> 		-ben
> 
> :r ~/patches/v2.5/v2.5.31-stack-nfs.diff
> diff -urN foo-v2.5.31/fs/nfsd/nfsctl.c bar-v2.5.31/fs/nfsd/nfsctl.c
> --- foo-v2.5.31/fs/nfsd/nfsctl.c	Tue Jul 30 10:24:17 2002
> +++ bar-v2.5.31/fs/nfsd/nfsctl.c	Thu Aug 15 17:26:09 2002
> @@ -155,56 +155,47 @@
>   * payload - write methods
>   */
>  
> +/* Rather than duplicate this many times, just use a funky macro. */
> +#define WRITE_METHOD(type, fn)		\
> +	type *data;			\
> +	ssize_t ret;			\
> +	if (size < sizeof(*data))	\
> +		return -EINVAL;		\
> +	data = copy_from_user_kmalloc(buf, size);\
> +	if (IS_ERR(data))		\
> +		return PTR_ERR(data);	\
> +	ret = fn;			\
> +	kfree(data);			\
> +	return ret;
> +

One tiny request: make the macro an expression statement, and then use it
as "return WRITE_METHOD(xxx, yyy)".

Or even an inline function taking void * and a size.

Let's not encourage people to do returns in macros 8)

Thanks!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
