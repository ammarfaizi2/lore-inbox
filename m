Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVBDAOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVBDAOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVBDAOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:14:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:24019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261760AbVBDAOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:14:31 -0500
Date: Thu, 3 Feb 2005 16:19:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [Patch] invalidate range of pages after direct IO write
Message-Id: <20050203161927.0090655c.akpm@osdl.org>
In-Reply-To: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> After a direct IO write only invalidate the pages that the write intersected.
> invalidate_inode_pages2_range(mapping, pgoff start, pgoff end) is added and
> called from generic_file_direct_IO().  This doesn't break some subtle agreement
> with some other part of the code, does it?

It should be OK.

Note that the same optimisation should be made in the call to
unmap_mapping_range() in generic_file_direct_IO().  Currently we try and
unmap the whole file, even if we're only writing a single byte.  Given that
you're now calculating iov_length() in there we might as well use that
number a few lines further up in that function.

Note that invalidate_inode_pages[_range2] also does the unmapping thing -
in the direct-io case we don't expect that path th ever trigger: the only
way we'll find mapped pages here is if someone raced and faulted a page
back in.

Reading the code, I'm unable to convince myself that it won't go into an
infinite loop if it finds a page at page->index = -1.  But I didn't try
very hard ;)

Minor note on this:

	return invalidate_inode_pages2_range(mapping, 0, ~0UL);

I just use `-1' there.  We don't _know_ that pgoff_t is an unsigned long. 
Some smarty may come along one day and make it unsigned long long, in which
case the code will break.  Using -1 here just works everywhere.

I'll make that change and plop the patch into -mm, but we need to think
about the infinite-loop problem..
