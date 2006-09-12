Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWILIHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWILIHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWILIHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:07:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:31063 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965110AbWILIHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:07:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ISsABQ5nc+w8vQcMgQ0jrzffxwOLGvQsGECoIll7WesqRBDwvRPzmIBjE0//2ISt67KF4yYFv7HQGuFtBIL6dnv109gXyNs5KubkyJhGlmEEt6zia1GskE3qvokL7Hv2KXIkxl7EMYt2LiMpVwwrQjyAghmdVnfjIwwfzA60gWw=
Message-ID: <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>
Date: Tue, 12 Sep 2006 16:07:03 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Cc: "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, davidm@snapgear.com, gerg@snapgear.com
In-Reply-To: <44FE4222.3080106@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
	 <17162.1157365295@warthog.cambridge.redhat.com>
	 <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
	 <3551.1157448903@warthog.cambridge.redhat.com>
	 <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
	 <44FE4222.3080106@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Aubrey wrote:
>
> > Yeah, I agree with most of your opinion. Using PG_slab is really a
> > quickest way to determine the size of the object. But I think using a
> > flag named "PG_slab" on a memory algorithm named "slob" seems not
> > reasonable. It may confuse the people who start to read the kernel
> > source code. So I'm writing to ask if there is a better solution to
> > fix the issue.
>
>
> No, confusing would be a "slab replacement" that doesn't provide the same
> API as slab and thus requires users to use ifdefs.
>
> I've already suggested exact same thing as David in the exact same situation
> about 6 months ago. It is the right way to go.

OK. Here is the patch and work properly on my side.
Welcome any suggestions and comments.

Thanks,
-Aubrey
=================================================================
diff --git a/mm/slob.c b/mm/slob.c
index 7b52b20..18ed170 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -109,6 +109,7 @@ static void *slob_alloc(size_t size, gfp

 			slob_free(cur, PAGE_SIZE);
 			spin_lock_irqsave(&slob_lock, flags);
+			SetPageSlab(virt_to_page(cur));
 			cur = slobfree;
 		}
 	}
@@ -162,6 +163,8 @@ void *kmalloc(size_t size, gfp_t gfp)
 	slob_t *m;
 	bigblock_t *bb;
 	unsigned long flags;
+	int i;
+	struct page *page;

 	if (size < PAGE_SIZE - SLOB_UNIT) {
 		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
@@ -173,12 +176,17 @@ void *kmalloc(size_t size, gfp_t gfp)
 		return 0;

 	bb->order = find_order(size);
-	bb->pages = (void *)__get_free_pages(gfp, bb->order);
+	page = alloc_pages(gfp, bb->order);
+	bb->pages = (void *)page_address(page);

 	if (bb->pages) {
 		spin_lock_irqsave(&block_lock, flags);
 		bb->next = bigblocks;
 		bigblocks = bb;
+		for (i = 0; i < (1 << bb->order); i++) {
+			SetPageSlab(page);
+			page++;
+		}
 		spin_unlock_irqrestore(&block_lock, flags);
 		return bb->pages;
 	}
@@ -202,8 +210,16 @@ void kfree(const void *block)
 		spin_lock_irqsave(&block_lock, flags);
 		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
 			if (bb->pages == block) {
+				struct page *page = virt_to_page(bb->pages);
+				int i;
+
 				*last = bb->next;
 				spin_unlock_irqrestore(&block_lock, flags);
+				for (i = 0; i < (1 << bb->order); i++) {
+					if (!TestClearPageSlab(page))
+						BUG();
+					page++;
+				}
 				free_pages((unsigned long)block, bb->order);
 				slob_free(bb, sizeof(bigblock_t));
 				return;
@@ -332,10 +348,12 @@ static struct timer_list slob_timer = TI

 void kmem_cache_init(void)
 {
+#if 0
 	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);

 	if (p)
 		free_page((unsigned long)p);
+#endif

 	mod_timer(&slob_timer, jiffies + HZ);
 }
