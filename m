Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWAKXqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWAKXqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWAKXqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:46:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932646AbWAKXqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:46:37 -0500
Date: Wed, 11 Jan 2006 15:46:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
Message-Id: <20060111154614.47725c23.akpm@osdl.org>
In-Reply-To: <ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
References: <patchbomb.1137019194@eng-12.pathscale.com>
	<ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> Most arches use the generic routine.  x86_64 uses memcpy32 instead;
>  this is substantially faster, even over a bus that is much slower than
>  the CPU.
> 
>  Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>
> 
>  diff -r 1052904816d7 -r ee6ce7e55dc7 arch/x86_64/lib/io.c
>  --- a/arch/x86_64/lib/io.c	Wed Jan 11 14:35:45 2006 -0800
>  +++ b/arch/x86_64/lib/io.c	Wed Jan 11 14:35:45 2006 -0800
>  @@ -21,3 +21,9 @@
>   	memset((void *)a,b,c);
>   }
>   EXPORT_SYMBOL(memset_io);
>  +
>  +/* override generic definition in lib/raw_memcpy_io.c */
>  +void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count)
>  +{
>  +	memcpy32((void __force *) to, from, count);
>  +}
>  diff -r 1052904816d7 -r ee6ce7e55dc7 include/asm-alpha/io.h
>  --- a/include/asm-alpha/io.h	Wed Jan 11 14:35:45 2006 -0800
>  +++ b/include/asm-alpha/io.h	Wed Jan 11 14:35:45 2006 -0800
>  @@ -504,6 +504,8 @@
>   extern void memcpy_toio(volatile void __iomem *, const void *, long);
>   extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
>   
>  +void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
>  +

<etc>

How's about we add a new linux/io.h which does:

#include <asm/io.h>
void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);

?
