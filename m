Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBTAlc>; Mon, 19 Feb 2001 19:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129138AbRBTAlX>; Mon, 19 Feb 2001 19:41:23 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:17158 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129112AbRBTAlH>; Mon, 19 Feb 2001 19:41:07 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 20 Feb 2001 11:40:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
Cc: dek_ml@konerding.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net, mason@suse.com
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: message from Alan Cox on Monday February 19
In-Reply-To: <14992.38288.497367.324493@notabene.cse.unsw.edu.au>
	<E14UoQA-0003BM-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 19, alan@lxorguk.ukuu.org.uk wrote:
> > I hope to put out a patch set for testing in a day or so and possibly
> > suggest it to Alan for his -ac series.  I don't see it going into
> > 2.4.2, but 2.4.3 might be possible if Linus agrees.
> 
> Im not interested in a patch that requires NFS is hacked for each file system
> that tells me the implementation is wrong. The previous setup worked perfectly
> for everything but reiserfs, so why isnt the newer setup one allowing each fs
> to override a generic behaviour which is the current working behaviour, thereby
> meaning all the other fs's work.
> 
> FS authors shouldnt have to do extra work to support knfsd unless they are doing
> interesting and unusual things

A fair question (it was a question, wasn't it :-) and I will see if I
can provide a convincing answer.

My answer has three parts:
  1/ iget abuse
  2/ lookup("..")
  3/ requirements to support knfsd.

Part 1 also contains some comments about reiserfs for Chris Mason.

---------------------------------------------------------------
1/ The linux-2.4 Todo list has, in section
    "10. To Do But Non Showstopper"

       - iget abuse in knfsd


  Part of the need for change to knfsd and filesystems is to fix this
  abuse.  But what is this abuse?  Well..

  iget is a (n often misunderstood I think) helper function for
  filesystems.   It helps maintain an inode cache.

  If a filesystem chooses, it may provide a read_inode super_operation
  and then call iget whenever it wants to find a particular inode.
  If iget finds the inode in the cache, it will return it.  If it
  doesn't it will create a new inode, set the i_ino field (and a few
  others) and pass this to read_inode for the filesystem to finish
  off.  iget handles any locking needed to make sure no inode gets
  created or read_inode'd twice.

  It is worth noting that read_inode does *not* have to actually read
  in the inode, though this is the typical (i.e. ext2fs) thing to do.
  nfs_read_inode, for example, just initialises a few extra fields in
  the inode.  After the call to iget completes, other parts of the nfs
  code fills in the rest of the inode from data received from the NFS
  server. 

  It is also worth noting that not all filesystems use
  iget/read_inode.  msdos/fat maintains it's own inode cache and so
  doesn't use the one provided by iget.

  A final point to note - and this is actually quite important - is
  that the value passed to iget (an inode number) needs to contain
  enough information to be able to answer "is this the right inode"
  (recognition) but does not need to be able to answer "where can I
  find this inode" (recall), though these two go together for ext2 and
  similar file systems.

  The case of nfs, already mentioned, shows this.  A filehandle is
  needed to find an inode, but a filehandle is not passed to iget.

  nfs did need an extension to iget though, and hence created iget4.
  The assumption that 4bytes is enough to recognise an inode is a bit
  dated.  NFSv3 needs at least 8bytes (because the fileid is 64bit)
  and Trond decided (quite reasonably) to use 16bytes (including the
  fsid).  Because these cannot be squeezed into a 32bit ino_t, he
  create iget4 which also had an opaque datum (arbitrary size) and an
  "actor" which would compare that datum against a given inode to see
  if there was a match.  This works fine, but is a bit awkward as the
  whole opaque datum is not available for hash calculations.  Maybe
  this can be tided up in 2.5.

  Note that this extension did not change the fact the iget has enough
  information to recognise, but not necessarily to recall an inode.

  When reiserfs came along, it abused this, and re-interpreted the
  opaque datum to contain information for recalling (locating) an
  inode - if read_inode2 was defined.  I think this is wrong.
  What reiserfs *should* do (I think) is:
   - Just pass the 32bit inode number to iget - this seems to be enough
      to recognise an inode in reiserfs.
   - have read_inode mark the inode as "incomplete" in some way.
   - In reiserfs_iget, after calling "iget", it should 
        +  lock the inode,
        +  check if it is incomplete or not
        +  if it is incomplete, read in the inode
        +  unlock the inode.

  This removes the need for read_inode2 and maintains the same
  concurrency controls.  Whether the locking can be done with
  I_LOCK/i_wait or not I am not sure.


  Anyway, back to nfsd:  nfsd currently gets an inode number out of
  the file handle and passes it to iget.  The above discussion of iget
  should show that this is the wrong thing to do.  In particular,
  knfsd needs to be able to recall (locate) an inode, and iget only
  guarantees being able to recognise one.  It happens to work
  for ext2fs, but it is an abuse of the interface and must change.

  If knfsd is not to use iget, it needs some other interface to use.
  My patch provides such an interface by defining an nfsd_operations
  structure which contains encode_fh and decode_fh so that a
  filesystem can determine exactly how to treat a filehandle for that
  filesystem.  It also provides helper functions so that the filesystem
  needs to do very little work itself.  But it does need to do some as
  the next section discusses.

------------------------------------------------------

2/ lookup("..").

  The VFS layer requires that every directory in the dcache be
  properly connected to the root of the filesystem.
  A particular reason for this is so that it can provide protection
  against two concurrent diretory renames creating an unreachable loop
  in the filesystem.  See s_vfs_rename_sem and is_subdir.

  When knfsd maps a filehandle to a directory, the ancestors of this
  directory may not be in the dcache, and so nfsd has to put them
  there before it does anything with the directory dentry.
  To be able to do this it must be able to find the parent of a given
  directory.   However, this is something that no other part of the
  filesystem code needs to do.
  You might think that chdir("..") needs to find the parent of a
  directory, but the filesystem never gets a chance to see the "..".
  This lookup is performed entirely in the dcache by the VFS layer.
  See follow_dotdot in fs/namei.c.

  Most filesystems (i.e. ext2fs) do support lookup("..") and will find
  the parent inode.  isofs is actually an interesting case.  It tries
  to even though there is no need, and it fails :-(

  So currently knfsd does a lookup of ".." to find the parent
  directory, and this works fairly well.  However the locking issues
  are a bit complex. 
  Doing the 'lookup("..")' through normal (i.e. VFS, channels) causes a
  dentry for ".." to be created, which is quite un-natural for the
  VFS.  It breaks rules such as "one dentry per directory".

  I think that the code in the current kernel that does this gets all
  the locking right, but I'm not 100% confident, particularly because
  it is difficult to reason about.  It is hard to reason about
  behaviour when you are breaking rules.

  In the most recent rewrite of the knfsd code where I started getting
  the filesystem involved in resolving file handles, I found that it
  was much easier to be confident of correctness if I got the
  filesystem to do the lookup("..") underneath the VFS layer.
  It could be argued that lookup_parent should be an inode_operation
  instead of an nfsd_operation, but either way, it needs to be
  exported for knfsd to be able to do it's job properly.


-------------------------------------------------------------

3/ requirements to support knfsd.

  It is already the case that a filesystem needs to do some special
  things to support knfsd:
   - it should maintain a generation number in i_generation so that
      kfnsd can tell if an inode number has been reused.
   - it must provide a read_inode routine that completely fills in the
     inode 
   - the read_inode routine should cope if asked to read an inode that
     doesn't exist, but returning a bad_inode.
   - it should support lookup("..").

 
  Before 2.2.14, no filesystem lived up to all of these.  Since then,
  ext2 does, but no other.

  What is needed for knfsd support with my patches?
   1/ A filesystem needs to assert that it is exportable.  Doing a
     lookup by filehandle is quite different from doing a lookup by
     name, and knfsd needs to know if it is reasonable with a given
     filesystem. 
     knfsd currently guess exportable filesystems be rejecting:
       those that have NODEV
       those that have no read_inode
     This is fairly adhoc.
     The NODEV requirement is still there, so knfsd can identify the
     filesystem, but instead of the read_inode test, a filesystem
     simply presents a non-NULL nfsd_operations structure.
     It can leave all fields NULL, but this cannot give full support:
 
    REQUIREMENT:  set sb->s_nfsd_op to an nfsd_operation structure.

  The filesystem can define encode_fh and decode_fh itself to do
  whatever it likes.  It can also define get_name and get_dentry to
  direct the filehandle lookup at a finer grained level.  However if
  it want to use the simple, least "interesting and unusual" approach,
  it must meet the following requirements:

  2/ As discussed above, knfsd needs to lookup(".."), and the vfs
     interface does not provide a clean way do do that, so:

    REQUIREMENT: define get_parent in the nfsd_operation structure to
      be a function which find the parent of a directory.  This is
      typically about the same size as the inode_operation->lookup
      function. 

  3/ Any time that an inode number gets reused for a different file,
     i_generation must be  set to a new value (with high
     degree of probability at least).
     As I said above, this is already a requirement, and only ext2
     meets it. 

    REQUIREMENT: maintain i_generation

  4/ As discussed above:

    REQUIREMENT: read_inode, must completely fill in the inode,
      and must reject requests for non-existing inodes by returning a
      bad_inode 

  5/ If a normal VFS operation builds a dcache path down to a
     directory at the same time that knfsd is trying to build a dcache
     path up from that directory, there is a real possibility of
     clashing and making duplicate dentries for some directories.  To
     guard against this, lookup and get_parent must co-operate with
     locking to make sure that only one of them attaches a dentry to a
     given inode.  This is easily done by calling a support routine in
     dcache.c

   REQUIREMENT:  lookup must call d_splice_alias when it finds
     an inode, and get_parent must call d_make_alias.


 This may seem like a lot, but several of these are already
 requirements which most filesystems don't meet, and other are there
 to tidy-up interfaces and make locking more straight forward.

 If there anything here has seems unreasonable?

NeilBrown
