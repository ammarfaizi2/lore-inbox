Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTHVT1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTHVT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:27:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:435 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263378AbTHVT10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:27:26 -0400
Date: Fri, 22 Aug 2003 12:19:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: hugh@veritas.com, willy@debian.org, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822121955.619a14eb.davem@redhat.com>
In-Reply-To: <1061578568.2053.313.camel@mulgrave>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003 13:56:06 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Fri, 2003-08-22 at 13:31, David S. Miller wrote:
> > On Fri, 22 Aug 2003 19:34:41 +0100 (BST)
> > Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > > And to me.  If VM_SHARED is set, then __vma_link_file puts the vma on
> > > on i_mmap_shared.  If VM_SHARED is not set, it puts the vma on i_mmap.
> > > flush_dcache_page treats i_mmap_shared and i_mmap lists equally.
> > 
> > But file system page cache writes only call flush_dache_page()
> > if the page has a non-empty i_mmap_shared list.
> 
> Hmm, but if it does that then the glibc bug test should show up on sparc
> because the i_mmap_shared list is empty if we only do MAP_SHARED of read
> only files.

Sparc64's alias'able caches are 1) write-through and 2) quite small.

I think I begin to see the issue clearly now.

But you cannot do the VM_SHARED change without an audit first.
Lots of code thinks that VM_SHARED means someone maybe wrote
to the page through a mmap().  For example look at how filemap
sync interprets this flag bit.
