Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSIXIN0>; Tue, 24 Sep 2002 04:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbSIXIN0>; Tue, 24 Sep 2002 04:13:26 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23557 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261609AbSIXIN0>; Tue, 24 Sep 2002 04:13:26 -0400
Message-Id: <200209240813.g8O8DWp24815@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] streq()
Date: Tue, 24 Sep 2002 11:07:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2002 03:40, Ingo Molnar wrote:
> On Tue, 24 Sep 2002, Rusty Russell wrote:
> there's a few more places that tend to cause wasted time, no matter what:
>  - kmalloc(size, flags)/gfp(order, flags) argument ordering. A few months
>    ago i wasted two days on such a bug - since 'size' was very small
>    usually, it never showed up that the allocated buffer was short, until
>    some rare load-test increased the 'size'.

Aughment kmalloc(size, GFP_XXXXX) with kmalloc_XXXXX(size) (inline of course)?
You may use this form in those 90% cases where flags are constant.

This also gets rid of GFP_ prefixes (shorter).

Ingo, Rusty?
--
vda

--- linux-2.5.36/include/linux/slab.h.orig Tue Sep 24 11:00:42 2002
+++ linux-2.5.36/include/linux/slab.h      Tue Sep 24 11:06:32 2002
@@ -61,6 +61,15 @@

 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
+extern inline void *kmalloc_NOHIGHIO(size_t sz) { return kmalloc(sz, GFP_NOHIGHIO); }
+extern inline void *kmalloc_NOIO    (size_t sz) { return kmalloc(sz, GFP_NOIO    ); }
+extern inline void *kmalloc_NOFS    (size_t sz) { return kmalloc(sz, GFP_NOFS    ); }
+extern inline void *kmalloc_ATOMIC  (size_t sz) { return kmalloc(sz, GFP_ATOMIC  ); }
+extern inline void *kmalloc_USER    (size_t sz) { return kmalloc(sz, GFP_USER    ); }
+extern inline void *kmalloc_HIGHUSER(size_t sz) { return kmalloc(sz, GFP_HIGHUSER); }
+extern inline void *kmalloc_KERNEL  (size_t sz) { return kmalloc(sz, GFP_KERNEL  ); }
+extern inline void *kmalloc_NFS     (size_t sz) { return kmalloc(sz, GFP_NFS     ); }
+extern inline void *kmalloc_KSWAPD  (size_t sz) { return kmalloc(sz, GFP_KSWAPD  ); }

 extern int FASTCALL(kmem_cache_reap(int));

