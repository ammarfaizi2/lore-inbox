Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWCPFlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWCPFlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWCPFlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:41:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932433AbWCPFlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:41:02 -0500
Date: Wed, 15 Mar 2006 21:38:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Hugh@veritas.com, rdreier@cisco.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
Message-Id: <20060315213813.747b5967.akpm@osdl.org>
In-Reply-To: <1142485103.25297.13.camel@camp4.serpentine.com>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> On Wed, 2006-03-15 at 19:28 -0800, Andrew Morton wrote:
> 
> > It still has PG_reserved set.  I'd suggest you simply not set PG_reserved
> > on these pages.
> 
> I made that change; thanks to you and Linus for suggesting it.
> 
> It caused progress of a sort to occur.  This time, we made it through
> mmput (the earlier crash site) and tripped over our shoelaces a bit
> later during process exit:
> 
>         Bad page state at __free_pages_ok (in process 'mpi_hello', page ffff8100020e2f88)
>         flags:0x0100000000000804 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)

Someone left PG_private set on this page (!)

> 
> > hm.  Are these pages supposed to be owned by the userspace process?  To have their
> > lifetime controlled by that process?
> 
> We have two different sets of pages.  Some we want to keep around for as
> long as a device is plugged in, so the driver should continue to own
> them after a user process exits.
> 
> Other pages should only live as long as the process that has them
> mmapped, but at the moment our driver is (perhaps mistakenly?)
> explicitly freeing them as part of fops->close.
> 
> I am quite unclear in my head on what mechanism to use to manage the
> lifetimes of these pages.

You need to decide who "owns" these pages.  Once that's decided, it tells
you who should release them.

> Should I use get_page on the pages that span
> multiple process lifetimes, and let whatever cleans up the process's
> mappings handle the pages that should go away with the process?  Is it
> even safe to do that, if I allocated them with dma_alloc_coherent
> instead of kmalloc?
> 

Pages which the driver owns should be owned by the, umm, driver.  The
driver allocates them, tracks their status, does a put_page() when it's
done with them.  Processes might temporarily take a ref on them, in which
case in rare circustances it's the process who does the final put_page(),
but conceptually the driver is still managing these pages.

If the process "owns" these pages then they get allocated in ->nopage and
they get freed in exit(), munmap(), mremap(), etc.  ->nopage() should not
take a ref on a page if ->nopage() just allocated it (major fault)
(alloc_pages() did that).  If ->nopage finds that the page already exists
(minor fault) then it should take a ref on it.  If the driver needs to
temporarily access these pages then it should do a temporary
get_page()/put_page() to protect itself from a concurrent
munmap()/exit()/etc.

If you have pages which are created by ->nopage() but which are supposed to
be shared across forks (the VMA should use VM_DONTCOPY|VM_SHARED) then each
time a new process starts accessing these already-existing pages it'll take
a minor fault.  Your ->nopage handler should locate the page by some means,
take a ref on it then return it.  do_no_page() will then make the process's
pte map the now-shared page and all is happy.  Once all processes which have
faulted in a page have let go of it again (each pte whcih maps that page
has a ref on it which gets undone in munmap/exit/etc), the page will get
freed.

So...

mmap(): set VM_DONTCOPY on VMA, possibly fail if the caller didn't set
VM_SHARED.

nopage(): if the page exists, take a ref on it.  If it didn't, allocate it.
Return page.


Approximately.  Let's wait for Hugh to come along and clean up my mess.
