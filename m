Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264995AbTFLUkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbTFLUkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:40:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:14771 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264995AbTFLUj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:39:57 -0400
Date: Thu, 12 Jun 2003 13:49:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030612134946.450e0f77.akpm@digeo.com>
In-Reply-To: <133430000.1055448961@baldur.austin.ibm.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 20:53:43.0289 (UTC) FILETIME=[B5A9BE90:01C33124]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> Paul McKenney and I sat down today and hashed out just what the races are
> for both  vmtruncate and the distributed filesystems.  We took Andrea's
> idea of using seqlocks and came up with a simple solution that definitely
> fixes the race in vmtruncate, as well as most likely the invalidate race in
> distributed filesystems.  Paul is going to discuss it with the DFS folks to
> verify that it's a complete fix for them, but neither of us can see a hole.
> 

> +  seqlock_init(&(mtd_rawdevice->as.truncate_lock));

Why cannot this just be an atomic_t?

> +	/* Protect against page fault */
> +	write_seqlock(&mapping->truncate_lock);
> +	write_sequnlock(&mapping->truncate_lock);

See, this just does foo++.

> +	/*
> +	 * If someone invalidated the page, serialize against the inode,
> +	 * then go try again.
> +	 */

This comment is inaccurate.  "If this vma is file-backed and someone has
truncated that file, this page may have been invalidated".

> +	if (unlikely(read_seqretry(&mapping->truncate_lock, sequence))) {
> +		spin_unlock(&mm->page_table_lock);
> +		down(&inode->i_sem);
> +		up(&inode->i_sem);
> +		goto retry;
> +	}
> +

mm/memory.c shouldn't know about inodes (ok, vmtruncate() should be in
filemap.c).

How about you do this:

do_no_page()
{
	int sequence = 0;
	...

retry:
	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &sequence);
	....
	if (vma->vm_ops->revalidate && vma->vm_opa->revalidate(vma, sequence))
		goto retry;
}


filemap_nopage(..., int *sequence)
{
	...
	*sequence = atomic_read(&mapping->truncate_sequence);
	...
}

int filemap_revalidate(vma, sequence)
{
	struct address_space *mapping;

	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
	return sequence - atomic_read(&mapping->truncate_sequence);
}


