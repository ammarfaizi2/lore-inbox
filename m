Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268885AbTBSFFW>; Wed, 19 Feb 2003 00:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268886AbTBSFFW>; Wed, 19 Feb 2003 00:05:22 -0500
Received: from dp.samba.org ([66.70.73.150]:36323 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268885AbTBSFFV>;
	Wed, 19 Feb 2003 00:05:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: mikpe@user.it.uu.se, linux-kernel@vger.kernel.org
Subject: Re: module changes 
In-reply-to: Your message of "Tue, 18 Feb 2003 19:51:40 -0800."
             <20030218195140.27b0798f.akpm@digeo.com> 
Date: Wed, 19 Feb 2003 15:28:52 +1100
Message-Id: <20030219051523.BD7B92C28D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030218195140.27b0798f.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > The problem is that then you have to have to know whether this is a
> > per-cpu thing created in a module, or not, when you use it 8(
> > 
> > There are two things we can use to alleviate the problem.  The first
> > would be to put a minimal cap on the per-cpu data size (eg. 8k).  The
> > other possibility is to allocate on an object granularity, in which
> > case the rule becomes "no single per-cpu object can be larger than
> > XXX", but the cost is to write a mini allocator.
> > 
> 
> Is kmalloc_percpu() not suitable?

Unfortunately, no.  You have to use the same offsets as the in-kernel
DEFINE_PER_CPU declarations, meaning that each cpu's stuff needs to be
"sizeof kernel per-cpu-section" apart.

Which means an allocator which keeps a linked list of NR_CPUS * sizeof
kernel-per-cpu-section things, and allocs and frees from that.

Hence this patch just tacks it on the end of the module, rather than
deal with an allocator.  A minor improvement would be only to allocate
for the maximum possible CPU, which means about 6k * numcpus per
module which declares per-cpu data, which is probably fine.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
