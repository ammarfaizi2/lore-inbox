Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUDTHYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUDTHYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDTHYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:24:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:57772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbUDTHYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:24:46 -0400
Date: Tue, 20 Apr 2004 00:24:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: andrea@suse.de, agruen@suse.de, linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
Message-Id: <20040420002423.469cca01.akpm@osdl.org>
In-Reply-To: <4084017C.5080706@colorfullife.com>
References: <1082383751.6746.33.camel@f235.suse.de>
	<20040419162533.GR29954@dualathlon.random>
	<4084017C.5080706@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> > No best-guess must
>  >be made automatically by the slab code, rounding it to 16 bytes.
>  >
>  If you pass 0 as align to kmem_cache_create, then it's rounded to L2 
>  size. It's questionable if that's really the best thing - on 
>  uniprocessor, 16-byte might result is better performance - there is no 
>  risk of false sharing.

Just about every time we've cared to investigate slab alignment, we've
ended up removing SLAB_HWCACHE_ALIGN.  It seems inappropriate that _any_ of
the inode caches have this set, for example.

And this patch appears to have taken the effective size of the buffer_head
from 48 bytes up to 64, which hurts.

So I do think that we should either make "align=0" translate to "pack them
densely" or do the big sweep across all kmem_cache_create() callsites.

If the latter, while we're there, let's remove SLAB_HWCACHE_ALIGN where it
isn't obviously appropriate.  I'd imagine that being able to fit more inodes
into memory is a net win over the occasional sharing effect, for example.
