Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKAWSX>; Fri, 1 Nov 2002 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265792AbSKAWSX>; Fri, 1 Nov 2002 17:18:23 -0500
Received: from dp.samba.org ([66.70.73.150]:33673 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265787AbSKAWST>;
	Fri, 1 Nov 2002 17:18:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: Pawel Kot <pkot@bezsensu.pl>, torvalds@transmeta.com
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: NTFS unresolved symbol 
In-reply-to: Your message of "Fri, 01 Nov 2002 11:48:48 -0800."
             <3DC2DAA0.A46C5085@digeo.com> 
Date: Sat, 02 Nov 2002 09:24:05 +1100
Message-Id: <20021101222448.F11852C445@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DC2DAA0.A46C5085@digeo.com> you write:
> > +EXPORT_SYMBOL(page_states__per_cpu);

> Which works OK without module versioning.  But with module versioning,
> genksyms goes looking through source files for "EXPORT_SYMBOL".  Which
> isn't there.

Proper fix below.  Linus please apply.

The source is run through CPP before hitting genksyms (which is why
the #define EXPORT_SYMBOL is under #ifndef __GENKSYMS__).  So in fact,
"EXPORT_SYMBOL( page_states__per_cpu) ;" gets to kenksyms.  But your
fix doesn't work either: genksyms can't handle the __typeof__ in the
definition it sees, and gives up.

Note, that this fix (almost certainly) breaks:
	DEFINE_PER_CPU(int[3], myvar);
	EXPORT_PER_CPU_SYMBOL(myvar);

But we'd need to teach genksyms about EXPORT_PER_CPU_SYMBOL or
__typeof__ for that[1]

Rusty.
[1] Proving the point about the separation of that from the kernel
    source being wrong.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.45/include/asm-generic/percpu.h working-2.5.45-tmp/include/asm-generic/percpu.h
--- linux-2.5.45/include/asm-generic/percpu.h	2002-10-31 12:36:56.000000000 +1100
+++ working-2.5.45-tmp/include/asm-generic/percpu.h	2002-11-02 09:20:06.000000000 +1100
@@ -35,4 +35,10 @@ extern unsigned long __per_cpu_offset[NR
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
 
+/* Genksyms can't follow the percpu declaration.  Give it a fake one. */
+#ifdef __GENKSYMS__
+#undef DEFINE_PER_CPU
+#define DEFINE_PER_CPU(type, name) type name##__per_cpu
+#endif /*__GENKSYMS__*/
+
 #endif /* _ASM_GENERIC_PERCPU_H_ */
