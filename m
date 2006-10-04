Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161932AbWJDSQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161932AbWJDSQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWJDSQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:16:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161932AbWJDSQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:16:28 -0400
Date: Wed, 4 Oct 2006 11:16:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061004111603.20cdaa35.akpm@osdl.org>
In-Reply-To: <x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org>
	<4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 13:53:32 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> ==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Zach Brown <zach.brown@oracle.com> adds:
> 
> >> Why is this a problem?  It's just like someone did a write(), and we'll
> >> invalidate the pagecache on the next direct-io operation.
> 
> zach.brown> This was noticed as a distro regression as they moved from the
> zach.brown> kernels that used to invalidate the entire address space on
> zach.brown> direct io ops to more modern ones that only invalidate the
> zach.brown> region being written.
> 
> Right.

Change app to use sync_file_range() followed by
posix_fadvise(POSIX_FADV_DONTNEED).  Problem solved.

We have lots of nice new tools in-kernel which permit applications to
manipulate and to invalidate pagecache.  Please, start using them rather
than pushing bits of oracle into the core vfs ;)

> zach.brown> You can end up with significant memory pressure after this
> zach.brown> change with a large enough working set on disk.
> 
> >> eek.  truncate_inode_pages() will throw away dirty data.  Very
> >> dangerous, much chin-scratching needed.
> 
> zach.brown> Yeah, I failed to tell Jeff that it should be calling
> zach.brown> filemap_fdatawrite() first to get things into writeback.  (And
> zach.brown> presumably not truncating if that returns an error.)
> 
> Ahh, that explains it.  The strange thing is that my test validates the
> file afterwards, and I was seeing correct data.

That is strange, because the truncate_inode_pages() will throw away the
dirty pagecache pages which the application just wrote to.  Maybe the file
was opened O_SYNC or something.

> I'll repost after another round of testing.

Please, no truncate_inode_pages.  For this application, the far-safer
invalidate_inode_pages() would suffice.

However no kernel change is needed.

And no sneaking changes like this into vendor kernels either!  Fix Oracle.
