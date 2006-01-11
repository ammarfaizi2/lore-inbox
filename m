Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWAKGZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWAKGZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWAKGZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:25:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932594AbWAKGZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:25:49 -0500
Date: Tue, 10 Jan 2006 22:25:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: cpw@sgi.com, linux-kernel@vger.kernel.org, clameter@sgi.com,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 5/5] Direct Migration V9: Avoid writeback /
 page_migrate() method
Message-Id: <20060110222527.1cfdf70b.akpm@osdl.org>
In-Reply-To: <20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
	<20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +int buffer_migrate_page(struct page *newpage, struct page *page)
>  +{
>  +	struct address_space *mapping = page->mapping;
>  +	struct buffer_head *bh, *head;
>  +
>  +	if (!mapping)
>  +		return -EAGAIN;
>  +
>  +	if (!page_has_buffers(page))
>  +		return migrate_page(newpage, page);
>  +
>  +	head = page_buffers(page);
>  +
>  +	if (migrate_page_remove_references(newpage, page, 3))
>  +		return -EAGAIN;
>  +
>  +	spin_lock(&mapping->private_lock);

Why are you taking ->private_lock here?

address_space.private_lock protects the list of buffers at
address_space.private_list.  For a regular file (or directory or long
symlink..) that list contains buffers against the blockdev mapping (a
different address_space) which need to be synced for a successful fsync of
this file.  ie: dirty metadata for this file.

So we have two situations:

a) page->mapping->host refers to a regular file/dir/etc

   Here, mapping->private_list holds potentially-dirty buffers against
   the blockdev mapping (a different address_space).

   Nothing needs to be done.

b) page->mapping->host refers to a blockdev (/dev/hda1's pages)

   Here, mapping->private_list is actually always empty.

   Nothing needs to be done.


   BUT, page_buffers(page) refers to buffers which might be on some
   other address_space's ->private_list.  Because a blockdev may have dirty
   buffers which some other address_space needs to write out for its sync.

   blockdevmapping->private_lock is the correct lock for these buffers. 
   Each regular file has a copy of blockdevmapping in its ->assoc_mapping,
   so all files end up taking the same lock when manipulating their
   ->private_list.

   As long as you've taken a ref on the blockdev mapping's buffers and
   locked them then nobody will be starting I/O against them or fiddling
   with ->b_page while you do the swizzle (I think).

AFAIK nobody ever used address_space.private_list for anything apart from
the associated buffers, but that's just a btw.

Anyway, ->private_lock is purely for protecting the thing at
->private_list, so I suspect this locking is simply unneeded.

Please explain the reasoning behind taking this lock.  In fact, that should
have been commented, in the spirit of buffer.c's glorious overcommenting,
which I'm sure you enjoyed ;)
