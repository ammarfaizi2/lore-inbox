Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266307AbUFVAKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266307AbUFVAKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUFVAKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 20:10:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:58498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266307AbUFVAKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 20:10:51 -0400
Date: Mon, 21 Jun 2004 17:13:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
 do_mmap_pgoff
Message-Id: <20040621171337.44d1b636.akpm@osdl.org>
In-Reply-To: <1087837153.1512.176.camel@watt.suse.com>
References: <1087837153.1512.176.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> do_mmap_pgoff is called with a write lock on mmap_sem, and can trigger
> calls to generic_file_mmap, which calls file_accessed to update the
> atime on the file.
> 
> For reiserfs, this might start a transaction, which might have to wait
> for the currently running transaction to finish.  It looks like ext3 may
> do the same thing, but I'm not 100% sure on that.
> 
> If the currently running transaction happens to by running
> copy_from_user, like we do during write calls, it might be trying to get
> a hold of a read lock on the mmap sem while trying to hand page faults.

heh, good luck writing a testcase.

It's super-improbable because we fault the source page in by hand in
generic_file_aio_write_nolock() via fault_in_pages_readable().  Of course,
that prefaulting isn't 100% reliable either, because the VM can come in and
steal the page (or at least unmap its pte) before we get to doing the copy.

I think we can fix both problems by changing filemap_copy_from_user() and
filemap_copy_from_user_iovec() to not fall back to kmap() - just fail the
copy in some way if the atomic copy failed.  Then, in
generic_file_aio_write_nolock(), do a zero-length ->commit_write(),
put_page(), then go back and retry the whole thing, starting with
fault_in_pages_readable().



