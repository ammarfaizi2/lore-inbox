Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUF2KlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUF2KlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUF2KlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:41:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:10129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265684AbUF2KlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:41:13 -0400
Date: Tue, 29 Jun 2004 03:40:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about dirty buffers in page cache pages
Message-Id: <20040629034010.165b0481.akpm@osdl.org>
In-Reply-To: <1088504928.16560.25.camel@imp.csi.cam.ac.uk>
References: <1088504928.16560.25.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> Hi Andrew and anyone else knowledgeable on LKML,
> 
> Given:
> - a file system (NTFS)
> - an inode on the file system
> - a mapping belonging to the inode
> - only address space operations in the mapping defined are readpage,
> sync_page, and writepage (my_writepage)
> - a page cache page in the mapping which is marked dirty
> - some buffers (perhaps all, but perhaps only some) in the page are
> marked dirty
> 
> Is it possible that write i/o is initiated on these buffers in any other
> way than through the above my_writepage?

No.  The VFS doesn't even know that the page has attached buffers.  It's
up the the a_ops to tell the VFS library functions that the thing at
page->private is a buffer_head ring.

do_writepages->generic_writepages->mpage_writepages->writepage.
pageout->writepage

> I guess the question can be also rephrased like so:  Is it possible for
> dirty buffers in an address space mapping to be written out by the
> kernel while bypassing the writepage address space operation?

In 2.4, yes.  Not in 2.6.

> Or in a different way:  Are dirty buffers in an address space entirely
> under the control of the address space operations defined by the owner
> of the address space?

yup.  There are a few VFS functions which fall through and play with the
buffer_heads if the filesystem failed to install an a_op, such as
set_page_dirty().  These exist because we never got around to editing all
the filesystems' a_ops.  But as long as the fs installs non-zero function
pointers in there, the fs is fully in control of whatever is at
page->private.
