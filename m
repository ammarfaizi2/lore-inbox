Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUICBUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUICBUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269481AbUICBSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:18:55 -0400
Received: from ozlabs.org ([203.10.76.45]:16546 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269488AbUICBOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:14:11 -0400
Subject: Re: Oops in percpu_modalloc in 2.6.9-rc1-mm1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901233556.6456ea9a@lembas.zaitcev.lan>
References: <20040831214659.2471c043.akpm@osdl.org>
	 <1094016105.17835.50.camel@bach>
	 <20040901233556.6456ea9a@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1094125902.17005.40.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 11:10:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 16:35, Pete Zaitcev wrote:
> On Wed, 01 Sep 2004 15:21:45 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > Pete, can you figure out what module it is which goes boom, send me the
> > .ko file, and tell me the value of CONFIG_X86_L1_CACHE_SHIFT?
> 
> Two modules have percpu data segment: net/ipv4/netfilter/ipchains.o
> and net/ipv4/netfilter/ip_conntrack_core.o.
> The CONFIG_X86_L1_CACHE_SHIFT is 4.

...

>  12 .data         000006e4  00000000  00000000  0000ba20  2**5
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  13 .data.percpu  0000003c  00000000  00000000  0000c120  2**5
>                   CONTENTS, ALLOC, LOAD, DATA

Well, here's the problem.  alloc_bootmem will return something
SMP_CACHE_BYTES aligned, so we can't meet this.  If we knew in advance
what the alignment requirements were, we could do so.

Note also, that archs currently use vmalloc() or variants for
module_alloc, but they could easily use kmalloc() for small sizes.  This
would make your life painful, since kmalloc() also returns L1
cache-aligned memory.

I'd suggest that for a 486 configuration, GCC shouldn't be asking for
32-byte alignment for anything.  Still, we probably have to remove the
BUG_ON and simply accept that alignment > SMP_CACHE_BYTES is actually
taking pot luck (depends if the original allocation was aligned).

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

