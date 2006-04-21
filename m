Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWDUN4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWDUN4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDUN4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:56:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54746 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932311AbWDUN4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:56:35 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kfree(NULL)
Date: Fri, 21 Apr 2006 06:56:39 -0700
User-Agent: KMail/1.8.3
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> <Pine.LNX.4.64.0604210322110.21429@d.namei> <20060421015412.49a554fa.akpm@osdl.org>
In-Reply-To: <20060421015412.49a554fa.akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604210656.40158.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 01:54, you wrote:
> James Morris <jmorris@namei.org> wrote:
> > On Fri, 21 Apr 2006, Daniel Walker wrote:
> > > 	I included a patch , not like it's needed . Recently I've been
> > > evaluating likely/unlikely branch prediction .. One thing that I found
> > > is that the kfree function is often called with a NULL "objp" . In fact
> > > it's so frequent that the "unlikely" branch predictor should be
> > > inverted! Or at least on my configuration.
> >
> > It would be helpful to collect some stats on this so we can look at the
> > ratio.
>
> Yes, kfree(NULL) is supposed to be uncommon.  If someone's doing it a lot
> then we should fix up the callers.

Part of the reason it gets done a lot is because some developers on this list 
have told others NOT to check for NULL before calling kfree because kfree 
does that internally.  I was told that.  I can't remember who told me though.

Maybe kfree should really be a wrapper around __kfree which does the real 
work.  Then kfree could be a inlined function or a #define that does the NULL 
pointer check.  Something like the patch below.  This has the advantage of 
both worlds.  If you know your pointer is NULL, call __kfree.  If you are not 
sure and would check anyway, the inline version of kfree checks for you and 
then calls __kfree.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

--- a/include/linux/slab.h  2006-03-19 21:53:29.000000000 -0800
+++ b/include/linux/slab.h  2006-04-21 07:47:32.000000000 -0700
@@ -123,7 +123,14 @@ static inline void *kcalloc(size_t n, si
    return kzalloc(n * size, flags);
 }

-extern void kfree(const void *);
+extern void __kfree(const void *);
+static inline void kfree(const void *obj)
+{
+   if (!obj)
+       return;
+   __kfree(obj);
+}
+
 extern unsigned int ksize(const void *);

 #ifdef CONFIG_NUMA
--- a/mm/slab.c 2006-04-21 07:49:42.000000000 -0700
+++ b/mm/slab.c 2006-04-21 07:49:56.000000000 -0700
@@ -3275,13 +3275,11 @@ EXPORT_SYMBOL(kmem_cache_free);
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
-void kfree(const void *objp)
+void __kfree(const void *objp)
 {
    struct kmem_cache *c;
    unsigned long flags;
 
-   if (unlikely(!objp))
-       return;
    local_irq_save(flags);
    kfree_debugcheck(objp);
    c = virt_to_cache(objp);
@@ -3289,7 +3287,7 @@ void kfree(const void *objp)
    __cache_free(c, (void *)objp);
    local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(__kfree);
 
 #ifdef CONFIG_SMP
 /**

