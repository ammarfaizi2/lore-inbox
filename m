Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUDTSwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUDTSwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUDTSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:52:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:46250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263088AbUDTSw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:52:28 -0400
Date: Tue, 20 Apr 2004 11:52:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Manfred Spraul <manfred@colorfullife.com>, andrea@suse.de, agruen@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
In-Reply-To: <20040420112556.400ea49e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404201146560.1775@ppc970.osdl.org>
References: <1082383751.6746.33.camel@f235.suse.de> <20040419162533.GR29954@dualathlon.random>
 <4084017C.5080706@colorfullife.com> <20040420002423.469cca01.akpm@osdl.org>
 <20040420144937.GG29954@dualathlon.random> <40855C97.1090006@colorfullife.com>
 <20040420112556.400ea49e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Apr 2004, Andrew Morton wrote:
> 
> But why would you choose to make the "SLAB_HWCACHE_ALIGN clear" case use
> sizeof(void*) rather than sizeof(int)?

Because a lot of architectures will cause unaligned faults on structures 
that have pointers (or long's) in them if they are only aligned to "int"?

So "int"-aligned is no better than "char" alignment.

I suspect we should make the "minimum normal alignment" be architecture-
dependent, since some architectures can have even stricter requirements
(ie they may have compilers that assume 64-bit alignment for doing things
like multi-word loads).

My suggestion:

 - if explicit alignment is passed in (non-zero), always use that. The 
   user knows best.

   This allows a user to specify unaligned ("byte alignment", aka
   "align=1") if he wants to.

 - if the passed-in alignment was zero, use a CPU-specific alignment which 
   will depend on SLAB_HWCACHE_ALIGN, and will _usually_ be something like

	align = (flags & SLAB_HWCACHE_ALIGN) ? cachelinesize : sizeof(ptr);

   but some architecture might choose to do something different here.

Wouldn't that make everybody happy.

			Linus
