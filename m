Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWCPGUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCPGUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCPGUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:20:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751325AbWCPGUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:20:03 -0500
Date: Wed, 15 Mar 2006 22:17:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: bos@pathscale.com, Hugh@veritas.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
Message-Id: <20060315221716.19a92762.akpm@osdl.org>
In-Reply-To: <ada8xrbszmx.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<ada8xrbszmx.fsf@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> wrote:
>
>     Andrew> Someone left PG_private set on this page (!)
> 
> How does PG_private get set?  Could doing a > 1 page kmalloc set it
> (because we end up with a compound page)?

I can only think that Brian went and set it.

>     Andrew> You need to decide who "owns" these pages.  Once that's
>     Andrew> decided, it tells you who should release them.
> 
>     [... really good guide to mapping pages into userspace snipped ...]
> 
> How about the case where one wants to map pages from
> dma_alloc_coherent() into userspace?  It seems one should do
> get_page() in .nopage, and then the driver can do dma_free_coherent()
> when the vma is released.

Well, where were the pages allocated?  mmap()?  In that case the pages
might be considered driver-owned and yes, I guess the right place to free
them would be in the file's ->release() method.  (Sorry to sound vague, but
I haven't really worked on this stuff for a couple of years, and Hugh keeps
on megachanging it).

Lots of sound drivers do this sort of thing for their capture buffers - you
could check them to see what (or, knowing sound drivers, what not) to do.

> Or maybe it's just simpler to use vm_insert_page() in the .mmap method
> and not try to be fancy with .nopage?
> 

One would need to work out what to do with these pages when they're shared,
after a fork - a ->nopage() handler would still be needed there, assuming
the VMA is marked VM_DONTCOPY.  Because we don't copy all the pte's on a
VM_DONTCOPY vma at fork()-time.  (I think we _could_, but we don't)

vm_insert_page() mucks around with rmap-named functions which don't
actually do rmap and sports apparently-incorrect comments wrt
PageReserved().  I don't know how well-cared-for it is...
