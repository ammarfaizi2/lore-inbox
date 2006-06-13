Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWFMLOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWFMLOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWFMLOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:14:03 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:58118 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750960AbWFMLOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:14:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bDOgG6FeKALccsgEc5gwBK4sdn7EnPY8KyNyphe3P4ymDP/PZunF2qTOfzf6qCvY1pAoIXvh7kIvMtPJxdOl9NGFgoP+m5mRonYIeWkl5TdNQbps2Ix688T3+ZweSbU4ZBsj2UPg8td6Y3lUiDKnHKTJKXKBCZnIFr/OxEnWbv8=
Message-ID: <84144f020606130414m9f1cdaq2a0ccb29a5c3b2dd@mail.gmail.com>
Date: Tue, 13 Jun 2006 14:14:01 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6 1/9] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060611112105.8641.31038.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112105.8641.31038.stgit@localhost.localdomain>
X-Google-Sender-Auth: 8d96323fbb7b9ae5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This patch adds the base support for the kernel memory leak detector. It
> traces the memory allocation/freeing in a way similar to the Boehm's
> conservative garbage collector, the difference being that the orphan
> pointers are not freed but only shown in /proc/memleak. Enabling this
> feature would introduce an overhead to memory allocations.

Some coding style comments below.

> --- /dev/null
> +++ b/include/linux/memleak.h
> @@ -0,0 +1,83 @@
> +extern void memleak_scan_area(const void *ptr, unsigned long offset, size_t length);
> +extern void memleak_insert_aliases(struct memleak_offset *ml_off_start,
> +                                  struct memleak_offset *ml_off_end);
> +
> +#define memleak_erase(ptr)     do { (ptr) = NULL; } while (0)

Use static inline functions instead of macros, please.

> +#define memleak_init()
> +#define memleak_alloc(ptr, size, ref_count)
> +#define memleak_free(ptr)
> +#define memleak_padding(ptr, offset, size)
> +#define memleak_not_leak(ptr)
> +#define memleak_ignore(ptr)
> +#define memleak_scan_area(ptr, offset, length)
> +#define memleak_insert_aliases(ml_off_start, ml_off_end)
> +#define memleak_erase(ptr)
> +#define memleak_container(type, member)

Ditto.

> --- /dev/null
> +++ b/mm/memleak.c
> @@ -0,0 +1,1166 @@
> +typedef enum {
> +       MEMLEAK_ALLOC,
> +       MEMLEAK_FREE,
> +       MEMLEAK_PADDING,
> +       MEMLEAK_NOT_LEAK,
> +       MEMLEAK_IGNORE,
> +       MEMLEAK_SCAN_AREA
> +} memleak_action_t;

Please drop the typedef.

> +/* Pointer colors, encoded with count and ref_count:
> + *   - white - orphan block, i.e. not enough references to it (ref_count >= 1)
> + *   - gray  - referred at least once and therefore non-orphan (ref_count == 0)
> + *   - black - ignore; it doesn't contain references (text section) (ref_count == -1)
> + */
> +#define COLOR_WHITE(pointer)   ((pointer)->count != -1 && (pointer)->count < (pointer)->ref_count)
> +#define COLOR_GRAY(pointer)    ((pointer)->ref_count != -1 && (pointer)->count >= (pointer)->ref_count)
> +#define COLOR_BLACK(pointer)   ((pointer)->ref_count == -1)

Use static inline functions instead of macros, please.

> +
> +static kmem_cache_t *pointer_cache;

Please use struct kmem_cache instead of the typedef.

> +static int __initdata preinit_pos = 0;

Unnecessary initialization to zero.

> +static struct memleak_pointer *last_pointer = NULL;

Same here for NULL.

> +
> +static void dump_pointer_info(struct memleak_pointer *pointer)
> +{
> +#ifdef CONFIG_KALLSYMS
> +       char namebuf[KSYM_NAME_LEN + 1] = "";
> +       char *modname;
> +       unsigned long symsize;
> +       unsigned long offset = 0;
> +#endif
> +#ifdef DEBUG
> +       struct memleak_alias *alias;
> +       struct hlist_node *elem;
> +#endif
> +       int i;
> +
> +       printk(KERN_NOTICE "kmemleak: pointer 0x%08lx:\n", pointer->pointer);
> +#ifdef DEBUG
> +       printk(KERN_NOTICE "  size = %d\n", pointer->size);
> +       printk(KERN_NOTICE "  ref_count = %d\n", pointer->ref_count);
> +       printk(KERN_NOTICE "  count = %d\n", pointer->count);
> +       printk(KERN_NOTICE "  aliases:\n");
> +       if (pointer->alias_list)
> +               hlist_for_each_entry(alias, elem, pointer->alias_list, node)
> +                       printk(KERN_NOTICE "    0x%lx\n", alias->offset);
> +       printk(KERN_NOTICE "  trace:\n");
> +#endif
> +       for (i = 0; i < MAX_TRACE; i++) {
> +               unsigned long trace = pointer->trace[i];
> +
> +               if (!trace)
> +                       break;
> +#ifdef CONFIG_KALLSYMS
> +               kallsyms_lookup(trace, &symsize, &offset, &modname, namebuf);
> +               printk(KERN_NOTICE "    %lx: <%s>\n", trace, namebuf);
> +#else
> +               printk(KERN_NOTICE "    %lx\n", trace);
> +#endif

Please move both #ifdef cases into separate functions and provide a
stub for the case where they're not enabled for readability.

> +static int insert_alias(unsigned long size, unsigned long offset)
> +{
> +       int ret = 0;

Unnecessary initialization to zero.

> +/* KMemLeak initialization. Set up the radix tree for the pointer aliases */
> +void __init memleak_init(void)
> +{
> +       int i = 0;

Unnecessary initialization to zero.
