Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752283AbWKBTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbWKBTNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWKBTNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:13:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752283AbWKBTNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:13:16 -0500
Date: Thu, 2 Nov 2006 11:13:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: Franck <vagabon.xyz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH update6] drivers: add LCD support
Message-Id: <20061102111311.1b2648c3.akpm@osdl.org>
In-Reply-To: <653402b90611020644m57dac018r443fc91bccf6db0c@mail.gmail.com>
References: <20061101014057.454c4f43.maxextreme@gmail.com>
	<4549B19C.70304@innova-card.com>
	<653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
	<454A0006.4090505@innova-card.com>
	<653402b90611020644m57dac018r443fc91bccf6db0c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 14:44:56 +0000
"Miguel Ojeda" <maxextreme@gmail.com> wrote:

> > Sorry for the short/fast question. I'm wondering how does the cache
> > behave here. You have 2 virtual addresses that point to the same
> > location in physical RAM: kernel frame buffer which has a kernel
> > virtual address and the vma you're returning when an application mmap
> > the device. This last address is a user virtual address and is
> > different from the first one.
> >
> > Now let's say that some of the kernel frame buffer data are in the
> > data cache and never be invalidate during this example. The
> 
> Sorry, I don't understand what do you mean with this sentence.

Some CPU architectures experience what Documentation/cachetlb.txt calls
"virtual aliasing in the data cache".

If you map the same physical page at virtual address A1 and also at another
virtual address A2 then writes to address A1 do not necessarily appear
correctly at address A2.  This because the write to A1 is stuck in the CPU
cache and the CPU hardware doesn't know that read from A2 is accessing the
same page.

The solutions to this are:

a) add lots of flushing everywhere (see Documentation/cachetlb.txt, I
   guess) (this documentation is maddening: it uses the term "flush" for
   both writeback and for invalidation.  In this context,
   flush==writeback).

b) If you select the correct virtual addresses for A1 and A2 (ie: ensure
   that the mmap() handler returns an address which correlates with the
   page's kernel address) then apparently the aliasing goes away.

   So, for example, if the kernel's view of the page is at 0xd0102000
   then you make sure that userspace's address for the page is at
   0xnnn02000 (for some length of nnn).

   I don't know what the mmap handler has to do to arrange for this to
   happen.

c) add `depends on x86' to your Kconfig ;)


davem and rmk are (amongst others) the guys for this stuff.  afaik it isn't
documented anywhere.

