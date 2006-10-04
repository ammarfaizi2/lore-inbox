Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWJDXzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWJDXzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWJDXzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:55:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751241AbWJDXzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:55:24 -0400
Date: Wed, 4 Oct 2006 16:55:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061004165504.c1dd3dd3.akpm@osdl.org>
In-Reply-To: <x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org>
	<4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org>
	<45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 16:53:53 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> The man page for open states:
> 
>        O_DIRECT
>               Try to minimize cache effects of the I/O to and from this file.
> 
> I think that invalidating the page cache pages we use when falling back to
> buffered I/O stays true to the above description.

What the manpage forgot to mention is "direct-io is synchronous".

Except it isn't, when we fall back to buffered-IO.  So yup, I think we
could justify this (sort of) change on those grounds alone: preserving the
synchronous semantics.

I'd propose that we do this via

	generic_file_buffered_write(...);
	do_sync_file_range(..., SYNC_FILE_RANGE_WAIT_BEFORE|
			SYNC_FILE_RANGE_WRITE|
			SYNC_FILE_RANGE_WAIT_AFTER)

	invalidate_mapping_pages(...);

There is a slight inefficiency here: generic_file_direct_IO() does
invalidate_inode_pages2_range(), then we go and instantiate some pagecache,
then we strip it away again with invalidate_mapping_pages().  That first
invalidate_inode_pages2_range() was somewhat of a waste of cycles.

But we expect that the next call to generic_file_direct_IO() won't actually
call invalidate_inode_pages2_range(), because mapping->nrpages is usually
zero.

Well, it would have been, back in the days when we were invalidating the
whole file.  Now are more efficient and we only invalidate the specific
segment of that file.  So if there's a stray pagecache page somewhere at the
far end ofthe file, we'll pointlessly call invalidate_inode_pages2_range() every
time.  Oh well.

