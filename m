Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319295AbSIFSZK>; Fri, 6 Sep 2002 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSIFSZK>; Fri, 6 Sep 2002 14:25:10 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:59665 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319295AbSIFSY4>;
	Fri, 6 Sep 2002 14:24:56 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209061829.g86ITSK05817@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk> from
 Anton Altaparmakov at "Sep 6, 2002 06:20:15 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Fri, 6 Sep 2002 20:29:28 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Daniel Phillips <phillips@arcor.de>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anton Altaparmakov wrote:"
> On Fri, 6 Sep 2002, Peter T. Breuer wrote:
> > Why? Doesn't the inode usually point at a contiguous lump of many
> > blocks? Are you perhaps looking at the worst case, not the usual case?
> 
> Because the VFS does the split up and it has no idea whatsoever whether
> something is contiguous or not. Only the FS itself knows that information.
> So the VFS has to ask for each bit individually assuming the worst case

Well, it doesn't /have to/, but it does it, if this is a realistic
account (personally, if I were designing it, I'd have VFS ask for what
I want at high level, and let the FS look after how it wants to do
it - but it is a valid approach, I mean, at least this way the VFS has
some nontrivial work that it can contribute always).

> scenario. And the FS itself has no idea what the VFS is doing and hence
> has to process each request completely independently from the others. This

That doesn't matter in a large sense, though it matters the way things
are.  As I said - get the VFS to look after the locking requests too ..
the problem here is really that what I asked for at the beginning is
precisely lacking - a call back from the FS to the VFS to ask it to lock
the inode against anyone else for a while.  Or ..  hmm.  Well, locking
the whole FS for the duration of the request sequence is the only other
reasonable approach, without knowledge of where the inode is on disk.

And that's not very nice. 

> is how the VFS is implemented at present time.
> 
> As of very recently, Andrew Morton introduced an optimization to this with
> the get_blocks() interface in 2.5 kernels. Now the file system, when doing
> direct_IO at least, returns to the VFS the requested block position _and_
> the size of the block. So the VFS now gains in power in that it only needs
> to ask for each block once as it is now aware of the size of the block.

I'm not sure I follow. The VFS already split the request up according
to your account above, so it doesn't care. I think you must be saying
that the VFS now DOES ask for more than 512B at a time? Can you
clarify? I imagine that the FS replies with how much of the i/o it did
this time, and thus the VFS knows if it should call again.

> But still, even with this optimization, the VFS still asks the FS for each
> block, and then the FS has to lookup each block.

Now I really don't understand you -- what's the point of the FS's
replying with the size of the block? Are you saying that it can reply
with a _larger_ size than the VFS asked for, sort of a "you can be
braver about this" invitation, so the VFS can ask for a bigger lump
next time?

> Obviously if only one file was written, and the disk is not fragmented,
> the file will be basically contiguous on disk. But if you wrote two
> or more files simultaneously they would be very likely interleaved, i.e.

That's OK. Imagine that most of the files were laid down beforehand,
and now we are simply rewriting over them.

> fragmented, i.e. each block would be small. - How an FS allocates space is
> entirely FS driver dependent so it is impossible to say how well the FS
> driver copes with simultaneous writes...

Doesn't matter. We can arrange that beforehand.

> > > need to read the disk inode just once and then you immediately read all the 
> > No, I think that's likely. I don't "think it". But yes, i assume that
> > in the case of a normal file it is quite likely that all the info
> > involved is in the inode, and we don't need to go hunting elsewhere.
> > 
> > Wrong?
> 
> In NTFS wrong. You have the base inode which contains all metadata (i.e. 
> modification times, security information, the conversion table from file
> offsets to disk locations, ...). However, as data is added to the file,
> the conversion table for example grows and eventually the inode runs out
> of space. (In NTFS inodes are fixed size records of 1024 bytes.) When that

Well, that I can imagine. Let's /not/ consider NTFS, then. I'd rather
consider something that hasn't taken about 5 years to reverse engineer
in the first place!  And NTFS is NOT going to be a candidate, because
of reliability. Does this happen on unix file systems too .. 

> happens, the NTFS driver either moves the conversion table completely to a
> 2nd inode (we call this inode an extent inode because it is _only_
> referenced by the original inode itself) or it splits the conversion table
> into two pieces and saves the 2nd part to a 2nd (extent) inode. The 2nd
> (extent) inode can be anywhere in the inode table, wherever the allocator
> finds a free one. When the 2nd inode fills up, the process is repeated, so
> we now have a 3rd (extent) inode, and so on, ad infinitum. So NTFS has

Well, something like that I distantly recall as happening on unix fs's,
but I'd like to know if we expect a file of fixed size which is being
overwritten without O_TRUNC to have any metadata changes apart from in
its inode (and there trivially) ...?

> So, in summary, if you have a small file _or_ the file is big
> but completely or almost completely unfragmented, then you are correct and
> one only needs the original inode. But as soon as you get a little
> fragmentation and you start needing extent inodes.

I thank you for that information about NTFS.

> > What I am not clear about now is exactly when the data is looked up - I
> > get the impression from what I have seen of the code that the VFS passes
> > down a complete request for 1TB, and that the the FS then goes and locks
> > the inode and chases down the data.  What you are saying above gives me
> > the impression that things are broken down into 512B lumps FIRST in or
> > above VFS, and then sent to the fs as individual requests with no inode
> > or fs locking. And I simply don't buy that as a strategy.
> 
> But that is how the VFS works! The VFS _does_ break up everything into
> 512B lumps FIRST. Let me show you where this happens (assume current 2.5

OK. Why 512? Why not the blocksize?

> kernel):
> 
> VFS: on file read we eventually reach:
> 
> mm/filemap.c::generic_file_read() which calls
> mm/filemap.c::do_generic_file_read() which breaks the request into units
> of PAGE_CACHE_SIZE, i.e. into individual pages and calls the file system's

Well, we're at 4096 now (or is it 8192 :-).

> address space ->readpage() method for each of those pages.
> 
> Assuming the file system uses the generic readpage implementation, i.e.
> fs/buffer.c::block_read_full_page(), this in turn breaks the page into
> blocksize blocks (for NTFS 512 bytes, remember?) and calls the FS

But not for any other FS.  I didn't even know 512 was a possible kernel
blocksize.  In fact, I'm fairly sure it wasn't in the recent past.  1024
eas the minimum, no?  And I'll choose 4096, thanks!

> supplied get_block() callback, once for each blocksize block (in the form
> of a struct buffer_head).

OK. But this will stick at 4096 blocks for other FSs.

I'm vary gratefull for this explanation BTW. gfr -> do_gfr -> breakup
-> readpage. I should be able to trace it from there. I'll expect that
the pagesize is the blocksize (or close), for optimum performance at
this point.

> This finds where this 512 byte block is, and maps the buffer head (i.e.

THAT's the inode lookup. OK, that's once per block, for the scenario
I'm imagining. So .. for reads the situation is fine. We can have a
read/write lock on  all FS metadata, and multiple readers will be
allowed at once. The problem is that as soon as anyone writes metadata,
then no reads can be allowed anywhere, unless we know where the inode
is.

So that's the perfect intercept. The get_block callback needs to return
an extra argument which is the physical block location of the inode
and I can lock that. That's perfect.

No?  Well, maybe we might have to go through several inodes, which all
need to be locked, wo we need to return an array.

> sets up the buffer_head to point to the correct on disk location) and
> returns it to the VFS, i.e. to block_read_full_page() which then goes and
> calls get_block() for the next blocksize block, etc...

Yes, this looks good.

> So this is how file reads work. For NTFS, I figured this is too
> inefficient (and because of other complications in NTFS, too) and I don't

Well, at 512B a time, it looks so!

> use block_read_full_page() any more. Instead, I copied
> block_read_full_page() and get_block() and rewrote them for NTFS so that
> they became one single function, which takes the page and maps all the
> buffers in it in one go, keeping the conversion table from file offsets to
> disk blocks locked (rw_semaphore) during that period. That is way more
> efficient as it means I don't need to do a lookup in the conversion table
> for every 512 byte block any more and instead I perform the lookup for all
> blocks in the current page in one go.

yes. Well, I didn't follow that detail. I'm still thinking about your
general statements, which look good to me. Unfortunately, I am betting
that at the moment the FS get_block returns _after_ getting the first
block, which is too late to return the inode position, if I try and do
that. This is awkward. We need to do the i/o after returning the inode
block(s) in order that the VFS can lock it/them.

Suggestion (start-io, end-io)?

> Note, Andrew Morton actually optimized this, too, in recent 2.5 kernels,
> where there is now a ->readpages() address space method which optimizes it
> even further. But that involves using BIOs instead of buffer heads and I
> haven't really looked into it much yet. (I want to keep NTFS as close to
> 2.4 compatibility as possible for the time being.)

Hmm.

> 
> 512 if the FS says so. blocksize on NTFS is 512 bytes. Fixed. Otherwise

:-). It won't say so, I somehow think!

> the code would have become too complicated...

OK.

> > > request is _individually_ looked up as to where it is on disk.
> > 
> > Then that's crazy, but, shrug, if you want to do things that way, it
> 
> I agree. Which is why I don't use block_read_full_page() in NTFS any
> more...
> 
> But you were talking modifying the VFS so I am telling you how the VFS
> works. An important issue to remember is that FS drivers don't have to use

Yes, that's very very very helpful, thanks.

> all the VFS helpers provided, they can just go off and implement their own

Well, they have to respond when asked.

> thing instead. But at least for file systems using the VFS helpers a
> modification of the VFS means changing every single FS driver using this

Only modify those that I want to use. The difficulty is in identifying a
strategy and a point at which a change can be made.

> > means that locking the inode becomes even more important, so that you
> > can cache it safely for a while. I'm quite happy with that. Just tell
> > me about it .. after all, I want to issue an appropriate  "lock"

Thanks for teling me! I appreciate it.

> > instruction from vfs before every vfs op. I would also like to remove
> > the dcache after every vfs opn, as we unlock. I'm asking for insight
> > into doing this ...
> >
> > > Each of those lookups requires a lot of seeks, reads, memory allocations, 
> > > etc. Just _read_ my post...
> > 
> > No they don't. You don't seem to realize that the remote disk server is
> > doing all that and has the data cached. What we, the client kernels
> > get, is latency in accessing that info, and not even that if we lock,
> > cache, and unlock.
> 
> I thought that your nodes are the disk servers at the same time, i.e. each

They generally are servers for some resources and clients for others.
I don't know at the moment if they will be clients for their "own"
resources, but even if they were, then I think it will be arranged that
they do block-level caching. I am not sure yet.

> node has several hds and all the hds together make up the "virtual" huge
> disk. Are you talking about a server with a single HD then? You

The standard configuration will likely be 1 disk per node, with
each disk being served to 3 other machines. The local node will partake of
three other remote disks.

Too early to say for sure.

> didn't define your idea precisely enough... It now makes no sense to me at
> all with your above comment...
> 
> Could you describe the setup you envision exactly? From the above it seems
> to me that you are talking about this:
> 
> - a pool of servers sharing the same harddisk, all the servers attached

No, not a pool. Each machine will be the same setup. But it will serve
for some resource(s) and be a client for others. It may be a client for
its own resource, but that is not sure yet.

> to the HD via SCSI or some simillar interface. - Or are you saying that
> there is a "master node" which has the hd attached and then all the other
> servers talk to the master node to get access to the disk?

Each is master for some and slave for others.

> - all the servers mount the HD with some FS and they somehow manage to get
> this right without breaking anything. Presumably all the servers are
> interconnected directly via some super fast super low latency interface? -

The topology is a grid. That is, neither star nor complete.

> Or do they all talk to the master node?
> 
> - the FS mounted on the servers is exported via NFS (or other networking
> FS) to the workstations which then read/write files on the NFS shares.

NFS is not the most likely candidate becuase of its known weaknesses, but
it is a possibility.

> is difficult to talk about it... Your turn to explain your idea better
> now. (-;

Well, it's hard to go into details because what I am asking for is clues
to enable the idea to be prototyped and evaluated. There will be a grid
topolgy. Each machine will locally be connected to several others. The
whole grid will form a ring (or a torus, if you see that I am talking
about a 2-D planar local connectivity graph, so that I must be talking
about an orientable surface ...). Each machine will have at least one
disk of its own, and share it with three other machines. There is
planned redundancy here (i.e. raid as well).

Peter
