Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDJJhV>; Tue, 10 Apr 2001 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDJJhL>; Tue, 10 Apr 2001 05:37:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:52750 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131376AbRDJJg7>;
	Tue, 10 Apr 2001 05:36:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104100936.f3A9atU153592@saturn.cs.uml.edu>
Subject: Re: [RFC] Ext2 Directory Index - File Structure
To: phillips@nl.linux.org (Daniel Phillips)
Date: Tue, 10 Apr 2001 05:36:55 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010409104037Z92164-22358+7@humbolt.nl.linux.org> from "Daniel Phillips" at Apr 09, 2001 12:40:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

> The zeroth block of an indexed directory is the index root.  Initially
> the index has only one block.  The following blocks are normal ext2
> directory entry blocks.  When the directory grows large enough to fill
> all the available entries in the root index block (around 80-90,000
> entries on a 4K blocksize filesystem) a second level is added to the
> index tree in the form of an internal index block appended to the
> directory.  As the directory expands, new index blocks are appended as
> needed so that the directory consists of normal directory blocks with
> index nodes interspersed every 200 blocks or so.

It looks like you end up jumping back and forth to read the
index blocks. (but maybe I need more sleep) It might be better
to allocate 1, 2, 4, 8, ... index blocks at once, instead of
always allocating just one.

> The high four bits of the block pointer field are reserved for use by
> a coalesce-on-delete feature which may be implemented in the future. 
> The remaining 28 bits are capable of indexing up to 1TB per directory
> file.  (Perhaps I should coopt 8 bits instead of 4.)

Doing a 1 TB directory means you must give up on i_size, which is
too small. You may instead calculate what you need from the block count.
If you don't give up on i_size, you might as well coopt 11 bits.

Oh, just grab 12 or 16 bits. It isn't at all OK to make directories
that are pretty much impossible to read on a 32-bit system. Think
about what /bin/ls must do to sort a 1 TB directory.

> The first kind of forward compatibility is addressed by hiding all the
> new index structures inside what appears to earlier versions of Ext2 to
> be free space.  This is accomplished by placing an empty Ext2 dirent
> structure at the beginning of each index node which marks the entire
> block as empty, from the point of view of non-index-aware versions of
> Ext2.

Well, it looks better than vfat. Next you will be wanting to
increase the inode size and switch to 64-bit block numbers.
You could write such a wonderful NEW filesystem.
