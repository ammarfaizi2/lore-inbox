Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWD0LlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWD0LlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWD0LlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:41:10 -0400
Received: from mailhost.tue.nl ([131.155.2.19]:35837 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S964958AbWD0LlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:41:08 -0400
Message-ID: <4450ADCF.8040005@etpmod.phys.tue.nl>
Date: Thu, 27 Apr 2006 13:41:03 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <1146046118.7016.5.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>	 <1146049414.7016.9.camel@laptopd505.fenrus.org>	 <20060426110656.GD29108@wohnheim.fh-wedel.de>	 <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>	 <445061DC.5030008@yahoo.com.au>	 <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>	 <1146120640.2894.1.camel@laptopd505.fenrus.org>	 <20060427083157.GD3570@stusta.de>	 <1146127273.2894.21.camel@laptopd505.fenrus.org>	 <20060427085614.GE3570@stusta.de> <1146128885.2894.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1146128885.2894.27.camel@laptopd505.fenrus.org>
Content-Type: multipart/mixed;
 boundary="------------050403060107080906010809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403060107080906010809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> On Thu, 2006-04-27 at 10:56 +0200, Adrian Bunk wrote:
>> On Thu, Apr 27, 2006 at 10:41:12AM +0200, Arjan van de Ven wrote:
>>> On Thu, 2006-04-27 at 10:31 +0200, Adrian Bunk wrote:
>>>> On Thu, Apr 27, 2006 at 08:50:40AM +0200, Arjan van de Ven wrote:
>>>>> On Thu, 2006-04-27 at 09:28 +0300, Pekka J Enberg wrote:
>>>>>> On Thu, 27 Apr 2006, Nick Piggin wrote:
>>>>>>> Not to dispute your conclusions or method, but I think doing a
>>>>>>> defconfig or your personal config might be more representative
>>>>>>> of % size increase of text that will actually be executed. And
>>>>>>> that is the expensive type of text.
>>>>>> True but I was under the impression that Arjan thought we'd get text 
>>>>>> savings with GCC 4.1 by making kfree() inline.
>>>>> not savings in text size, I'll settle for the same size.
>>>>> ...
>>>> It will always be bigger since there are cases where it's unknown at 
>>>> compile time whether it will be NULL when called.
>>> if it's "unknown" you could call into a separate kfree() which does
>>> check out of line. (sure that's a dozen bytes bigger but that is
>>> noise ;)
>> It's noise and _much work.
> 
> not if the compiler can do it. The *compiler* knows a lot (4.1 at
> least)..

I would think so too. Unfortunately this is what I found for make
allyesconfig on 2.6.16.9:

   text    data     bss     dec     hex filename
21615935 7929490 2187672 31733097        1e43569 vmlinux-3.3.5-new
21616824 7929298 2187672 31733794        1e43822 vmlinux-3.3.5-old
21546713 7616546 2184984 31348243        1de5613 vmlinux-4.1.0-new
21546551 7616458 2184984 31347993        1de5519 vmlinux-4.1.0-old

Where "old" is the original one, and "new" the one with the included
patch applied. So the patch is a small win with gcc-3.3.5 and a small
loss on gcc-4.1.0. I don't really understand why 4.1.0 produces larger
code with the patch, but I triple-checked...

Groeten,
Bart




-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/

--------------050403060107080906010809
Content-Type: text/x-patch;
 name="null-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="null-check.patch"

--- linux-2.6.16.9/include/linux/slab.h	2006-04-19 08:10:14.000000000 +0200
+++ linux-2.6.16.9-kfree/include/linux/slab.h	2006-04-27 11:19:00.000000000 +0200
@@ -123,7 +123,18 @@
 	return kzalloc(n * size, flags);
 }
 
-extern void kfree(const void *);
+extern void __kfree(const void *);
+
+static inline void kfree(const void *ptr)
+{
+	if (__builtin_constant_p(ptr==NULL)) {
+		if (ptr)
+			__kfree(ptr);
+	} else {
+		__kfree(ptr);
+	}
+}
+
 extern unsigned int ksize(const void *);
 
 #ifdef CONFIG_NUMA
--- linux-2.6.16.9/mm/slab.c	2006-04-27 11:24:38.000000000 +0200
+++ linux-2.6.16.9-kfree/mm/slab.c	2006-04-27 11:17:06.000000000 +0200
@@ -3267,7 +3267,7 @@
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
- * kfree - free previously allocated memory
+ * __kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
  * If @objp is NULL, no operation is performed.
@@ -3275,7 +3275,7 @@
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
-void kfree(const void *objp)
+void __kfree(const void *objp)
 {
 	struct kmem_cache *c;
 	unsigned long flags;

--------------050403060107080906010809--
