Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRLMKCl>; Thu, 13 Dec 2001 05:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282841AbRLMKC0>; Thu, 13 Dec 2001 05:02:26 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38130 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282848AbRLMKCB>;
	Thu, 13 Dec 2001 05:02:01 -0500
Date: Thu, 13 Dec 2001 03:01:08 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011213030107.L940@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Quinn Harris <quinn@nmt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16DSDU-0001EN-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16DSDU-0001EN-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Dec 10, 2001 at 04:19:33PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 10, 2001  16:19 +0100, Daniel Phillips wrote:
> On December 10, 2001 06:44 am, Albert D. Cahalan wrote:
> > No, mmap+write does not do the job. SMB file servers have
> > a remote copy operation. There shouldn't be any need to
> > pull data over the network only to push it back again!
> 
> I don't get it, you're saying that this zero-copy optimization, which happens 
> entirely within the vfs, shouldn't be done because smb can't do it over a 
> network?

No, I think he means just the opposite - that having a "copy(2)" syscall
would greatly _help_ SMB in that the copy could be done entirely at the
server side, rather than having to pull _all_ of the data to the client
and then sending it back again.

When I was working on another network storage system (formerly called
Lustre, don't know what it is called now) we had a "copy" primitive in
the VFS interface, and there were lots of useful things you could do
with it.

Consider the _very_ common case (that nobody has mentioned yet) where you
are editing a large file.  When you write to the file, the editor copies
the file to a backup, then immediately truncates the original file and
writes the new data there.  What would be _far_ preferrable is to just
"copy" the file to the new location within the kernel (zero work), and
then the new data will be the only I/O going to disk.  This requires
some smarts on the part of the filesystem (essentially COW semantics),
but it well worth it on network storage.  Even for "dumb" filesystems,
we could save the two (or one, with mmap) userspace copies, and optimize
to-boot (because we know the full size of the file in advance).

What about "link" you say?  Well, emacs at least does a full copy instead
of a link, so that things like "cp -al linux-2.4.17 linux-2.4.17-new" will
work properly when you edit files in one of those trees.  Not that I'm
an emacs user...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

