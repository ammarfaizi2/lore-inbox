Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278609AbRJSTFZ>; Fri, 19 Oct 2001 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278610AbRJSTFQ>; Fri, 19 Oct 2001 15:05:16 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:48257 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S278609AbRJSTFL>; Fri, 19 Oct 2001 15:05:11 -0400
Date: Fri, 19 Oct 2001 12:05:44 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Subject: Why is writepage() return value not used?
Message-ID: <20011019120544.G27824@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading through 2.4.12 sources, I observe that the two calls to
the address_space writepage() method, found in these functions:

	filemap_fdatasync
	shrink_cache

both ignore the return value.  For that matter, filemap_fdatasync
itself has no return value.  This seems to indicate that various
internal errors during fsync() will not result in an error to the
application.  Looking at some of the possible call graphs, such 
errors might occur in any of the write_full_page implementations,
including calls to:

	get_block()  (e.g., block_write_full_page, block_prepare_write)

	various EIO conditions, mostly sanity checks 
	(e.g., block_prepare_write, nfs_writepage, reiserfs, smbfs)

	calls to file_operations write() method though 
	nfs_writepage_sync

	ENOMEM condition (e.g., shmem_writepage)

My guess is that the file system's get_block() method usually 
cannot be called from within the block_write_full_page method 
during writepage, which is called directly by most file systems,
because the full page would have all its buffers mapped prior to
writepage().  Is this true?

However, NFS, ReiserFS, SMBFS, and shmem do not simply call
block_write_full_page() and each performs error checking in this code 
path.  It looks as if these errors will not reach the application
to which they belong when writepage() is called via fsync().  This
is definetly the case for ReiserFS, but I do not understand the
other systems well enough to evaluate their writepage() code path.

It looks less significant that shrink_cache() does not use the
return value, but if writepage() truly should have its return value
ignored then the declaration should not have it returning an int.

That would at least notify the file system authors that returning
an error condition does no good.

-josh
