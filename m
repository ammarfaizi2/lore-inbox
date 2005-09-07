Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVIGKly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVIGKly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIGKly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:41:54 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:24277 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751175AbVIGKly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:41:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Adam Petaccia <adam@tpetaccia.com>
Subject: Re: [ck] 2.6.13-ck2
Date: Wed, 7 Sep 2005 20:41:39 +1000
User-Agent: KMail/1.8.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200509052344.11665.kernel@kolivas.org> <1126031157.8117.5.camel@pimpmobile>
In-Reply-To: <1126031157.8117.5.camel@pimpmobile>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kPsHDIEso7sufis"
Message-Id: <200509072041.40153.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kPsHDIEso7sufis
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 7 Sep 2005 04:25, Adam Petaccia wrote:
> I think this patch is missing an IFDEF or something (I'm not really a
> programmer, I just like to pretend).  Anyway, I've tried building -ck2
> without swap enabled, and it failed.  Just to make sure, I make'd
> distclean, and I get the following:
>
>   LD      .tmp_vmlinux1
> mm/built-in.o: In function `zone_watermark_ok':
> mm/page_alloc.c:763: undefined reference to `delay_prefetch'
> mm/built-in.o: In function `swap_setup':
> mm/swap.c:485: undefined reference to `prepare_prefetch'
> make: *** [.tmp_vmlinux1] Error 1

Bad layout on my part.

Try this patch on top.

Cheers,
Con

--Boundary-00=_kPsHDIEso7sufis
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vm-prefetch_noswapfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-prefetch_noswapfix.patch"

Index: linux-2.6.13-ck2test/include/linux/swap.h
===================================================================
--- linux-2.6.13-ck2test.orig/include/linux/swap.h	2005-09-07 20:25:40.000000000 +1000
+++ linux-2.6.13-ck2test/include/linux/swap.h	2005-09-07 20:35:12.000000000 +1000
@@ -186,6 +186,32 @@ extern int shmem_unuse(swp_entry_t entry
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
 
+#ifdef CONFIG_SWAP_PREFETCH
+/*	mm/swap_prefetch.c */
+extern void prepare_prefetch(void);
+extern void add_to_swapped_list(unsigned long index);
+extern void remove_from_swapped_list(unsigned long index);
+extern void delay_prefetch(void);
+
+#else	/* CONFIG_SWAP_PREFETCH */
+static inline void add_to_swapped_list(unsigned long index)
+{
+}
+
+static inline void prepare_prefetch(void)
+{
+}
+
+static inline void remove_from_swapped_list(unsigned long index)
+{
+}
+
+static inline void delay_prefetch(void)
+{
+}
+
+#endif	/* CONFIG_SWAP_PREFETCH */
+
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
@@ -249,32 +275,6 @@ static inline void put_swap_token(struct
 		__put_swap_token(mm);
 }
 
-#ifdef CONFIG_SWAP_PREFETCH
-/*	mm/swap_prefetch.c */
-extern void prepare_prefetch(void);
-extern void add_to_swapped_list(unsigned long index);
-extern void remove_from_swapped_list(unsigned long index);
-extern void delay_prefetch(void);
-
-#else	/* CONFIG_SWAP_PREFETCH */
-static inline void add_to_swapped_list(unsigned long index)
-{
-}
-
-static inline void prepare_prefetch(void)
-{
-}
-
-static inline void remove_from_swapped_list(unsigned long index)
-{
-}
-
-static inline void delay_prefetch(void)
-{
-}
-
-#endif	/* CONFIG_SWAP_PREFETCH */
-
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0

--Boundary-00=_kPsHDIEso7sufis--
