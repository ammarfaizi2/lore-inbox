Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTFJWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFJWu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:50:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:57202 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261710AbTFJWu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:50:56 -0400
Date: Tue, 10 Jun 2003 16:00:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] optimize fixed size kmalloc calls
Message-Id: <20030610160044.1317953f.akpm@digeo.com>
In-Reply-To: <3EE531AA.4090404@quark.didntduck.org>
References: <3EE4E23E.4070307@colorfullife.com>
	<3EE531AA.4090404@quark.didntduck.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 23:04:37.0873 (UTC) FILETIME=[AA88A610:01C32FA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> wrote:
>
> > What do you think about the attached patch? It's not pretty, but it 
> > should work will all gcc versions. Any other ideas?
> > Just FYI: The function that forced me to use use switch/case instead of 
> > if is interrupts_open in fs/proc/proc_misc.c.
> 
> How about this?  GCC 3.2.2 is able to optimize it away properly from the 
> tests that I've run.

It doesn't compile with older gcc's - see the `extern' decl in the middle
of the function.

The compiler should have been given a way of disabling this.  It'd going to
bite again and again.


I'll fix it up.


void *kmalloc(size_t size, int flags)
{
        if (__builtin_constant_p(size)) {
                int i = 0;





# 1 "include/linux/kmalloc_sizes.h" 1

        if (size <= 32) goto found; else i++;

        if (size <= 64) goto found; else i++;



        if (size <= 128) goto found; else i++;



        if (size <= 256) goto found; else i++;
        if (size <= 512) goto found; else i++;
        if (size <= 1024) goto found; else i++;
        if (size <= 2048) goto found; else i++;
        if (size <= 4096) goto found; else i++;
        if (size <= 8192) goto found; else i++;
        if (size <= 16384) goto found; else i++;
        if (size <= 32768) goto found; else i++;
        if (size <= 65536) goto found; else i++;
        if (size <= 131072) goto found; else i++;
# 84 "include/linux/slab.h" 2

                extern void __you_cannot_kmalloc_that_much(void);
                __you_cannot_kmalloc_that_much();
found:
                return kmem_cache_alloc((flags & 0x01) ?
                        malloc_sizes[i].cs_dmacachep :
                        malloc_sizes[i].cs_cachep, flags);
        }
        return __kmalloc(size, flags);
}

