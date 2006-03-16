Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWCPPIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWCPPIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCPPIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:08:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52922 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751216AbWCPPIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:08:43 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh@veritas.com, rdreier@cisco.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060315213813.747b5967.akpm@osdl.org>
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
Content-Type: text/plain
Date: Thu, 16 Mar 2006 07:08:38 -0800
Message-Id: <1142521718.25297.37.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 21:38 -0800, Andrew Morton wrote:

> >         Bad page state at __free_pages_ok (in process 'mpi_hello', page ffff8100020e2f88)
> >         flags:0x0100000000000804 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)
> 
> Someone left PG_private set on this page (!)

I can't tell you how that happened.  I'm certainly not explicitly
setting it anywhere.  Apart from PG_reserved (now gone, as seen above),
I don't touch any page flags.

> Pages which the driver owns should be owned by the, umm, driver.  The
> driver allocates them, tracks their status, does a put_page() when it's
> done with them.

This is more or less what we're doing now.  Except we're not doing a
get_page after dma_alloc_coherent, and vmops->nopage is doing a
get_page.  Reading between the lines, I guess the driver should be doing
a get_page right after the allocation, and a put_page before it does the
free?  This matches my mental model at least, but it seems that my model
is a bit mental.

> If the process "owns" these pages then they get allocated in ->nopage and
> they get freed in exit(), munmap(), mremap(), etc.

OK, we don't have any cases like this.

> If you have pages which are created by ->nopage() but which are supposed to
> be shared across forks (the VMA should use VM_DONTCOPY|VM_SHARED) then each
> time a new process starts accessing these already-existing pages it'll take
> a minor fault.

And we don't have any cases like this either.  All of these mappings are
per-process, not to be shared across fork or clone.

Thanks,

	<b

