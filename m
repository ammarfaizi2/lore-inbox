Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVC3GOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVC3GOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVC3GOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:14:14 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58039 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261596AbVC3GN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:13:58 -0500
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
            <1111825958.6293.28.camel@laptopd505.fenrus.org>
            <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
            <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
            <1111881955.957.11.camel@mindpipe>
            <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
            <20050327065655.6474d5d6.pj@engr.sgi.com>
            <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
            <20050327174026.GA708@redhat.com>
            <1112064777.19014.17.camel@mindpipe>
            <84144f02050328223017b17746@mail.gmail.com>
            <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
            <courier.42490293.000032B0@courier.cs.helsinki.fi>
            <20050329184411.1faa71eb.pj@engr.sgi.com>
In-Reply-To: <20050329184411.1faa71eb.pj@engr.sgi.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@engr.sgi.com>
Cc: jengelh@linux01.gwdg.de, penberg@gmail.com, rlrevell@joe-job.com,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
Date: Wed, 30 Mar 2005 09:13:57 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.424A43A5.00002305@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Paul Jackson writes:
> Even such obvious changes as removing redundant checks doesn't
> seem to ensure a performance improvement.  Jesper Juhl posted
> performance data for such changes in his microbenchmark a couple
> of days ago.

It is not a performance issue, it's an API issue. Please note that kfree() 
is analogous libc free() in terms of NULL checking. People are checking NULL 
twice now because they're confused whether kfree() deals it or not. 

Paul Jackson writes:
> Maybe we should be following your good advice: 
> 
> > You don't know that until you profile!  
> 
> instead of continuing to make these code changes.

I am all for profiling but it should not stop us from merging the patches 
because we can restore the generated code with the included (totally 
untested) patch. 

            Pekka 

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
 --- 

Index: 2.6/include/linux/slab.h
===================================================================
 --- 2.6.orig/include/linux/slab.h       2005-03-22 14:31:30.000000000 +0200
+++ 2.6/include/linux/slab.h    2005-03-30 09:08:13.000000000 +0300
@@ -105,8 +105,14 @@
       return __kmalloc(size, flags);
} 

+static inline void kfree(const void * p)
+{
+       if (!p)
+               return;
+       __kfree(p);
+}
+
extern void *kcalloc(size_t, size_t, int);
 -extern void kfree(const void *);
extern unsigned int ksize(const void *); 

extern int FASTCALL(kmem_cache_reap(int));
Index: 2.6/mm/slab.c
===================================================================
 --- 2.6.orig/mm/slab.c  2005-03-22 14:31:31.000000000 +0200
+++ 2.6/mm/slab.c       2005-03-30 09:08:45.000000000 +0300
@@ -2567,13 +2567,11 @@
 * Don't free memory not originally allocated by kmalloc()
 * or you will run into trouble.
 */
 -void kfree (const void *objp)
+void __kfree (const void *objp)
{
       kmem_cache_t *c;
       unsigned long flags; 

 -       if (!objp)
 -               return;
       local_irq_save(flags);
       kfree_debugcheck(objp);
       c = GET_PAGE_CACHE(virt_to_page(objp));
@@ -2581,7 +2579,7 @@
       local_irq_restore(flags);
} 

 -EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(__kfree); 

#ifdef CONFIG_SMP
/** 

