Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271124AbUJVASh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271124AbUJVASh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271130AbUJVAR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:17:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:15008 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271150AbUJVANI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:13:08 -0400
Date: Thu, 21 Oct 2004 17:15:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrea@novell.com, shaggy@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041021171558.3214cea4.akpm@osdl.org>
In-Reply-To: <20041021164245.4abec5d2.akpm@osdl.org>
References: <1098393346.7157.112.camel@localhost>
	<20041021144531.22dd0d54.akpm@osdl.org>
	<20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
	<20041021164245.4abec5d2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I don't get it.  invalidate has the pageframe.  All it need to do is to
> lock the page, examine mapcount and if it's non-zero, do the shootdown. 

unmap_mapping_range() will do that - can call it one page at a time, or
batch up runs of pages.  It's not fast, but presumably not frequent either.

The bigger problem is shooting down the buffer_heads.  It's certainly the
case that mpage_readpage() will call block_read_full_page() which will then
bring the page uptodate without performing any I/O.

And invalidating the buffer_heads in invalidate_inode_pages2() is tricky -
we need to enter the filesystem and I'm not sure that either
->invalidatepage() or ->releasepage() are quite suitable.  For a start,
they're best-effort and may fail.  If we just go and mark the buffers not
uptodate we'll probably give ext3 a heart attack, so careful work would be
needed there.

Let's go back to why we needed all of this.  Was it just for the NFS
something-changed-on-the-server code?  If so, would it be sufficient to add
a new invalidate_inode_pages3() just for NFS, which clears the uptodate
bit?  Or something along those lines?

