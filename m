Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264997AbSKATme>; Fri, 1 Nov 2002 14:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSKATmd>; Fri, 1 Nov 2002 14:42:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:61845 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264997AbSKATmc>;
	Fri, 1 Nov 2002 14:42:32 -0500
Message-ID: <3DC2DAA0.A46C5085@digeo.com>
Date: Fri, 01 Nov 2002 11:48:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawel Kot <pkot@bezsensu.pl>, Rusty Russell <rusty@rustcorp.com.au>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: NTFS unresolved symbol
References: <200211010431.00941.Dieter.Nuetzel@hamburg.de> <Pine.LNX.4.33.0211011318270.5622-100000@urtica.linuxnews.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Nov 2002 19:48:48.0248 (UTC) FILETIME=[B1EB6780:01C281DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Kot wrote:
> 
> On Fri, 1 Nov 2002, Dieter [iso-8859-15] Nützel wrote:
> 
> > depmod: *** Unresolved symbols in /lib/modules/2.5.45/kernel/fs/ntfs/ntfs.o
> > depmod:         page_states__per_cpu
> > /lib/modules/2.5.45/kernel/fs/ntfs/ntfs.o
> 
> Hi, The following patch should fix it:
> --- kernel/ksyms.c~     Fri Nov  1 13:16:51 2002
> +++ kernel/ksyms.c      Fri Nov  1 13:16:51 2002
> @@ -112,6 +112,7 @@
>  EXPORT_SYMBOL(vunmap);
>  EXPORT_SYMBOL(vmalloc_to_page);
>  EXPORT_SYMBOL(remap_page_range);
> +EXPORT_SYMBOL(page_states__per_cpu);
>  #ifndef CONFIG_DISCONTIGMEM
>  EXPORT_SYMBOL(contig_page_data);
>  EXPORT_SYMBOL(mem_map);

Oh gawd.  Here's what happened..

We have these magical symbols which describe the offset of
a member of the per-cpu storage, which need to be exposed
to modules.  So I added an EXPORT_PER_CPU_SYMBOL() helper:

#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)

Which works OK without module versioning.  But with module versioning,
genksyms goes looking through source files for "EXPORT_SYMBOL".  Which
isn't there.

So sigh.  Need to go back to the drawing board on that one.  In
the meantime, this should work?


--- 25/mm/page_alloc.c~genksyms-hurts	Fri Nov  1 11:47:42 2002
+++ 25-akpm/mm/page_alloc.c	Fri Nov  1 11:47:53 2002
@@ -650,7 +650,7 @@ unsigned int nr_free_highpages (void)
  * during and after execution of this function.
  */
 DEFINE_PER_CPU(struct page_state, page_states) = {0};
-EXPORT_PER_CPU_SYMBOL(page_states);
+EXPORT_SYMBOL(page_states__per_cpu);
 
 void __get_page_state(struct page_state *ret, int nr)
 {

.
