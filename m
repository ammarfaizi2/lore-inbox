Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318862AbSICQYc>; Tue, 3 Sep 2002 12:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318864AbSICQYc>; Tue, 3 Sep 2002 12:24:32 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:28682 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318862AbSICQYb>;
	Tue, 3 Sep 2002 12:24:31 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031629.g83GT2e08075@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <Pine.LNX.3.95.1020903115445.1058A-100000@chaos.analogic.com> from
 "Richard B. Johnson" at "Sep 3, 2002 12:09:46 pm"
To: root@chaos.analogic.com
Date: Tue, 3 Sep 2002 18:29:02 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson wrote:"
> On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > It's not that hard - the locks are held on the remote disk by a
> > "guardian" driver, to which the drivers on both of the kernels
> > communicate.  A fake "scsi adapter", if you prefer.
> > 
> > > You really need filesystem support.

> Lets say you have a perfect locking mechanism, a fake SCSI layer

OK.

> as you state. You are now going to create a new file on the
> shared block device. You are careful that you use only space
> that you "own", etc., so you perfectly create a new file on
> your VFS.

OK.

> How does the other user's of this device "know" that there is
> a new file so it can update its notion of the block-device state?

The block device itself is stateless at the block level. Every block
access goes "direct to the metal".

The question is how much FS state is cached on either kernel.
If it is too much, then I will ask how I can cause to be less, perhaps
by use of a flag that parallels how O_DIRECT works.  I thought that new
files were entries in a directories inode and I agree that inodes are
held in memory!  But I don't know when they are first read or reread.
The directory entry would ceryainly have to be reread after a write
operation on disk that touched it - or more simply, the directory entry
would hvae to be reread every time it were needed, i.e. be uncached.

If that presently is not possible, then I would like to think about
making it possible. Isn't there some kind of inode reading that goes on
at mount? Can I cause it to happen (or unhappen) at will?

> You have created perfect isolation so, by definition, the other
> isolated user's don't know that you have just used space that they
> think that they own.

Well, I don't think that's a fair analogy .. if a "reserve_blocks"
call is added to VFS, then I can use it to prelock the "space that
they think they own", and prevent contention. The question is how
each FS does the block reservation, and why it should not go through
a generic method in the VFS layer.

> Now, the notion of a complete 'file-system' for support may not be
> required. What you need is like a file-system without all the frills.

I think that's the wrong tack, though simply _disabling_ some
operations initially (such as making new files!) may be the way to go.
Just enable more ops as generic support is added.

> FYI, the "librarian" layer is the file-system so, I have shown that
> you need file-system support.

Nice try - your argument reduces to saying that the state of the
directory inodes must be shared. I agree and suggest two remedies

  1) maintain no directory inode state, but reread them every time
     (how?)
  2) force rereading of a particular inode or all inodes when
     signalled to do so.

I would prefer (1). It seems in the spirit of O_DIRECT. I imagine that
(2) is presently easy to do (but of course horrible).

Peter
