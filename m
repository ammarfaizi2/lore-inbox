Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSIIQZo>; Mon, 9 Sep 2002 12:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSIIQZo>; Mon, 9 Sep 2002 12:25:44 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:36619 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317506AbSIIQZm>;
	Mon, 9 Sep 2002 12:25:42 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209091630.g89GULK19758@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk> from
 Anton Altaparmakov at "Sep 6, 2002 06:20:15 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Mon, 9 Sep 2002 18:30:21 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A concrete question wrt the current file i/o data flow ...

"Anton Altaparmakov wrote:"
> VFS: on file read we eventually reach:
> 
> mm/filemap.c::generic_file_read() which calls
> mm/filemap.c::do_generic_file_read() which breaks the request into units
> of PAGE_CACHE_SIZE, i.e. into individual pages and calls the file system's
> address space ->readpage() method for each of those pages.
> 
> Assuming the file system uses the generic readpage implementation, i.e.
> fs/buffer.c::block_read_full_page(), this in turn breaks the page into
> blocksize blocks (for NTFS 512 bytes, remember?) and calls the FS
> supplied get_block() callback, once for each blocksize block (in the form

There is an inode arg passed to the fs get_block. Is this really the
inode of a file, or is it a single inode associated with the mount
(I see we only use it to get to the sb and thence the blocksize)

I am confused because ext_get_block says it's the file inode:

 static int ext2_get_block(struct inode *inode, sector_t iblock, struct
 buffer_head *bh_result, int create)
 ...
 int depth = ext2_block_to_path(inode, iblock, offsets, &boundary);
 ...

  *      ext2_block_to_path - parse the block number into array of offsets
  *      @inode: inode in question (we are only interested in its superblock)
          ^^^^^^^^^^^^^^^^^^^^^^^^
  *      @i_block: block number to be parsed
  ...

and the vfs layer seems to pass mapping->host, which I believe should
be associated with the mount.


  int block_read_full_page(struct page *page, get_block_t *get_block)
  {
          struct inode *inode = page->mapping->host;

(all kernel 2.5.31).  

> of a struct buffer_head).
> 
> This finds where this 512 byte block is, and maps the buffer head (i.e.

Now, you say (and I believe you!) that the get_block call finds where
the block is. But I understand you to say that the data pased in by VFS
is in local offsets ..  that corresponds to what I see:
block_read_full_page() gets passed a page struct and then calculates the
first and last (local?) blocks from page->index ...

  iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
  lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;

and that makes it seem as though the page already contained an offset
relative to the device, or logical in some other way that will now
be resolved by the fs specific get_block() call. However, the ext2
get_block only consults the superblock, nothing else when resolving
the logical blk number. So no inode gets looked at, as far as I can
see, at least in the simple cases ("direct inode"?). In the general
case there is some sort of chain lookup, that starts with the
superblock and goes somewhere ...

    partial = ext2_get_branch(inode, depth, offsets, chain, &err);

   **
    *      ext2_get_branch - read the chain of indirect blocks leading to data
    *      @inode: inode in question
    *      @depth: depth of the chain (1 - direct pointer, etc.)
    *      @offsets: offsets of pointers in inode/indirect blocks
    *      @chain: place to store the result
    *      @err: here we store the error value

Which seems to be trying to say that the inode arg is something that's
meant to be really the inode, not just some dummy that leads to the
superblock for purposes of getting the blksiz.

So I'm confused.


I'm also confused about how come the page already contains what seems
to be a device-relative offset (or other logical) block number. 

> sets up the buffer_head to point to the correct on disk location) and

But the setup seems to be trivial in the "direct" case for ext2.
And I don't see how that can be because the VFS ought /not/ to have
enough info to make it trivial?

> returns it to the VFS, i.e. to block_read_full_page() which then goes and
> calls get_block() for the next blocksize block, etc...

Now, if I go back to mm/do_generic_file_read(), I see that it's working
on a struct file, and passes that file struct to the fs specific
readpage.

        error = mapping->a_ops->readpage(filp, page);

I can believe that maybe the magic is there. But no, that's the 
it's the generic ext2_readpage that gets used, and that _drops_
the file pointer!

       static int ext2_readpage(struct file *file, struct page *page)
       {
               return mpage_readpage(page, ext2_get_block);
       }

so, um, somehow the page contained all the info necessary to do lookups
on disk in ext2, no FS info required.

Do I read this right? How the heck di that page info get filled in in
the first place? How can it be enough? It can't be!

Peter
