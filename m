Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTHVQXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTHVQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:23:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263348AbTHVQWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:22:14 -0400
Date: Fri, 22 Aug 2003 09:14:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on
 parisc)
Message-Id: <20030822091447.6ecea6ca.davem@redhat.com>
In-Reply-To: <1061563239.2090.25.camel@mulgrave>
References: <1061563239.2090.25.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003 09:40:37 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> This test essentially opens a file (via open(2)), writes something,
> opens it via a mmaped file object *read only* (via fopen(...,"rm)) reads
> what was writtent, writes some more and reads it via the mmaped file
> object.
> 
> This last read fails to get the data on parisc.  The problem is that our
> CPU cache is virtually indexed, and the page the write is storing the
> data to (in the buffer cache) and the page it is mmapped to have the
> same physical, but different virtual addresses.  We need the write() to
> trigger a cache update via flush_dcache_page to get the virtually
> indexed cache in sync.
> 
> The reason this doesn't happen is because the mapping is not on the
> mmap_shared list that flush_dcache_page() updates.

flush_dcache_page() checks both the shared and non-shared mmap lists,
so if it is on _either_ list it is flushed.  It does not check only
the shared list.

The VM_SHARED change you are proposing is definitely wrong.
