Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUFDAFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUFDAFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFDAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:05:43 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:64765 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264928AbUFDAFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:05:33 -0400
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
In-Reply-To: <20040603085328.GB16374@elte.hu>
References: <20040602205025.GA21555@elte.hu>
	 <1086221461.29390.327.camel@bach>  <20040603085328.GB16374@elte.hu>
Content-Type: text/plain
Message-Id: <1086307478.29381.841.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 10:04:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 18:53, Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > You want to replace the arch-specific module_alloc() function for
> > this. Or even better, reset the NX bit only on executable sections (in
> > the arch-specific module_finalize(), using mod->core_text_size and
> > mod->init_text_size).  No generic changes necessary.
...
> and yet another sub-topic: when building modules we should align .rodata
> (the first non-executable section) to page boundary. This adds ~2K to
> the module size but it's not an issue i think. Data section overflows do
> happen and if it has a function pointer that can be used as a trampoline
> then we want the whole data section to be non-executable.

Yes.  It would add ~4k (if you want to do it for the init sections as
well as the core sections of the module: might not be worth it).

You can set the alignment requirement in module_frob_arch_sections(),
but beware that this alignment will only be relative to the allocation
returned by module_alloc(), so to do this you'll want module_alloc() to
return page-aligned memory.

Note the section sorting done in kernel/module.c:layout_sections(): in
particular, all executable sections are placed FIRST in the module,
which makes your life easier here.

Hope that helps!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

