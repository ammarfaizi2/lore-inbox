Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264055AbSIQLPR>; Tue, 17 Sep 2002 07:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264056AbSIQLPR>; Tue, 17 Sep 2002 07:15:17 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:2761 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264055AbSIQLPP>; Tue, 17 Sep 2002 07:15:15 -0400
Message-Id: <5.1.0.14.2.20020917115134.00b24e30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 17 Sep 2002 12:21:06 +0100
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200209091630.g89GULK19758@oboe.it.uc3m.es>
References: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:30 09/09/02, Peter T. Breuer wrote:
>A concrete question wrt the current file i/o data flow ...

Hi, sorry for delay in replying... I am rather busy, organising house move...

>"Anton Altaparmakov wrote:"
> > VFS: on file read we eventually reach:
> >
> > mm/filemap.c::generic_file_read() which calls
> > mm/filemap.c::do_generic_file_read() which breaks the request into units
> > of PAGE_CACHE_SIZE, i.e. into individual pages and calls the file system's
> > address space ->readpage() method for each of those pages.
> >
> > Assuming the file system uses the generic readpage implementation, i.e.
> > fs/buffer.c::block_read_full_page(), this in turn breaks the page into
> > blocksize blocks (for NTFS 512 bytes, remember?) and calls the FS
> > supplied get_block() callback, once for each blocksize block (in the form
>
>There is an inode arg passed to the fs get_block. Is this really the
>inode of a file, or is it a single inode associated with the mount
>(I see we only use it to get to the sb and thence the blocksize)

It is the inode of a file. In fact the inode of the file for which 
get_block is called. Otherwise how would the filesystem know which file's 
block needs to be looked up?

>I am confused because ext_get_block says it's the file inode:
>
>  static int ext2_get_block(struct inode *inode, sector_t iblock, struct
>  buffer_head *bh_result, int create)
>  ...
>  int depth = ext2_block_to_path(inode, iblock, offsets, &boundary);
>  ...
>
>   *      ext2_block_to_path - parse the block number into array of offsets
>   *      @inode: inode in question (we are only interested in its superblock)
>           ^^^^^^^^^^^^^^^^^^^^^^^^
>   *      @i_block: block number to be parsed
>   ...
>
>and the vfs layer seems to pass mapping->host, which I believe should
>be associated with the mount.

No. mapping->host _is_ the inode to which this address space mapping 
belongs, i.e. mapping->host->i_mapping == mapping (I am thinking about the 
usual case here, lets ignore weird and wonderful things done by various 
network fs).

>   int block_read_full_page(struct page *page, get_block_t *get_block)
>   {
>           struct inode *inode = page->mapping->host;
>
>(all kernel 2.5.31).
>
> > of a struct buffer_head).
> >
> > This finds where this 512 byte block is, and maps the buffer head (i.e.
>
>Now, you say (and I believe you!) that the get_block call finds where
>the block is. But I understand you to say that the data pased in by VFS
>is in local offsets ..  that corresponds to what I see:
>block_read_full_page() gets passed a page struct and then calculates the
>first and last (local?) blocks from page->index ...

                 ^^^^ yes, local, better logical, or file offset.

>   iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
>   lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
>
>and that makes it seem as though the page already contained an offset
>relative to the device, or logical in some other way that will now
>be resolved by the fs specific get_block() call.

Correct. The VFS initializes the page->index to the logical file offset (in 
units of PAGE_CACHE_SIZE blocks). That is how we know which file offset the 
page belongs to.

This is then used as you show above to convert the file offset into 
blocksize sized blocks in the code you quoted above.

get_block is then given each block and looks it up.

>  However, the ext2
>get_block only consults the superblock, nothing else when resolving
>the logical blk number. So no inode gets looked at, as far as I can
>see, at least in the simple cases ("direct inode"?). In the general
>case there is some sort of chain lookup, that starts with the
>superblock and goes somewhere ...
>
>     partial = ext2_get_branch(inode, depth, offsets, chain, &err);
>
>    **
>     *      ext2_get_branch - read the chain of indirect blocks leading to 
> data
>     *      @inode: inode in question
>     *      @depth: depth of the chain (1 - direct pointer, etc.)
>     *      @offsets: offsets of pointers in inode/indirect blocks
>     *      @chain: place to store the result
>     *      @err: here we store the error value
>
>Which seems to be trying to say that the inode arg is something that's
>meant to be really the inode, not just some dummy that leads to the
>superblock for purposes of getting the blksiz.

Yes.

>So I'm confused.

(-: I hope you are less confused by now. The inode must be the actual inode 
and not some fake object otherwise get_block doesn't know which file it is 
working on which would make looking up the file offsets and converting them 
to disk positions impossible.

>I'm also confused about how come the page already contains what seems
>to be a device-relative offset (or other logical) block number.

The VFS sets that up. for example see mm/filemap.c::

do_generic_file_read ->
         alloc_page;
         add_to_page_cache_lru();
                 -> add_to_page_cache();

alloc_page just allocates a page and the add_ functions actually put it in 
its correct place setting up page->index and entering it properly into the 
radix tree.

include/linux/pagemap.h::___add_to_page_cache() does the actual page->index 
setting which you will find is called in the above call chain.

> > sets up the buffer_head to point to the correct on disk location) and
>
>But the setup seems to be trivial in the "direct" case for ext2.
>And I don't see how that can be because the VFS ought /not/ to have
>enough info to make it trivial?

That is entirely fs dependent! Each fs works in completely different way. 
The more get_block functions you read the more different methods you will see.

> > returns it to the VFS, i.e. to block_read_full_page() which then goes and
> > calls get_block() for the next blocksize block, etc...
>
>Now, if I go back to mm/do_generic_file_read(), I see that it's working
>on a struct file, and passes that file struct to the fs specific
>readpage.
>
>         error = mapping->a_ops->readpage(filp, page);
>
>I can believe that maybe the magic is there. But no, that's the
>it's the generic ext2_readpage that gets used, and that _drops_
>the file pointer!
>
>        static int ext2_readpage(struct file *file, struct page *page)
>        {
>                return mpage_readpage(page, ext2_get_block);
>        }
>
>so, um, somehow the page contained all the info necessary to do lookups
>on disk in ext2, no FS info required.

Correct. You should _never_ look at the file argument to read page because 
it can be NULL and in such circumstances you will choke on that...

The page is all you need:

page->index tells you the logical file offset in units of PAGE_CACHE_SIZE 
inside the file.

page->mapping->host gives you the inode of the file and thus all the 
information you need to resolve the page to its on disk location.

>Do I read this right? How the heck di that page info get filled in in
>the first place? How can it be enough? It can't be!

Of course it can be. ->index and ->mapping are both set at the same time in 
the ___add_to_page_cache static inline helper. Both are fully sufficient in 
that they specifiy the inode/file (page->mapping->host), the volume this 
file belongs to (page->mapping->host->i_sb), the offset in the file the 
page belongs to (page->index).

What more do you need?

Best regards,

         Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

