Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUILQly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUILQly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUILQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:41:53 -0400
Received: from clusterfw.beeline3G.ru ([217.118.66.232]:32971 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S268730AbUILQlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:41:40 -0400
Date: Sun, 12 Sep 2004 20:33:53 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Paul Jackson <pj@sgi.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_sub_and_test
Message-ID: <20040912163352.GA27411@backtop.namesys.com>
References: <20040912031235.48c738ae.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912031235.48c738ae.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:12:35AM -0700, Paul Jackson wrote:
> The default config for sparc on 2.6.9-rc1-mm4 doesn't build, using the
> crosstools from http://developer.osdl.org/dev/plm/cross_compile.
> 
> Hans,
> 
>   Andrew counts on us to build for various arch's, especially when
>   submitting something non-trivial.  The above crosstools work
>   pretty good - give them a try.
> 
> The final link fails with:
> 
>   fs/built-in.o(.text+0x58618): In function `end_io_handler':
>   : undefined reference to `atomic_sub_and_test'
>   make[1]: *** [arch/sparc/boot/image] Error 1
> 
> The macro 'atomic_sub_and_test' is defined for more or less every other
> arch, in various include/asm-*/atomic.h files, but not defined for
> sparc.

It is defined in both asm-sparc/atomic.h and asm-sparc64/atomic.h, 
but <asm/atomic.h> was not included into fs/reiser4/flush_queue.c 

please try this patch:
=============================
--- reiser4-linux-2.6/fs/reiser4/flush_queue.c.orig	2004-09-12 20:28:10.000000000 +0400
+++ reiser4-linux-2.6/fs/reiser4/flush_queue.c	2004-09-12 20:28:26.000000000 +0400
@@ -11,6 +11,7 @@
 #include "vfs_ops.h"
 #include "writeout.h"
 
+#include <asm/atomic.h>
 #include <linux/bio.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
===============================


> This macro is used in:
> 
> 	fs/reiser4/flush_queue.c:
>                if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
> 
> If I disable the config items:
> 
>   CONFIG_REISER4_FS=y
>   CONFIG_REISER4_LARGE_KEY=y
> 
> then it builds ok (with the bogus #else removed from cachefs.h, as
> already reported on lkml).
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alex.
