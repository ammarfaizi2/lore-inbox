Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbRHBRVV>; Thu, 2 Aug 2001 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbRHBRVC>; Thu, 2 Aug 2001 13:21:02 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22803 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267124AbRHBRUv>; Thu, 2 Aug 2001 13:20:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 2 Aug 2001 19:26:16 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org>
In-Reply-To: <20010802110341.B17927@emma1.emma.line.org>
MIME-Version: 1.0
Message-Id: <01080219261601.00440@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 August 2001 11:03, Matthias Andree wrote:
> On Wed, 01 Aug 2001, Stephen Tweedie wrote:
> > Matthias Andree wrote:
> > > Chase up to the root manually, because Linux' ext2 violates SUS
> > > v2 fsync() (which requires meta data synched BTW)
> >
> > Please quote chapter and verse --- my reading of SUS shows no such
> > requirement.
> >
> > fsync is required to force "all currently queued I/O operations
> > associated with the file indicated by file descriptor fildes to the
> > synchronised I/O completion state."  But as you should know,
> > directory entries and files are NOT the same thing in Unix/SUS.
>
> Read on: "All I/O operations are completed as defined for
> synchronised I/O _file_ integrity completion.". To show what that
> means, see the glossary.
>
> http://www.opengroup.org/onlinepubs/007908799/xbd/glossary.html#tag_0
>04_000_291
>
>   "synchronised I/O data integrity completion
>
>   [...]
>
>   * For write, when the operation has been completed or diagnosed if
>   unsuccessful.  The write is complete only when the data specified
> in the write request is successfully transferred and all file system
> information required to retrieve the data is successfully
> transferred.
>
>   File attributes that are not necessary for data retrieval (access
>   time, modification time, status change time) need not be
> successfully transferred prior to returning to the calling process.
>
>   synchronised I/O file integrity completion
>
>   Identical to a synchronised I/O data integrity completion with the
>   addition that all file attributes relative to the I/O operation
>   (including access time, modification time, status change time) will
> be successfully transferred prior to returning to the calling
> process."
>
> As I understand it, the directory entry's st_ino is a file attribute
> necessary for data retrieval and also contains the m/a/ctime, so it
> must be flushed to disk on fsync() as well.

I believed you've summarized the SUS requirements very well.  Apart 
from legalistic arguments, SUS quite clearly states that fsync should 
not return until you are sure of having recorded not only the file's 
data, but the access path to it.  I interpret this as being able to 
"access the file by its name", and being able to guess by looking in 
lost+found doesn't count.  I don't see the point in niggling about that.

So, it seems clear that an fsync which leaves any window of 
vulnerability where an interruption can leave a file unlinked is not 
SUS-compliant.

> > There can be many ways of reaching that file in the directory
> > hierarchy, or there can be none, but fsync() doesn't talk at all
> > about the status of those dirents after the sync.

This is a legalistic argument.  I don't think we should be looking for 
loopholes in SUS here.  To achieve SUS compliance there are two 
reasonable courses: "fix SUS" or "fix sys_fsync".  Since what SUS 
clearly wants here seems emminently reasonable, I'd suggest putting the 
energy that's currently going into this thread into fixing fsync 
instead.

> Well, if there's not a single dirent, you cannot retrieve the data,
> so I'd assume at least one dirent needs to be flushed as well. If
> there's a simple way to get unflushed dentries to disk (hard links
> included)...

*All* hard links?  No, there is no general way to do that.  However, 
any hard links[1] in the path used to open the file - yes.  There is 
always a chain of parent dentries held locked in the dcache for any 
open file.

I don't know why it is hard or inefficient to implement this at the VFS 
level, though I'm sure there is a reason or this thread wouldn't 
exist.  Stephen, perhaps you could explain for the record why sys_fsync 
can't just walk the chain of dentry parent links doing fdatasync?  Does 
this create VFS or Ext3 locking problems?  Or maybe it repeats work 
that Ext3 is already supposed to have done?

> ...flush them. Not sure about symlinks, but since they don't
> share the inode number, that might be rather difficult for the kernel
> (I didn't check)

The prescription for symlinks is, if you want them safely on disk you 
have to explicitly fsync the containing directory.

[1] In Ext2, all filename dirents are "hard links", i.e., there is no 
way to tell which of the two names is the original after creating a new 
hard link.

--
Daniel
