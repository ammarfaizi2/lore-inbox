Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSICR1u>; Tue, 3 Sep 2002 13:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSICR1u>; Tue, 3 Sep 2002 13:27:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318870AbSICR1r>; Tue, 3 Sep 2002 13:27:47 -0400
Date: Tue, 3 Sep 2002 13:32:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209031629.g83GT2e08075@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.3.95.1020903131153.1376A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> "Richard B. Johnson wrote:"
> > On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > > It's not that hard - the locks are held on the remote disk by a
> > > "guardian" driver, to which the drivers on both of the kernels
> > > communicate.  A fake "scsi adapter", if you prefer.
> > > 
> > > > You really need file-system support.
> 
> > Lets say you have a perfect locking mechanism, a fake SCSI layer
> 
> OK.
> 
> > as you state. You are now going to create a new file on the
> > shared block device. You are careful that you use only space
> > that you "own", etc., so you perfectly create a new file on
> > your VFS.
> 
> OK.
> 
> > How does the other user's of this device "know" that there is
> > a new file so it can update its notion of the block-device state?
> 
> The block device itself is stateless at the block level. Every block
> access goes "direct to the metal".
> 

Well it doesn't. In particular SCSI and Fire-wire Drives have data
queued and, to give the CPU something to do while the writes are
occurring, the block-layer sleeps. So, you can have some other
task "think" wrong about the state of the machine.

> The question is how much FS state is cached on either kernel.
> If it is too much, then I will ask how I can cause to be less, perhaps
> by use of a flag that parallels how O_DIRECT works.  I thought that new
> files were entries in a directories inode and I agree that inodes are
> held in memory!  But I don't know when they are first read or reread.

Unless you unmount/re-mount, they will not be re-read. That's why you
need to "share" at the file-system level. FYI, it's already being
done and clustered disks were first done by DEC under RSX/11, then
under VAX/VMS. It's truly "old-hat".

> The directory entry would certainly have to be reread after a write
> operation on disk that touched it - or more simply, the directory entry
> would hvae to be reread every time it were needed, i.e. be uncached.
> 
> If that presently is not possible, then I would like to think about
> making it possible. Isn't there some kind of inode reading that goes on
> at mount? Can I cause it to happen (or unhappen) at will?
> 

Yes but you have a problem with synchronization. You need to synchronize
a file-system at the file-system level so that one process accessing the
file-system, obtains the exact same image as any other process.

> > You have created perfect isolation so, by definition, the other
> > isolated user's don't know that you have just used space that they
> > think that they own.
> 
> Well, I don't think that's a fair analogy .. if a "reserve_blocks"
> call is added to VFS, then I can use it to prelock the "space that
> they think they own", and prevent contention. The question is how
> each FS does the block reservation, and why it should not go through
> a generic method in the VFS layer.
> 
> > Now, the notion of a complete 'file-system' for support may not be
> > required. What you need is like a file-system without all the frills.
> 
> I think that's the wrong tack, though simply _disabling_ some
> operations initially (such as making new files!) may be the way to go.
> Just enable more ops as generic support is added.

Well, if you don't make new files, and you don't update any file-data,
they you just mount R/O and be done with it. When a FS is mounted
R/O, one doesn't care about atomicity anymore, only performance.

Once you allow a file's contents to be altered, you have the problem
of making certain that every processes' notion of the file contents
is identical. Again, that's done at the file-system layer, not at
some block layer.

> 
> > FYI, the "librarian" layer is the file-system so, I have shown that
> > you need file-system support.
> 
> Nice try - your argument reduces to saying that the state of the
> directory inodes must be shared. I agree and suggest two remedies
> 
>   1) maintain no directory inode state, but reread them every time
>      (how?)

If you don't maintain some kind of state, you end up reading all
directory inodes. I don't think you want that. You need to maintain
that "directory inode state" and that's what a file-system does.

>   2) force rereading of a particular inode or all inodes when
>      signalled to do so.

The signaler needs to "know". Which means that somebody is maintaining
the file-system state. You shouldn't have to re-invent file-systems to
do that. You just maintain synchronomy at the file-system level and
be done with it.

> 
> I would prefer (1). It seems in the spirit of O_DIRECT. I imagine that
> (2) is presently easy to do (but of course horrible).
> 
> Peter

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

