Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHBJD4>; Thu, 2 Aug 2001 05:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbRHBJDq>; Thu, 2 Aug 2001 05:03:46 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52747 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S268856AbRHBJDf>; Thu, 2 Aug 2001 05:03:35 -0400
Date: Thu, 2 Aug 2001 11:03:41 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010802110341.B17927@emma1.emma.line.org>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <9jpea7$s25$1@penguin.transmeta.com> <20010731025700.G28253@emma1.emma.line.org> <20010801170230.B7053@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010801170230.B7053@redhat.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2001, Stephen Tweedie wrote:

> > Chase up to the root manually, because Linux' ext2 violates SUS v2
> > fsync() (which requires meta data synched BTW)
> 
> Please quote chapter and verse --- my reading of SUS shows no such
> requirement.  
> 
> fsync is required to force "all currently queued I/O operations
> associated with the file indicated by file descriptor fildes to the
> synchronised I/O completion state."  But as you should know, directory
> entries and files are NOT the same thing in Unix/SUS.  

Read on: "All I/O operations are completed as defined for synchronised
I/O _file_ integrity completion.". To show what that means, see the
glossary.

http://www.opengroup.org/onlinepubs/007908799/xbd/glossary.html#tag_004_000_291

  "synchronised I/O data integrity completion

  [...]

  * For write, when the operation has been completed or diagnosed if
  unsuccessful.  The write is complete only when the data specified in
  the write request is successfully transferred and all file system
  information required to retrieve the data is successfully transferred.

  File attributes that are not necessary for data retrieval (access
  time, modification time, status change time) need not be successfully
  transferred prior to returning to the calling process.

  synchronised I/O file integrity completion

  Identical to a synchronised I/O data integrity completion with the
  addition that all file attributes relative to the I/O operation
  (including access time, modification time, status change time) will be
  successfully transferred prior to returning to the calling process."

As I understand it, the directory entry's st_ino is a file attribute
necessary for data retrieval and also contains the m/a/ctime, so it must
be flushed to disk on fsync() as well.

> There can be many ways of reaching that file in the directory
> hierarchy, or there can be none, but fsync() doesn't talk at all about
> the status of those dirents after the sync.

Well, if there's not a single dirent, you cannot retrieve the data, so
I'd assume at least one dirent needs to be flushed as well. If there's a
simple way to get unflushed dentries to disk (hard links included),
flush them. Not sure about symlinks, but since they don't share the
inode number, that might be rather difficult for the kernel (I didn't
check):

touch 1 ; ln 1 2 ; ln -s 1 3 ; ls -li

 303464 -rw-r--r--   2 emma     users           0 Aug  2 10:56 1
 303464 -rw-r--r--   2 emma     users           0 Aug  2 10:56 2
 303466 lrwxrwxrwx   1 emma     users           1 Aug  2 10:56 3 -> 1

-- 
Matthias Andree
