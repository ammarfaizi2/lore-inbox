Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbTLKS6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTLKS6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:58:11 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:65460 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265214AbTLKS6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:58:08 -0500
Date: Thu, 11 Dec 2003 12:58:06 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Hua Zhong <hzhong@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031211125806.B2422@hexapodia.org>
References: <200312041432.23907.rob@landley.net> <011e01c3bfa5$8fb5a0e0$d43147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <011e01c3bfa5$8fb5a0e0$d43147ab@amer.cisco.com>; from hzhong@cisco.com on Wed, Dec 10, 2003 at 09:13:49PM -0800
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:13:49PM -0800, Hua Zhong wrote:
> This would be a tremendous enhancement to Linux filesystems, and one of
> my current projects actually needs this capability badly.
> 
> The project is a lightweight user-space library which implements a
> file-based database. Each database has several files. The files are all
> block-based, and each block is always a multiple of 512 byte (and we
> could make it a multiple of 4K, in case this feature existed).
> 
> Blocks are organized as a B+ tree, so we have a root block, which points
> to its child blocks, and in turn they point to the next level. There is
> a free block list too.
> 
> The problem is with a lot of add/delete, there are a lot of free blocks
> inside the file. So essentially we'd have to manually shrink these files
> when it grows too big and eats up too much space. If we could just "dig
> a hole", it would be trivial to return those blocks to the filesystem
> without doing an expensive defragmentation.

The abstract interface for make_hole() is simple, but it turns into a
pretty expensive filesystem operation, I think.  After many cycles of
free/allocate, your file would be badly fragmented across the
filesystem.  You'll probably get better overall performance by keeping
track of how "sparse" your file is (you could compare st_blocks versus
how many blocks you have allocated in your tree structure) and re-write
it when you're wasting more than, say, 20% of the allocated space.

It turns into an interesting problem if you don't want to double your
space requirements during the re-write process.  You could write the
new file "backwards", one MB at a time, truncating the previous file at
each step to free up the blocks.  You'd end up with contiguous 1MB
chunks, which given your tree organization is probably good enough.  If
you wanted really good streaming performance you'd want to do bigger
chunks (or just write the file from the beginning, or use the
pre-allocation APIs that I think XFS provides).

-andy
