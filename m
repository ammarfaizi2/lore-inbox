Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265402AbUFCAMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbUFCAMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUFCAMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:12:09 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:20465 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S265402AbUFCAMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:12:00 -0400
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
	2.6.7-rc2-bk2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
In-Reply-To: <20040602205025.GA21555@elte.hu>
References: <20040602205025.GA21555@elte.hu>
Content-Type: text/plain
Message-Id: <1086221461.29390.327.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 10:11:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 06:50, Ingo Molnar wrote:
> furthermore, the patch also implements 'NX protection' for kernelspace
> code: only the kernel code and modules are executable - so even

No, actually, it doesn't quite do that:

--- linux/kernel/module.c.orig	
+++ linux/kernel/module.c	
@@ -1431,7 +1431,7 @@ static struct module *load_module(void _
 
 	/* Suck in entire file: we'll want most of it. */
 	/* vmalloc barfs on "unusual" numbers.  Check here */
-	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
+	if (len > 64 * 1024 * 1024 || (hdr = vmalloc_exec(len)) == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (copy_from_user(hdr, umod, len) != 0) {
 		err = -EFAULT;

This is where we such the module file into kernel memory to parse it,
not where we actually copy the memory.

You want to replace the arch-specific module_alloc() function for this.
Or even better, reset the NX bit only on executable sections (in the
arch-specific module_finalize(), using mod->core_text_size and
mod->init_text_size).  No generic changes necessary.

What surprises me is that this error didn't cause your kernel to explode
the moment you inserted a module containing a function...

Hope that helps!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

