Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRELPVL>; Sat, 12 May 2001 11:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261269AbRELPUv>; Sat, 12 May 2001 11:20:51 -0400
Received: from THINK.THUNK.ORG ([216.175.175.162]:5638 "EHLO think.thunk.org")
	by vger.kernel.org with ESMTP id <S261268AbRELPUt>;
	Sat, 12 May 2001 11:20:49 -0400
Date: Sat, 12 May 2001 11:20:25 -0400
From: Theodore Tso <tytso@valinux.com>
To: Andrew McNamara <andrewm@connect.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010512112025.E22837@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Andrew McNamara <andrewm@connect.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E14ya9b-0004Bc-00@the-village.bc.nu> <20010512145338.0D3D6285BF@wawura.off.connect.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010512145338.0D3D6285BF@wawura.off.connect.com.au>; from andrewm@connect.com.au on Sun, May 13, 2001 at 12:53:37AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 12:53:37AM +1000, Andrew McNamara wrote:
> I seem to recall that in 2.2, fsync behaved like fdatasync, and that
> it's only in 2.4 that it also syncs metadata - is this correct?

No, fsync in 2.2 also sync'ed the metadata.  The question was always
the containing directory.

> 
> Do the BSD's sync the directory data on an fsync of a file? I guess
> this is the bone of contention - if linux is now doing exactly what BSD
> does, it will make it a lot easier to answer accusations of this
> nature.

I haven't looked at the BSD kernel code in a while, but it's actually
quite difficult to sync the directory data based on the file
descriptor, because you in general don't have a handle on the
directory entry used to open the file.  It turns out with Linux that
it's easier to do this, because of the dcache abstraction, but with
BSD internals, it'd be rather difficult, since you can't get back from
the inode to the directory which contains the inode.  

Sync'ing the directory entry also doesn't make much sense --- which
directory entry?  Suppose an application opens a file with O_CREAT,
and while the file descriptor is opened, it then creates 300 hard
links to that same file to different directories scattered all over
the filesystem.  It now does a fsync(); is it supposed to find all of
the directories which have hard links to that inode, and sync them
all?  That's pretty unreasonable.  

You could make the case that a file which is opened with the O_SYNC |
O_CREAT should sync the directory entry on an open, but to say that
fsync() should scan all directories on the filesystem to sync any hard
links that might have been created (possibly by some other process
that doesn't even have the file open) is quite ridiculous.  And if
that's the case, why should the directory which was used to open the
file be treated specially?

							- Ted

