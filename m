Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWBZSYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWBZSYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWBZSYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:24:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751386AbWBZSYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:24:20 -0500
Date: Sun, 26 Feb 2006 10:21:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, largret@gmail.com, axboe@suse.de,
       Andi Kleen <ak@muc.de>
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060226102152.69728696.akpm@osdl.org>
In-Reply-To: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Chris Largret is getting repeated OOM kills because of DMA memory
> exhaustion:
> 
> oom-killer: gfp_mask=0xd1, order=3
> 

This could be related to the known GFP_DMA oom on some x86_64 machines.

> Looking at floppy_open, we have:
> 
>         if (!floppy_track_buffer) {
>                 /* if opening an ED drive, reserve a big buffer,
>                  * else reserve a small one */
>                 if ((UDP->cmos == 6) || (UDP->cmos == 5))
>                         try = 64;       /* Only 48 actually useful */
>                 else
>                         try = 32;       /* Only 24 actually useful */
> 
>                 tmp = (char *)fd_dma_mem_alloc(1024 * try);
>                 if (!tmp && !floppy_track_buffer) {
>                         try >>= 1;      /* buffer only one side */
>                         INFBOUND(try, 16);
>                         tmp = (char *)fd_dma_mem_alloc(1024 * try);
>                 }
>                 if (!tmp && !floppy_track_buffer) {
>                         fallback_on_nodma_alloc(&tmp, 2048 * try);
>                 }
> 
> So it will try to allocate half its first request if that fails, then
> fall back to non-DMA memory as a last resort, but doesn't get a chance
> because the OOM killer gets invoked.  Maybe we need a new flag that says
> "fail me immediately if no memory available"?

That's __GFP_NORETRY.

> Or should floppy.c be fixed so it doesn't ask for so much?
> 

The page allocator uses 32k as the threshold for when-to-try-like-crazy.

x86_64 should probably be defining its own fd_dma_mem_alloc() which doesn't
use GFP_DMA.

--- devel/drivers/block/floppy.c~floppy-false-oom-fix	2006-02-26 10:14:38.000000000 -0800
+++ devel-akpm/drivers/block/floppy.c	2006-02-26 10:15:04.000000000 -0800
@@ -278,7 +278,8 @@ static void do_fd_request(request_queue_
 #endif
 
 #ifndef fd_dma_mem_alloc
-#define fd_dma_mem_alloc(size) __get_dma_pages(GFP_KERNEL,get_order(size))
+#define fd_dma_mem_alloc(size)	\
+		__get_dma_pages(GFP_KERNEL|__GFP_NORETRY,get_order(size))
 #endif
 
 static inline void fallback_on_nodma_alloc(char **addr, size_t l)
_

