Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUFVOnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUFVOnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUFVOnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:43:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:39137 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264067AbUFVOm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:42:28 -0400
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040621171337.44d1b636.akpm@osdl.org>
References: <1087837153.1512.176.camel@watt.suse.com>
	 <20040621171337.44d1b636.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087915399.1512.267.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 10:43:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 20:13, Andrew Morton wrote:

> It's super-improbable because we fault the source page in by hand in
> generic_file_aio_write_nolock() via fault_in_pages_readable().  Of course,
> that prefaulting isn't 100% reliable either, because the VM can come in and
> steal the page (or at least unmap its pte) before we get to doing the copy.
> 
> I think we can fix both problems by changing filemap_copy_from_user() and
> filemap_copy_from_user_iovec() to not fall back to kmap() - just fail the
> copy in some way if the atomic copy failed.  Then, in
> generic_file_aio_write_nolock(), do a zero-length ->commit_write(),
> put_page(), then go back and retry the whole thing, starting with
> fault_in_pages_readable().

Oh, just realized this will break our data=ordered setup.  prepare_write
is going to do things like allocating blocks in the file etc etc.  If we
close the transaction via commit_write(0 size) and crash, we'll leak.

We might need to do prefault + pin on the user pages.

-chris


