Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319350AbSIFTZi>; Fri, 6 Sep 2002 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319351AbSIFTZh>; Fri, 6 Sep 2002 15:25:37 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:20457 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319350AbSIFTZa>; Fri, 6 Sep 2002 15:25:30 -0400
Message-Id: <5.1.0.14.2.20020906194417.03f63c70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 06 Sep 2002 20:30:07 +0100
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Daniel Phillips <phillips@arcor.de>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209061829.g86ITSK05817@oboe.it.uc3m.es>
References: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:29 06/09/02, Peter T. Breuer wrote:
>"Anton Altaparmakov wrote:"
> > is how the VFS is implemented at present time.
> >
> > As of very recently, Andrew Morton introduced an optimization to this with
> > the get_blocks() interface in 2.5 kernels. Now the file system, when doing
> > direct_IO at least, returns to the VFS the requested block position _and_
> > the size of the block. So the VFS now gains in power in that it only needs
> > to ask for each block once as it is now aware of the size of the block.
>
>I'm not sure I follow. The VFS already split the request up according
>to your account above, so it doesn't care. I think you must be saying
>that the VFS now DOES ask for more than 512B at a time?

No.

>Can you clarify? I imagine that the FS replies with how much of the i/o it 
>did this time, and thus the VFS knows if it should call again.

You are mixing two things up: there is the lookup layer level and there is 
the i/o level the two are separate! First all blocks in the current page 
are looked up, then the i/o is done. Not simultaneously. Does that clarify 
it? The FS doesn't reply with how much i/o it did because it didn't do any. 
It only tells the VFS where the block is on disk, nothing more, then the 
VFS does the i/o the FS doesn't.

Note that this only happens, _if_ the FS uses the generic helpers in 
fs/buffer.c, like block_read_full_page(). This calls the FS to do the 
lookups and then sets up the i/o for all the blocks in the current page at 
once.

If the FS doesn't use those and implements their own readpage() method then 
it is free to do whatever it wants. Just like NTFS does now, i.e. NTFS now 
does all the lookups and then the i/o entirely without going anywhere near 
VFS code. NTFS directly talks to the block layer.

> > But still, even with this optimization, the VFS still asks the FS for each
> > block, and then the FS has to lookup each block.
>
>Now I really don't understand you -- what's the point of the FS's
>replying with the size of the block? Are you saying that it can reply
>with a _larger_ size than the VFS asked for,

The VFS says, please give me 1 block at file offset X. The FS replies: the 
block at offset X is located on disk block Y and has size Z. The VFS then 
goes and reads up to Z bytes from that block on disk and either asks for 
the location of offset X+Z or terminates (no more data to transfer).

>sort of a "you can be braver about this" invitation, so the VFS can ask 
>for a bigger lump next time?

No. See above. The VFS doesn't ask for any size, it just asks where is this 
block and the FS says it is here and this is its size.

> > Obviously if only one file was written, and the disk is not fragmented,
> > the file will be basically contiguous on disk. But if you wrote two
> > or more files simultaneously they would be very likely interleaved, i.e.
>
>That's OK. Imagine that most of the files were laid down beforehand,
>and now we are simply rewriting over them.

Oh, ok, in that case they will be contiguous or almost so.

> > > > need to read the disk inode just once and then you immediately read 
> all the
> > > No, I think that's likely. I don't "think it". But yes, i assume that
> > > in the case of a normal file it is quite likely that all the info
> > > involved is in the inode, and we don't need to go hunting elsewhere.
> > >
> > > Wrong?
> >
> > In NTFS wrong. You have the base inode which contains all metadata (i.e.
> > modification times, security information, the conversion table from file
> > offsets to disk locations, ...). However, as data is added to the file,
> > the conversion table for example grows and eventually the inode runs out
> > of space. (In NTFS inodes are fixed size records of 1024 bytes.) When that
>
>Well, that I can imagine. Let's /not/ consider NTFS, then. I'd rather
>consider something that hasn't taken about 5 years to reverse engineer
>in the first place!  And NTFS is NOT going to be a candidate, because
>of reliability. Does this happen on unix file systems too ..

In ext2/3 you have indirect blocks so as the file grows you have to read 
them in addition to the inode. So this is kind of a very standard 
feature... The indirect blocks of ext2/3 are very much like NTFS extent 
inodes in function...

> > happens, the NTFS driver either moves the conversion table completely to a
> > 2nd inode (we call this inode an extent inode because it is _only_
> > referenced by the original inode itself) or it splits the conversion table
> > into two pieces and saves the 2nd part to a 2nd (extent) inode. The 2nd
> > (extent) inode can be anywhere in the inode table, wherever the allocator
> > finds a free one. When the 2nd inode fills up, the process is repeated, so
> > we now have a 3rd (extent) inode, and so on, ad infinitum. So NTFS has
>
>Well, something like that I distantly recall as happening on unix fs's,
>but I'd like to know if we expect a file of fixed size which is being
>overwritten without O_TRUNC to have any metadata changes apart from in
>its inode (and there trivially) ...?

There _shouldn't_ be changes needed. For NTFS there certainly aren't. Only 
the access times would get changed, that's it. (As long as the file size 
remains constant, no metadata except access times need changing.) I can 
only guess that for other FS it is the same...

> > > What I am not clear about now is exactly when the data is looked up - I
> > > get the impression from what I have seen of the code that the VFS passes
> > > down a complete request for 1TB, and that the the FS then goes and locks
> > > the inode and chases down the data.  What you are saying above gives me
> > > the impression that things are broken down into 512B lumps FIRST in or
> > > above VFS, and then sent to the fs as individual requests with no inode
> > > or fs locking. And I simply don't buy that as a strategy.
> >
> > But that is how the VFS works! The VFS _does_ break up everything into
> > 512B lumps FIRST. Let me show you where this happens (assume current 2.5
>
>OK. Why 512? Why not the blocksize?

sb->s_blocksize = 512;

NTFS does that at mount time. so that is the NTFS blocksize. blocksize is 
not a constant, it is a per mount point variable number...

So your second question doesn't make sense...

But to answer the first question: the lowest common denominator between the 
kernel blocksize and the NTFS cluster size is 512. Hence I chose 512. This 
is also 1 hard disk sector which fits very nicely with the multi sector 
transfer protection applied to metadata on NTFS which is done in 512 byte 
blocks (I will spare you the details what that is). Further the kernel 
doesn't allow blocksize > PAGE_SIZE, on ia32 4kiB. But NTFS clusters can be 
much bigger than that. So I can't just set the blocksize = NTFS cluster 
size. Also for metadata access that would be inconvenient.

The code gets very ugly and inefficient of blockszie > 512. An example: 
blocksize = 4096 (1 page) and  NTFS cluster size = 512.

Now we can no longer do i/o in less than 4096 byte quantities but NTFS 
clusters are 512 bytes so when we read 4096 bytes from disk, we get the 512 
bytes we wanted and another 3.5kiB of random data. Now think what happens 
if we wanted the 2nd 512 bytes? We would need to always work with current 
block + ofs into block. Nasty. It can be done. But if done efficiently then 
imagine the the next mounted volume has cluster size 8kiB. Suddenly this is 
bigger than the blocksize of 4kiB and now all divisions and shifts that 
wonderfully worked above now all cause values of zero as results because of 
integer division. Now we need to swap all divisions and shifts around 
dividing cluster_size / blocksize instead of the other way round. For the 
code to cope with both cases it gets fugly... All that nastyness is nicely 
avoided by setting blocksize = 512 and thus guaranteeing that cluster_size 
is always >= blocksize. Allows much more efficient maths.

> > kernel):
> >
> > VFS: on file read we eventually reach:
> >
> > mm/filemap.c::generic_file_read() which calls
> > mm/filemap.c::do_generic_file_read() which breaks the request into units
> > of PAGE_CACHE_SIZE, i.e. into individual pages and calls the file system's
>
>Well, we're at 4096 now (or is it 8192 :-).

Depends on your page size and that varies from arch to arch! (-: This is a 
complication because if I move a HD from an Alpha to a ia32, i.e. moving 
from PAGE_SIZE 8192 to PAGE_SIZE 4096 I want that file system to work! Not 
give me an error message "unsupported blocksize". That is also the reason I 
chose 512 bytes in NTFS...

> > address space ->readpage() method for each of those pages.
> >
> > Assuming the file system uses the generic readpage implementation, i.e.
> > fs/buffer.c::block_read_full_page(), this in turn breaks the page into
> > blocksize blocks (for NTFS 512 bytes, remember?) and calls the FS
>
>But not for any other FS.  I didn't even know 512 was a possible kernel
>blocksize.  In fact, I'm fairly sure it wasn't in the recent past.  1024
>eas the minimum, no?

It always was possible. It would have been insane not to allow it. You are 
confusing this with the blocksize used by the kernel for device i/o which 
is 1024 bytes, i.e. the infamous BLOCK_SIZE constant...

>And I'll choose 4096, thanks!

You can't just choose 4096. Maybe the person who formatted the volume chose 
less? Or maybe the disk comes from a different computer/arch which was 
using something else?

> > supplied get_block() callback, once for each blocksize block (in the form
> > of a struct buffer_head).
>
>OK. But this will stick at 4096 blocks for other FSs.

Not really. Most FS allow different block sizes. Certainly VFAT, ext2, 
ext3, NTFS, by extension HPFS I guess do, and I am fairly sure XFS, does 
too. And probably all the other "modern" Linux OS like Reiser and JFS...

>I'm vary gratefull for this explanation BTW. gfr -> do_gfr -> breakup
>-> readpage. I should be able to trace it from there. I'll expect that
>the pagesize is the blocksize (or close), for optimum performance at
>this point.

Yes. Optimum performance is given when you set blocksize = PAGE_SIZE. But 
that is not always possible or practical.

> > This finds where this 512 byte block is, and maps the buffer head (i.e.
>
>THAT's the inode lookup. OK, that's once per block, for the scenario
>I'm imagining. So .. for reads the situation is fine. We can have a
>read/write lock on  all FS metadata, and multiple readers will be
>allowed at once. The problem is that as soon as anyone writes metadata,
>then no reads can be allowed anywhere, unless we know where the inode
>is.
>
>So that's the perfect intercept. The get_block callback needs to return
>an extra argument which is the physical block location of the inode
>and I can lock that. That's perfect.
>
>No?  Well, maybe we might have to go through several inodes, which all
>need to be locked, wo we need to return an array.
>
> > sets up the buffer_head to point to the correct on disk location) and
> > returns it to the VFS, i.e. to block_read_full_page() which then goes and
> > calls get_block() for the next blocksize block, etc...
>
>Yes, this looks good.
>
> > So this is how file reads work. For NTFS, I figured this is too
> > inefficient (and because of other complications in NTFS, too) and I don't
>
>Well, at 512B a time, it looks so!
>
> > use block_read_full_page() any more. Instead, I copied
> > block_read_full_page() and get_block() and rewrote them for NTFS so that
> > they became one single function, which takes the page and maps all the
> > buffers in it in one go, keeping the conversion table from file offsets to
> > disk blocks locked (rw_semaphore) during that period. That is way more
> > efficient as it means I don't need to do a lookup in the conversion table
> > for every 512 byte block any more and instead I perform the lookup for all
> > blocks in the current page in one go.
>
>yes. Well, I didn't follow that detail.

It just means that NTFS does everything on its own. No talking to VFS. In 
fact NTFS doesn't implement a get_block() function at all. Its 
functionality is merged into ntfs_readpage() and its friends.

NTFS now works like this: VFS says, please read PAGE_CACHE_SIZE bytes of 
data from file F at offset X into this provided page, thank you. And NTFS 
goes away looks up the blocks, reads the data by talking to the block layer 
directly, and returns to the VFS saying: "All done.".

So this example of NTFS shows you why you can't do your intercept at 
get_block() level. It simply isn't used by all FS. So you are already 
restricting which FS you will support... Remember you had said initially 
that you want to support all FS in the kernel... Most people who replied 
said "don't do that, support only one or a few FS"... So perhaps you are 
starting to agree. (-;

> > 512 if the FS says so. blocksize on NTFS is 512 bytes. Fixed. Otherwise
>
>:-). It won't say so, I somehow think!

I like to personify code because it makes it much easier to talk about it. 
You yourself complained about using "our" FS terminology which you are 
unfamiliar with... So I am trying to use the personification method so I 
can talk in "normal" language... (-;

> > thing instead. But at least for file systems using the VFS helpers a
> > modification of the VFS means changing every single FS driver using this
>
>Only modify those that I want to use. The difficulty is in identifying a
>strategy and a point at which a change can be made.

Ok, now you are getting sensible. You now want to support only a few FS not 
all. Good! (-:

> > Or do they all talk to the master node?
> >
> > - the FS mounted on the servers is exported via NFS (or other networking
> > FS) to the workstations which then read/write files on the NFS shares.
>
>NFS is not the most likely candidate becuase of its known weaknesses, but
>it is a possibility.
>
> > is difficult to talk about it... Your turn to explain your idea better
> > now. (-;
>
>Well, it's hard to go into details because what I am asking for is clues
>to enable the idea to be prototyped and evaluated. There will be a grid
>topolgy. Each machine will locally be connected to several others. The
>whole grid will form a ring (or a torus, if you see that I am talking
>about a 2-D planar local connectivity graph, so that I must be talking
>about an orientable surface ...). Each machine will have at least one
>disk of its own, and share it with three other machines. There is
>planned redundancy here (i.e. raid as well).

Ok. But you are saying that clients will talk to servers at FS level. Is 
this correct? I.e. NFS or some other FS which can talk over the wire? Or 
are the clients actually going to mount the "virtual" harddisk that they 
will write files to? -- These two questions are really the clincher of the 
discussion! --  Can you at least say which of those two approaches are 
going to be used? Or are you open minded there, too?

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

