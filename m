Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUFVTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUFVTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUFVTJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:09:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:55193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265286AbUFVTGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:06:41 -0400
Date: Tue, 22 Jun 2004 12:05:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
 do_mmap_pgoff
Message-Id: <20040622120540.1bc8b6e3.akpm@osdl.org>
In-Reply-To: <1087915399.1512.267.camel@watt.suse.com>
References: <1087837153.1512.176.camel@watt.suse.com>
	<20040621171337.44d1b636.akpm@osdl.org>
	<1087915399.1512.267.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Mon, 2004-06-21 at 20:13, Andrew Morton wrote:
> 
> > It's super-improbable because we fault the source page in by hand in
> > generic_file_aio_write_nolock() via fault_in_pages_readable().  Of course,
> > that prefaulting isn't 100% reliable either, because the VM can come in and
> > steal the page (or at least unmap its pte) before we get to doing the copy.
> > 
> > I think we can fix both problems by changing filemap_copy_from_user() and
> > filemap_copy_from_user_iovec() to not fall back to kmap() - just fail the
> > copy in some way if the atomic copy failed.  Then, in
> > generic_file_aio_write_nolock(), do a zero-length ->commit_write(),
> > put_page(), then go back and retry the whole thing, starting with
> > fault_in_pages_readable().
> 
> Oh, just realized this will break our data=ordered setup.  prepare_write
> is going to do things like allocating blocks in the file etc etc.  If we
> close the transaction via commit_write(0 size) and crash, we'll leak.

OK, then just zero the pagecache page between `from' and `to' and call
->commit_write() with unmodified `from' and `to'?

> We might need to do prefault + pin on the user pages.

That's always been the correct way to fix these problems, but it involves a
pagetable walk, which requires page_table_lock.  Not a popular thing to be
doing on the write() fastpath.
