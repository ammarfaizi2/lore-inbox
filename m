Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTHVW16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTHVW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:27:58 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:46853 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263488AbTHVW1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:27:45 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030822121955.619a14eb.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave> 
	<20030822121955.619a14eb.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Aug 2003 17:27:33 -0500
Message-Id: <1061591255.1784.636.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 14:19, David S. Miller wrote:
> Sparc64's alias'able caches are 1) write-through and 2) quite small.
> 
> I think I begin to see the issue clearly now.
> 
> But you cannot do the VM_SHARED change without an audit first.
> Lots of code thinks that VM_SHARED means someone maybe wrote
> to the page through a mmap().  For example look at how filemap
> sync interprets this flag bit.

Yes, the issue seems to be that the flush_dcache_page() was implemented
with the thought that the caches of the shared mappings may contain
modified data that needs to be flushed to the aliased page.

The opposite property: that the caches of the aliased page need to be
invalidated because someone else changed data in the aliased page seems
to work as a byproduct of the above implementation.

But some of the checks for !list_empty(&mapping->i_shared) are going to
prevent the necessary invalidations on read only shared mappings...which
was the initial problem.

The only issue I can see with not dropping VM_SHARED for read only
shared mappings is that we do spurious (but harmless)
flushe_dcache_page() on reads.

There also appears to be a lurking prob lem in do_mremap, where it keys
off the VM_SHARED flag to set the MAP_SHARED flag for
get_unmapped_area.  That's going to cause us a problem on parisc because
SHARED pages need to obey slightly stricter alignment constraints

All in all, I think not dropping VM_SHARED on read only shared mappings
is the right thing to do.

Do you need a more detailed audit?

James


