Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbTIKN6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbTIKN6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:58:16 -0400
Received: from [65.248.4.67] ([65.248.4.67]:21456 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261289AbTIKN6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:58:13 -0400
Message-ID: <002101c3786c$c7857840$131215ac@poslab219>
From: "Breno Silva" <brenosp@brasilsec.com.br>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>, <linux-kernel@vger.kernel.org>
References: <200309111540.58729@bilbo.math.uni-mannheim.de>
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Date: Thu, 11 Sep 2003 10:58:27 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do correct kmalloc+memset in new funcion.

Breno
----- Original Message -----
From: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, September 11, 2003 10:40 AM
Subject: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0


> Hi,
>
> a (very) simple grep in drivers/ showed more than 300 matches of code like
> this:
>
> foo = kmalloc(bar, baz);
> if (! foo)
> return -ENOMEM;
> memset(foo, 0, sizeof(foo));
>
> Why not add a small inlined function doing the memset for us
> and reducing the code to
>
> foo = kmalloc0(bar, baz);
> if (! foo)
> return -ENOMEM;
>
> Eike
>
> --- linux-2.6.0-test5-bk1/include/linux/slab.h 2003-09-11
15:19:40.000000000 +0200
> +++ linux-2.6.0-test5-bk1-caliban/include/linux/slab.h 2003-09-11
15:22:56.000000000 +0200
> @@ -14,6 +14,7 @@
>  #include <linux/config.h> /* kmalloc_sizes.h needs CONFIG_ options */
>  #include <linux/gfp.h>
>  #include <linux/types.h>
> +#include <linux/string.h> /* for memset */
>  #include <asm/page.h> /* kmalloc_sizes.h needs PAGE_SIZE */
>  #include <asm/cache.h> /* kmalloc_sizes.h needs L1_CACHE_BYTES */
>
> @@ -97,6 +98,16 @@
>   return __kmalloc(size, flags);
>  }
>
> +static inline void *kmalloc0(size_t size, int flags)
> +{
> + void *res = kmalloc(size, flags);
> +
> + if (res != NULL)
> + memset(res, 0, size);
> +
> + return res;
> +}
> +
>  extern void kfree(const void *);
>  extern unsigned int ksize(const void *);
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

