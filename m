Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967741AbWK3Aru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967741AbWK3Aru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967743AbWK3Aru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:47:50 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:25062 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S967741AbWK3Art convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:47:49 -0500
In-Reply-To: <20061129113212.1e614a61@frecb000686>
References: <20061129112441.745351c9@frecb000686> <20061129113212.1e614a61@frecb000686>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <8BA392C6-FCCB-40BD-9CCF-3EF56C3491BD@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Content-Transfer-Encoding: 8BIT
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH -mm 1/5][AIO] - Rework compat_sys_io_submit
Date: Wed, 29 Nov 2006 16:47:47 -0800
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2006, at 2:32 AM, Sébastien Dugué wrote:

>                  compat_sys_io_submit() cleanup
>
>
>   Cleanup compat_sys_io_submit by duplicating some of the native  
> syscall
> logic in the compat layer and directly calling io_submit_one() instead
> of fooling the syscall into thinking it is called from a native 64-bit
> caller.
>
>   This is needed for the completion notification patch to avoid having
> to rewrite each iocb on the caller stack for sys_io_submit() to  
> find the
> sigevents.

You could explicitly mention that this eliminates:

  - the overhead of copying nr pointers on the userspace caller's stack

  - the arbitrary PAGE_SIZE/(sizeof(void *)) limit on the number of  
iocbs that can be submitted

Those alone make this worth merging.

> +	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
> +		return -EFAULT;

I'm glad you got that right :)  I no doubt would have initially  
hoisted these little checks into a shared helper function and missed  
that detail of getting the size of the access_ok() right in the  
compat case.

> +	put_ioctx(ctx);
> +
> +	return i? i: ret;

sys_io_getevents() reads:

         put_ioctx(ctx);
         return i ? i : ret;

So while this compat_sys_io_submit() logic seems fine and I would be  
comfortable with it landing as-is, I'd also appreciate it if we  
didn't introduce differences between the two functions when it seems  
just as easy to make them the same.  (That chunk is just one  
example.  There's whitespace, missing unlikely()s, etc).

- z