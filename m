Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUKBJ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUKBJ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUKBJyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:54:12 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:51974 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261151AbUKBJsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:48:32 -0500
Date: Tue, 2 Nov 2004 09:48:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 8/14] FRV: GP-REL data support
Message-ID: <20041102094827.GD5841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JUL1K023209@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JUL1K023209@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/jiffies.h	2004-10-27 17:32:36.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/linux/jiffies.h	2004-11-01 11:47:05.112636819 +0000
> @@ -70,13 +70,23 @@
>  /* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
>  #define TICK_USEC_TO_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
>  
> +/* some arch's have a small-data section that can be accessed register-relative
> + * but that can only take up to, say, 4-byte variables. jiffies being part of
> + * an 8-byte variable may not be correctly accessed unless we force the issue
> + */
> +#ifdef CONFIG_FRV
> +#define __jiffy_data  __attribute__((section(".data")))
> +#else
> +#define __jiffy_data
> +#endif

please avoid per-arch ifdefs in common code, this needs to go into some asm/
header, or and __ARCH_HAVE_FOO ifdef.  Anyway, would doing this
unconditionally cause any problems?

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/linkage.h linux-2.6.10-rc1-bk10-frv/include/linux/linkage.h
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/linkage.h	2004-10-19 10:42:16.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/linux/linkage.h	2004-11-01 11:47:05.114636652 +0000
> @@ -44,4 +44,8 @@
>  #define fastcall
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +extern const char linux_banner[];
> +#endif

totally wrong place.  this is not about linkage at all.

