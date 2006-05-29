Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWE2TCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWE2TCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWE2TCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:02:37 -0400
Received: from xenotime.net ([66.160.160.81]:18340 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751174AbWE2TCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:02:36 -0400
Date: Mon, 29 May 2006 12:05:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: penberg@cs.helsinki.fi, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/comments: kmalloc man page before 2.6.17 (the fifth
 attempt)
Message-Id: <20060529120512.d757a43b.rdunlap@xenotime.net>
In-Reply-To: <20060529183325.937cea13.pauldrynoff@gmail.com>
References: <20060528111446.55572c6f.pauldrynoff@gmail.com>
	<84144f020605281029q1fa6ed59jb415ffb9a7daeef9@mail.gmail.com>
	<20060529183325.937cea13.pauldrynoff@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 18:33:25 +0400 Paul Drynoff wrote:

> This bugfix patch is added comments to right places and give possibility
> generate man pages for kmalloc(9) and kzalloc(9).

Thanks for doing this.  You are right IMO, it was really needed.
There are more that are needed if you are up to it.

> Changelog:
> * fix formatting issue

You tested this, right?  I'm still seeing some formatting issues.
Maybe it's my tools. (?)

> Index: linux-2.6.17-rc4/mm/slab.c
> ===================================================================
> --- linux-2.6.17-rc4.orig/mm/slab.c
> +++ linux-2.6.17-rc4/mm/slab.c
> @@ -3244,26 +3244,10 @@ EXPORT_SYMBOL(kmalloc_node);
>  #endif
>  
>  /**
> - * kmalloc - allocate memory
> + * __do_kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate.
> + * @flags: the type of memory to allocate (see kmalloc).
>   * @caller: function caller for debug tracking of the caller
> - *
> - * kmalloc is the normal method of allocating memory
> - * in the kernel.
> - *
> - * The @flags argument may be one of:
> - *
> - * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> - *
> - * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> - *
> - * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
> - *

These (almost) blank lines were here for better list-like formatting.
Otherwise the lines are run together -- ugly.
I have a patch below to add blank lines back in here plus a few
more fixes.

> - * Additionally, the %GFP_DMA flag may be set to indicate the memory
> - * must be suitable for DMA.  This can mean different things on different
> - * platforms.  For example, on i386, it means that the memory must come
> - * from the first 16MB.
>   */
>  static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
>  					  void *caller)
> Index: linux-2.6.17-rc4/include/linux/slab.h
> ===================================================================
> --- linux-2.6.17-rc4.orig/include/linux/slab.h
> +++ linux-2.6.17-rc4/include/linux/slab.h
> @@ -87,6 +87,39 @@ extern void *__kmalloc_track_caller(size
>      __kmalloc_track_caller(size, flags, __builtin_return_address(0))
>  #endif
>  
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + *
> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @flags argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + * %GFP_ATOMIC - Allocation will not sleep.
> + *   For example: use inside interrupt handlers.
> + * %GFP_HIGHUSER - Allocate pages from high memory.
> + * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
> + * %GFP_NOFS - Do not make any fs calls while trying to get memory.
> + *
> + * Also it is possible to set different flags by OR'ing
> + * in one or more of the following:
> + *
> + * %__GFP_COLD - Request cache-cold pages instead of
> + *   trying to return cache-warm pages.
> + * %__GFP_DMA - Request memory from the DMA-capable zone.
> + * %__GFP_HIGH - This allocation has high priority and may use emergency pools.
> + * %__GFP_HIGHMEM - Allocated memory may be from highmem.
> + * %__GFP_NOFAIL - Indicate that this allocation is in no way allowed to fail
> + *   (think twice before using).
> + * %__GFP_NORETRY - If memory is not immediately available,
> + *   then give up at once.
> + * %__GFP_NOWARN - If allocation fails, don't issue any warnings.
> + * %__GFP_REPEAT - If allocation fails initially, try once more before failing.
> + */
>  static inline void *kmalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> @@ -112,6 +145,11 @@ found:
>  
>  extern void *__kzalloc(size_t, gfp_t);
> Index: linux-2.6.17-rc4/Documentation/DocBook/kernel-api.tmpl
> ===================================================================
> --- linux-2.6.17-rc4.orig/Documentation/DocBook/kernel-api.tmpl
> +++ linux-2.6.17-rc4/Documentation/DocBook/kernel-api.tmpl
> @@ -124,6 +124,7 @@ X!Ilib/string.c
>  !Earch/i386/lib/usercopy.c
>       </sect1>
>       <sect1><title>More Memory Management Functions</title>
> +!Iinclude/linux/slab.h
>  !Iinclude/linux/rmap.h
>  !Emm/readahead.c
>  !Emm/filemap.c

Wrong place for that include/ IMO.  See patch below.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Additional kmalloc kernel-doc formatting cleanups.
Put kmalloc/kzalloc/kcalloc in the slab cache doc section.
Only use colon (":") for description/section headings.
Skip a line between "list" elements for better (not run-on) formatting.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    2 +-
 include/linux/slab.h                  |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

--- linux-2617-rc5.orig/include/linux/slab.h
+++ linux-2617-rc5/include/linux/slab.h
@@ -98,26 +98,38 @@ extern void *__kmalloc_track_caller(size
  * The @flags argument may be one of:
  *
  * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
  * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
  * %GFP_ATOMIC - Allocation will not sleep.
- *   For example: use inside interrupt handlers.
+ *   For example, use this inside interrupt handlers.
+ *
  * %GFP_HIGHUSER - Allocate pages from high memory.
+ *
  * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
+ *
  * %GFP_NOFS - Do not make any fs calls while trying to get memory.
  *
  * Also it is possible to set different flags by OR'ing
- * in one or more of the following:
+ * in one or more of the following additional @flags:
  *
  * %__GFP_COLD - Request cache-cold pages instead of
  *   trying to return cache-warm pages.
+ *
  * %__GFP_DMA - Request memory from the DMA-capable zone.
+ *
  * %__GFP_HIGH - This allocation has high priority and may use emergency pools.
+ *
  * %__GFP_HIGHMEM - Allocated memory may be from highmem.
+ *
  * %__GFP_NOFAIL - Indicate that this allocation is in no way allowed to fail
  *   (think twice before using).
+ *
  * %__GFP_NORETRY - If memory is not immediately available,
  *   then give up at once.
+ *
  * %__GFP_NOWARN - If allocation fails, don't issue any warnings.
+ *
  * %__GFP_REPEAT - If allocation fails initially, try once more before failing.
  */
 static inline void *kmalloc(size_t size, gfp_t flags)
--- linux-2617-rc5.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-rc5/Documentation/DocBook/kernel-api.tmpl
@@ -117,6 +117,7 @@ X!Ilib/string.c
   <chapter id="mm">
      <title>Memory Management in Linux</title>
      <sect1><title>The Slab Cache</title>
+!Iinclude/linux/slab.h
 !Emm/slab.c
      </sect1>
      <sect1><title>User Space Memory Access</title>
@@ -124,7 +125,6 @@ X!Ilib/string.c
 !Earch/i386/lib/usercopy.c
      </sect1>
      <sect1><title>More Memory Management Functions</title>
-!Iinclude/linux/slab.h
 !Iinclude/linux/rmap.h
 !Emm/readahead.c
 !Emm/filemap.c
