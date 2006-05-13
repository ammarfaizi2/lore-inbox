Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWEMRmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWEMRmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWEMRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:42:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:38770 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932129AbWEMRml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:42:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCeBovMemwEEIeT2JMLCSqQiUnEpoc+gFMBgf/dYqrhjFFvpNLqc31zuUHIro8xKxfUiWho0X7XXzkI7I8dRBZ2YDTl46TT72VBhLsSBpMWFGY1q8PNHOAzgDZxqZENaT1al0ciIR960N/UmiZnbDiyGriFKrPAm+Dna9xraouI=
Message-ID: <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com>
Date: Sat, 13 May 2006 19:42:40 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160541.8848.2113.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160541.8848.2113.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments on your patch below.

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch adds the base support for the kernel memory leak detector. It
> traces the memory allocation/freeing in a way similar to the Boehm's
> conservative garbage collector, the difference being that the orphan
> pointers are not freed but only shown in /proc/memleak. Enabling this

/proc is such a mess already, do we have to add another file to it?
How about using sysfs instead? I know that is "one value pr file", but
then simply make one file pr leaked pointer or something like that...


> feature would introduce an overhead to memory allocations.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>
>  include/linux/kernel.h  |   13 +
>  include/linux/memleak.h |   55 +++++
>  init/main.c             |    5
>  lib/Kconfig.debug       |   11 +
>  mm/Makefile             |    2
>  mm/memleak.c            |  549 +++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 632 insertions(+), 3 deletions(-)
>
[snip]
> diff --git a/include/linux/memleak.h b/include/linux/memleak.h
[snip]
> +#define memleak_offsetof(type, member)                         \
> +       (__builtin_constant_p(&((type *) 0)->member) ?          \
> +        ((size_t) &((type *) 0)->member) : 0)
> +

No spaces after the closing parenthesis of a cast and the value being
cast please.

       (__builtin_constant_p(&((type *)0)->member) ?          \
        ((size_t) &((type *)0)->member) : 0)

There are more occourances of this, only pointing out the first one.

[snip]
[snip]
> +config DEBUG_MEMLEAK
> +       bool "Kernel memory leak detector"
> +       depends on DEBUG_KERNEL && SLAB
> +       help
> +         Say Y here if you want to enable the memory leak
> +         detector. The memory allocation/freeing is traced in a way
> +         similar to the Boehm's conservative garbage collector, the
> +         difference being that the orphan pointers are not freed but
> +         only shown in /proc/memleak. Enabling this feature would
> +         introduce an overhead to memory allocations.

Shouldn't that last bit read "Enabling this feature will introduce
overhead to memory allocations." ?


[snip]
> +#define MAX_TRACE      1
> +#endif
> +
> +
> +extern struct memleak_offset __memleak_offsets_start[];
> +extern struct memleak_offset __memleak_offsets_end[];
> +
> +
> +struct memleak_alias {

You seem to be very fond of double empty lines, here and elsewhere.
Surely just a single blank line would do just fine in many places -
no?


[snip]
> +static inline void delete_pointer(unsigned long ptr)

"inline" ? Isn't this function a little too fat for that?


[snip]
> +/* Freeing function hook
> + */

A lot of lines could be saved if all these small comments were on a
single line instead...

/* Freeing function hook */

[snip]
> +                       delete_pointer((unsigned long) ptr);

delete_pointer((unsigned long)ptr);


[snip]
> +static void memleak_scan(void)
> +{
> +       unsigned long flags;
> +       struct memleak_pointer *pointer;
> +       struct task_struct *task;
> +       int node;
> +#ifdef CONFIG_SMP
> +       int i;
> +#endif

Why not just get rid of `i' and just use the `node' variable in the
single location where `i' is used (or get rid of `node' and use `i' in
its place) ?
As far as I can see that shouldn't be a problem and it'll save one
local variable on SMP.


[snip]
> +               memleak_scan_block((void *) pointer->pointer,
> +                                  (void *) (pointer->pointer + pointer->size));

               memleak_scan_block((void *)pointer->pointer,
                                  (void *)(pointer->pointer + pointer->size));


[snip]
> +static void *memleak_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +       struct list_head *n = ((struct memleak_pointer *) v)->pointer_list.next;

       struct list_head *n = ((struct memleak_pointer *)v)->pointer_list.next;


> +
> +       ++(*pos);
> +
> +       return (n != &pointer_list)
> +               ? list_entry(n, struct memleak_pointer, pointer_list)
> +               : NULL;

Wouldn't this be more readable as

    if (n != &pointer_list)
        return list_entry(n, struct memleak_pointer, pointer_list);
    return NULL

???

[snip]
> +int __init memleak_init(void)
> +{
> +       struct memleak_offset *ml_off;
> +       int aliases = 0;
> +       unsigned long flags;
> +
> +       printk(KERN_INFO "Kernel memory leak detector\n");

How about moving this printk() to the end of memleak_init() and changing it to :

       printk(KERN_INFO "Kernel memory leak detector initialized.\n");


[snip]
> +#if 0
> +       /* make some orphan pointers for testing */
> +       kmalloc(32, GFP_KERNEL);
> +       kmalloc(32, GFP_KERNEL);
> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
> +       vmalloc(64);
> +       vmalloc(64);
> +#endif

Stuff for testing is nice, but do we have to add it to the kernel? - I
assume you are done testing :-)
We have waay too much code already in the kernel inside  #if 0



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
