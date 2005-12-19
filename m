Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVLSKVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVLSKVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVLSKVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:21:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932718AbVLSKVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:21:08 -0500
Date: Mon, 19 Dec 2005 02:20:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2 - kzalloc() considered harmful for debugging.
Message-Id: <20051219022059.36443421.akpm@osdl.org>
In-Reply-To: <200512181258.jBICwMdj003410@turing-police.cc.vt.edu>
References: <200512181258.jBICwMdj003410@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> So I've got a (probably self-inflicted) memory leak in slab-64 and slab-32.
> Rebuild the kernel with CONFIG_DEBUG_SLAB, reboot, and wait for a bit of
> leak to pile up, and then echo 'slab-32 0 0 0' > /proc/slabinfo
> 
> And ta-DA! the top offender is... (drum roll): <kzalloc+0xe/0x36>
> 
> Blargh.  It's tempting to do something like this in include/linux/slab.h:
> 
> #ifdef CONFIG_SLAB_DEBUG
> static inline void* kzalloc(size_t size, gfp_t flags)
> {
>         void *ret = kmalloc(size, flags);
>         if (ret)
>                 memset(ret, 0, size);
>         return ret;
> }
> #else
> extern void *kzalloc(size_t, gfp_t);
> #end

That would work.

Or we could special-case kzalloc() and kstrdup() in slab.c - use
builtin_return_address(1) if builtin_return_address(0) is within those
functions.  Dunno if that's worth the fuss though.
