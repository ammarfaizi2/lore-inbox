Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWENHYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWENHYI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWENHYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:24:08 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:26090 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751364AbWENHYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:24:07 -0400
Message-ID: <4466DB13.5090104@gmail.com>
Date: Sun, 14 May 2006 08:24:03 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain>	 <20060513160541.8848.2113.stgit@localhost.localdomain> <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com>
In-Reply-To: <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> A few comments on your patch below.

Thanks.

> On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>> This patch adds the base support for the kernel memory leak detector. It
>> traces the memory allocation/freeing in a way similar to the Boehm's
>> conservative garbage collector, the difference being that the orphan
>> pointers are not freed but only shown in /proc/memleak. Enabling this
> 
> /proc is such a mess already, do we have to add another file to it?
> How about using sysfs instead? I know that is "one value pr file", but
> then simply make one file pr leaked pointer or something like that...

I'll probably use debugfs.

>> +#define memleak_offsetof(type, member)                         \
>> +       (__builtin_constant_p(&((type *) 0)->member) ?          \
>> +        ((size_t) &((type *) 0)->member) : 0)
>> +
> 
> 
> No spaces after the closing parenthesis of a cast and the value being
> cast please.

OK.

>> +         only shown in /proc/memleak. Enabling this feature would
>> +         introduce an overhead to memory allocations.
> 
> 
> Shouldn't that last bit read "Enabling this feature will introduce
> overhead to memory allocations." ?

Yes, indeed.

> You seem to be very fond of double empty lines, here and elsewhere.
> Surely just a single blank line would do just fine in many places -
> no?

That's just my style I seem to also add to many single empty lines but I
don't have any problem with removing them.

>> +static inline void delete_pointer(unsigned long ptr)
> 
> 
> "inline" ? Isn't this function a little too fat for that?

Not really since it is only called from one place and there won't be any
size overhead (there might not be a big speed gain either). I wanted to
separate the deleting algorithm from the locking in memleak_free.

>> +/* Freeing function hook
>> + */
> 
> 
> A lot of lines could be saved if all these small comments were on a
> single line instead...

OK.

>> +static void memleak_scan(void)
>> +{
>> +       unsigned long flags;
>> +       struct memleak_pointer *pointer;
>> +       struct task_struct *task;
>> +       int node;
>> +#ifdef CONFIG_SMP
>> +       int i;
>> +#endif
> 
> Why not just get rid of `i' and just use the `node' variable in the
> single location where `i' is used (or get rid of `node' and use `i' in
> its place) ?

OK.

>> +       return (n != &pointer_list)
>> +               ? list_entry(n, struct memleak_pointer, pointer_list)
>> +               : NULL;
> 
> 
> Wouldn't this be more readable as
> 
>    if (n != &pointer_list)
>        return list_entry(n, struct memleak_pointer, pointer_list);
>    return NULL

Indeed, I'll change it.

>> +int __init memleak_init(void)
>> +{
>> +       struct memleak_offset *ml_off;
>> +       int aliases = 0;
>> +       unsigned long flags;
>> +
>> +       printk(KERN_INFO "Kernel memory leak detector\n");
> 
> 
> How about moving this printk() to the end of memleak_init() and changing
> it to :
> 
>       printk(KERN_INFO "Kernel memory leak detector initialized.\n");

OK.

>> +#if 0
>> +       /* make some orphan pointers for testing */
>> +       kmalloc(32, GFP_KERNEL);
>> +       kmalloc(32, GFP_KERNEL);
>> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
>> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
>> +       vmalloc(64);
>> +       vmalloc(64);
>> +#endif
> 
> Stuff for testing is nice, but do we have to add it to the kernel? - I
> assume you are done testing :-)
> We have waay too much code already in the kernel inside  #if 0

The best would be to test it using a loadable module but I did most of
the work on an embedded ARM platform where it was much easier to add
some code directly. The code will be cleaned up in subsequent versions.

Thanks again,

Catalin
