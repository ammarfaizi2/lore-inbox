Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284163AbRLARkg>; Sat, 1 Dec 2001 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284164AbRLARk1>; Sat, 1 Dec 2001 12:40:27 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:61325 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S284163AbRLARkL>;
	Sat, 1 Dec 2001 12:40:11 -0500
Date: Sat, 01 Dec 2001 17:40:07 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc: sct@redhat.com, Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code
 path changes
Message-ID: <420365759.1007228406@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.s
 z>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the purpose behind these patches?

I can see the /dis/advantages:
a) Seems to hide bugs - it's now not clear whether
   a code patch is meant to be run through when 'foo'
   is NULL or not. Whilst I appreciate kfree() checks
   foo for NULL anyway, and it's going to be hard to
   turn that into a BUG(), it doesn't mean we should
   make more of a mess.

b) I expect kmalloc() calls and kfree() calls to balance,
   and so would any kmalloc/kfree leak debugger.

c) When 'foo' was NULL before, there was a fast path
   where no kfree() function call would be made, and no
   write 'foo=NULL;' would subsequently be performed.
   Whilst I appreciate not all these are on a critical
   path, is there any reason why we now want to do a
   function call and a write when previously we avoided
   it?

If what you are worried about is performance loss through
checking the argument to kfree() against NULL twice, wouldn't
we be better doing something like this:

--- linux.clean/kernel/slab.c     Sat Jan 27 20:05:11 2001
+++ linux/kernel/slab.c      Sat Dec  1 17:31:38 2001
@@ -1577,7 +1577,7 @@
        kmem_cache_t *c;
        unsigned long flags;

-       if (!objp)
+       if (unlikely(!objp))
                return;
        local_irq_save(flags);
        CHECK_PAGE(virt_to_page(objp));

And then go through all the ones in your patch, and
rather than deleting them, inserting likely() / unlikely()
as appropriate in the ones that have any chance of actually
affecting performance.

Or even better, add in slab.h

static inline void kfree(const void * objp)
{
	if (likely(objp)) __kfree(objp);
	/* perhaps it should 'else BUG() here' but
	 * can't do that today
	 */
}

&

--- linux.clean/kernel/slab.c     Sat Jan 27 20:05:11 2001
+++ linux/kernel/slab.c      Sat Dec  1 17:35:35 2001
@@ -1572,13 +1572,11 @@
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
        CHECK_PAGE(virt_to_page(objp));
        c = GET_PAGE_CACHE(virt_to_page(objp));

And on a good day gcc may optimize out all the double tests
anyhow.

--
Alex Bligh
