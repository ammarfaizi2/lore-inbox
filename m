Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318892AbSIDOIh>; Wed, 4 Sep 2002 10:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319162AbSIDOIg>; Wed, 4 Sep 2002 10:08:36 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:48566 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318892AbSIDOIe>; Wed, 4 Sep 2002 10:08:34 -0400
Date: Wed, 4 Sep 2002 15:13:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209041139.g84Bdb314111@oboe.it.uc3m.es>
Message-ID: <Pine.SOL.3.96.1020904143824.7543A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Peter T. Breuer wrote:
> "A month of sundays ago Anton Altaparmakov wrote:"
> > On Wed, 4 Sep 2002, Peter T. Breuer wrote:
> > > I suggest that changing FS structure is an operation that is so
> > > relatively rare  in the projected environment (in which gigabytes of
> > > /data/ are streaming through every second) that you can make them as
> > > expensive as you like and nobody will notice. Your frothing at the
> > > mouth about it isn't going to change that. Moreover, _opening_
> > > a file is a rare operation too, relative to all that data thruput.
> > 
> > Sorry but this really shows you lack of understanding for how a file
> > system works. Every time you write a single byte(!!!) to a file, this
> > involves modifying fs structures. Even if you do writes in 1MiB chunks,
> 
> OK .. in what way? 

Did you read my post which you can lookup on the below url?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103109165717636&w=2

That explains what a single byte write to an uncached ntfs volume entails.
(I failed to mention there that you would actually need to read the block
first modify the one byte and then write it back but if you write
blocksize based chunks at once the RCW falls away.
And as someone else pointed out I failed to mention that the entire
operation would have to keep the entire fs locked.)

If it still isn't clear let me know and I will attempt to explain again in
simpler terms...

> > what happens is that all the writes are broken down into buffer head sized
> > portions for the purposes of mapping them to disk (this is optimized by
> 
> Well, they'll be broken down, yes, quite probably.

Not probably. That is how the VFS + FS work! The VFS talks to the FS
drivers and tells them "need to do i/o on the file starting at offset X
into the file for blocksize bytes [this is what I call logical block, i.e.
a block within a file]"  and the FS replies "the logical block you
requested is located on physical disk /dev/hda1 at offset Y on the disk
and has the size Z [this is the physical block I am talking about]".

This communication traditionally happens for each blocksize chunk of a
read/write request. The get_blocks() interface optimizes this so it the
size Z above can be bigger than the blocksize which tells the VFS that if
it wants to read or write the next adjacent block it is located adjacent
to the physical block being returned, i.e. the file data is physically
contiguous on disk. But this is just a optimization, so you can ignore the
get_blocks() complication for the time being, just understand that for
each read/write request no matter what its size, the VFS breaks the
request into tiny pieces of blocksize bytes (blocksize is dependent on the
FS, e.g. NTFS always uses blocksize = 512 bytes, so all i/o happens in
chunks of 512 bytes).

> > the get_blocks interface but still it means that every time get_blocks is
> 
> You mean that the buffer cache is looked up? But we know that we have
> disabled caching on this device ... well, carry on anyway (it does
> no harm to write to an already dirty buffer).

No, the buffer cache doesn't exist any more! There is no such thing in the
current kernels. However, a buffer_head is used to describe a disk block,
this is the "language" used by the VFS to talk to the FS drivers. In
particular the VFS says: "here is a buffer_head, I want this buffer_head
to be made to describe where on disk is located the data from file blah,
offset into file X, size of data blocksize" and the FS looks inside the
inode structure (this is cached, but under your scheme it would no longer
be cached!), and searches an array (this is again cached but under your
scheme it wouldn't be!) which maps between logical blocks and physical
blocks, i.e. it says the first 512 bytes in the file are located on disk
block X, the second 512 bytes are on disk block Y, etc. (the
implementations of such things are completely FS dependent, in NTFS each
element of the array looks like this: s64 file block number X, s64 disk
block number Y, s64 size of this block L, then the next element describes
file block number X+L, disk block number Z, size of block M), where X, Y,
Z, L, and M are arbitrary s64 numbers). So armed with the knowledge where
the block is on disk, the FS driver maps the buffer head, i.e. it sets
three fields in the buffer_head structure: the device, the offset into the
device, the size of the block, and it also sets the BH_Mapped flag. Then
the FS gives the buffer_head back to the VFS and the VFS now knows where
to read or write to.

Ok, this hopefully explains to you what logical (file) and physical (disk)
blocks are and how the conversion between the two is done.

> > involved you have to do a full lookup of the logical block and map it to
> > an on disk block). For reading while you are not modifying fs structures
> > you still need to read and parse them for each get_blocks call.
> 
> I'm not following you. It seems to me that you are discussing the
> process of getting a buffer to write to prior to letting it age and
> float down to the device driver via the block layers. But we have

No, the buffer_head ONLY describes where the data is on disk, nothing
more. But the VFS needs to know where that data is on disk in order to be
able to read/write to the disk.

> disabled caching so we know that get_blocks will deliver a new
> temporary buffer or block or something or at any rate do what it
> should do ... anyway, I mumble.... what you are saying is that you
> think we look up a logical block number and get a physical block
> number and possibly a buffer associated with it. Well, maybe.

Yes (minus the buffer associated with it).

> So?

*sigh* Doing the conversion from a logical block number to a physical
block number is VERY VERY VERY slow!!!

On NTFS, the table that converts from one to the other is stored in the
inode structures on disk in a _compressed_ form, i.e. you have to
uncompress this metadata into temporary memory buffers in order to be able
to do the conversion. Normal we do this ONCE and then cache the result in
the in memory inode structure.

But you want to not cache the inodes (i.e. the metadata), which means that
for every single 512 byte block being read or written (remember no matter
how big your write/read is, the VFS will break it up into 512 byte pieces
for NTFS), NTFS will have to lock the file system, read the inode from
disk (to do this it will have to go through a lot of reads in order to
find the inode on disk first!!! - read the post I referenced by URL above 
for a description), decompress the array to allow conversion from logical
to physical block, then enter the correct values in the buffer_head
structure, throw away all the memory buffers we just allocated to store 
the inode and the decompressed array, etc, then return the mapped
buffer_head structure to the VFS and the fs lock is dropped.

Then when the VFS wants the next 512 bytes, the whole above thing happens
again, from scratch! But the lock was dropped, and no caching, so we have
to repeat everything we just did, the identical stuff in fact, just to
return the next on disk block!

Do you see now what I mean?

This is completely inpractical. It would be so slow and would wear out the
harddrive sectors so much that your harddisks would break in a few
months/years developping bad blocks in the most commonly accessed places
like the boot sector and the first inode describing where the remaining
inodes are. If you have an unpatched IBM Deskstar drive for example you
can kiss it goodbye within a few months for sure.

Your approach could actually be considered as malliciously destroying end
user hardware... It's a trojan! (-;

> > This in turn means that each call to get_blocks within the direct_IO code
> > paths will result in a full block lookup in the filesystem driver.
> 
> > I explained in a previous post how incredibly expensive that is.
> 
> Well, I simply don't follow you here. Can you unmuddle my understanding
> of what you are saying about logical/physical?

Has it become clearer now?

> > So even though you are streaming GiB of /data/ you will end up streaming
> > TiB of /metadata/ for each GiB of /data/. Is that so difficult to
> > understand?
> 
> Yep. Can you be concrete about this metadata? I'lll see if I can work
> it out .. what I think you must be saying is that when we write to
> a file, we write to a process address space, and that has to be
> translated into a physical block number on disk. Well, but I imagine
> that the translation was settled at the point that the inode was first
> obtained, and now that we have the inode, data that goes to it gets
> a physical address from the data in the inode. We can even be using an
> inode that is unconnected to the FS, and we will still be writing away
> to disk, and nobody else will be using that space, because the space
> is marked as occupied in the bit map.
> 
> I see no continuous lookup of metadata.

Clear now?

> > Unless you allow the FS to cache the /metadata/ you have already lost all
> 
> What metadata? I only see the inode, and that's not cached in any
> meaningful sense (i.e. not available to other things) to but simply
> "held" in kmem storage and pointed to.

Oh it is cached. In NTFS we keep the inode in memory at all times as long
as the file is active (well it could be sent to swap or evicted from
memory under memory pressure but apart from that it is always cached). And
we also keep the metadata describing the mapping between logical and
physical blocks attached to the struct inode, too until the struct inode
is disposed off from the inode cache.

> > your performance and you will never be able to stream at the speads you
> > require.
> 
> Can you be even MORE specific about what this metadata is? Maybe I'll
> get it if you are very very specific.

I hope I have been specific enough above. If not let me know...

> I think you are imagining implementation that are simply not the way
> I imagine them. Can you be specific about the exact metadata that is
> changed when a data write is done? That will help me decide.

Quite possible. I hope I have managed to explain things above but if not
let me know and I will try again. (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

