Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbRHBXMG>; Thu, 2 Aug 2001 19:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269213AbRHBXL5>; Thu, 2 Aug 2001 19:11:57 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7946 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269154AbRHBXLu>; Thu, 2 Aug 2001 19:11:50 -0400
Date: Fri, 3 Aug 2001 01:11:56 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803011156.A8522@emma1.emma.line.org>
Mail-Followup-To: Andreas Dilger <adilger@turbolinux.com>,
	Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010802204710.B18742@emma1.emma.line.org> <200108022218.f72MIm8v028137@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200108022218.f72MIm8v028137@webber.adilger.int>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Andreas Dilger wrote:

> > open -> asynchronous, but filename synched on fsync()
> > rename/link/unlink(/symlink) -> synchronous
> > 
> > This way, you never need to fsync() the directory, so you never sync()
> > entries of temporary files. You never lose important files (because the
> > application uses fsync() and the OS synchs rename/link etc.).
> 
> Do you read what you are writing?  How can a "synchronous" operation for
> rename/link/unlink/symlink NOT also write out "temporary" files in the
> same directory?  How does calling fsync() on the directory IF YOU REQUIRE
> SYNCHRONOUS DIRECTORY OPERATIONS differ from making the specific operations
> synchronous from within the kernel???

Can people please try to understand? Can people please start to THINK
before flaming?

I did not say that open() is to be synchronous. I did not write ANYTHING
of fsync()ing directories, I'm trying to get rid of this requirement.

Thus, if the kernel does rename/link synchronously, you'd never ever
fsync() a directory. To synch a filename to disk, you'd just fsync() the
filedescriptor (with a SUS compliant system, that is, i. e. ext3 or
reiserfs, but not ext2).

Now, if someone opens a temporary file, and nukes it later -- unlink()
--, and doesn't want it visible, he never calls fsync() for the file.

However, if some other process then fsync()s the directory, you start
synching the temporary file dirent -> unnecessary, is nuked later on
with an unlink().

That's why fsync() on the directory is on no account the minimum work.

> The only difference I can see is that making these specific operations
> ALWAYS be synchronous hurts the common case when they can be async (see
> Solaris UFS vs. Linux benchmark elsewhere in this thread), while requiring
> an fsync() on the directory == only synchronous operation when it is
> actually needed, and no "extra" performance hit.

In case you haven't noticed, this is about reliability without need to
fsync() the directory that doesn't all belong to your single, stupid
process but may have lots of asynchronous data of other processes -
temporary files for instance. You synch() that as well, which is
unnecessary and brings down other processes' performance.

In case you haven't noticed the other issue:

The whole thread is a FEATURE REQUEST for a dirsync mount option, for
MTAs and other software which requires reliable file systems, where the
name is negotiable. It aims to REDUCE OVERHEAD since chattr +S which is
the only workaround for synch-dirs - and it synchs synchronous files and
writes as well, and rendering things slower than necessary, since
write() can be buffered until you fsync() (and you want that to cut off
seek times).

Call the option bsd_slow_dirs if you like, I don't care. Given the
option, the administrator/user has the choice, currently, he hasn't. He
cannot possibly change all applications ported from other Unices.

Note: hindering this option doesn't get Linux anywhere. Pure file
system benchmarks are not worth a single bit of entropy unless Linux is
benchmarked chattr +S -- it's unreliable otherwise.

I cannot remember how often I explained this during the course of this
thread. Every other day, some ignorant comes out of its cavern and
discusses the whole thing over and over again.

And, once again, fsync()ing the directory is not an option for portable
applications. It's unnecessary on every other system (until someone
shows a production-ready system which by default has asynchronous
directory updates as well, but no-one has so far.)
