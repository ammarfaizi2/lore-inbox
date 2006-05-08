Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWEHPMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWEHPMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEHPMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:12:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWEHPMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:12:44 -0400
Date: Mon, 8 May 2006 08:12:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 May 2006, Pekka Enberg wrote:
> 
> On 5/8/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > page_get_cache and page_get_slab are too late. You would need to do
> > the check in __cache_free; otherwise the stack pointer goes to per-CPU
> > caches and can be given back by kmalloc(). Adding PageSlab debugging
> > to __cache_free is probably too much of a performance hit, though.
> 
> Btw, CONFIG_DEBUG_SLAB should catch this case, see kfree_debugcheck()
> for details.

Yeah, but CONFIG_DEBUG_SLAB is _really_ expensive. 

We do have a lot of very basic debug checks (unconditionally) in the 
kernel to verify various "must be true" kinds of things. It might slow 
things down a bit, but in general, I think anything that helps catch 
problems early tends to pay itself back very quickly. So I'm more than 
happy with a simple BUG_ON() in even a hot path, if it just ends up being 
compiled into a "test and branch to unlikely" and doesn't need any costly 
locking etc around it.

Fedora had DEBUG_SLAB enabled in their development kernel, and that 
actually helped a lot. But I suspect they may _not_ have it in their 
non-development ones, and those have a much bigger test-base, so it might 
well be worth it to have a good base-line that catches serious problems, 
and have DEBUG_SLAB enable the expensive tests.

It's not like trying to free a non-kmalloc'ed pointer is a really strange 
event. malloc/free bugs are some of the most common serious problems in 
user space, and I suspect they are _less_ common in the kernel, but 
still..

		Linus
