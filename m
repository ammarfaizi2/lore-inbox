Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUD3UWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUD3UWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUD3UWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:22:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:54407 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265250AbUD3UV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:21:58 -0400
Date: Fri, 30 Apr 2004 13:24:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: mikpe@csd.uu.se, ak@suse.de, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Message-Id: <20040430132410.4007b711.akpm@osdl.org>
In-Reply-To: <200404302133.05387.rjwysocki@sisk.pl>
References: <200404301611.i3UGBkdK026345@harpo.it.uu.se>
	<20040430112704.3dca3c4c.akpm@osdl.org>
	<200404302133.05387.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> > Does this fix?
> >
> > diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> > --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> > +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> > @@ -20,6 +20,8 @@
> >  #include <asm/mmsegment.h>
> >  #include <linux/personality.h>
> >
> > +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
> > +
> >  #define TF_MASK		0x00000100
> >  #define IF_MASK		0x00000200
> >  #define IOPL_MASK	0x00003000
> >
> 
> AFAICS, yes, it does. :-)
> I'm now (happily) running 2.6.6-rc3 on a dual-Opteron box.

OK, thanks.  I suspect that change has broken other architectures for the
same reason.

I think I'll just change the default:

 
diff -puN kernel/fork.c~task-struct-alignment-fix kernel/fork.c
--- 25/kernel/fork.c~task-struct-alignment-fix	Fri Apr 30 13:22:24 2004
+++ 25-akpm/kernel/fork.c	Fri Apr 30 13:22:36 2004
@@ -211,7 +211,7 @@ void __init fork_init(unsigned long memp
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
 #ifndef ARCH_MIN_TASKALIGN
-#define ARCH_MIN_TASKALIGN	0
+#define ARCH_MIN_TASKALIGN	L1_CACHE_BYTES
 #endif
 	/* create a slab on which task_structs can be allocated */
 	task_struct_cachep =

_

