Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSIFOUp>; Fri, 6 Sep 2002 10:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318635AbSIFOUp>; Fri, 6 Sep 2002 10:20:45 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:9228 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318288AbSIFOUo>;
	Fri, 6 Sep 2002 10:20:44 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209061425.g86EPGW10158@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <5.1.0.14.2.20020905235933.04082dc0@pop.cus.cam.ac.uk> from Anton
 Altaparmakov at "Sep 6, 2002 00:06:37 am"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Fri, 6 Sep 2002 16:25:16 +0200 (MET DST)
Cc: Daniel Phillips <phillips@arcor.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Anton Altaparmakov wrote:"
> The procedure described is _identical_ if you want to access 1TiB at a 
> time, because the request is broken down by the VFS into 512 byte size 

I think you said "1byte". And aren't these 4096B, or whatever the
blocksize is?

> units and I think I explained that, too. And for _each_ 512 byte sized unit 
> of those 1TiB you would have to repeat the _whole_ of the described 

Why? Doesn't the inode usually point at a contiguous lump of many
blocks? Are you perhaps looking at the worst case, not the usual case?

> procedure. So just replace 1 byte with 512 bytes in my post and then repeat 
> the procedure as many times as it takes to make up the 1TiB. Surely you 
> should know this... just fundamental Linux kernel VFS operation.

Well, you seem to have improved the situation by a factor of 512 in
just a few lines. Perhaps you can improve it again ...?

> It is not clear to me he understands the concept at all. He thinks that you 

Well, "let it be clear to you".

> need to read the disk inode just once and then you immediately read all the 

No, I think that's likely. I don't "think it". But yes, i assume that
in the case of a normal file it is quite likely that all the info
involved is in the inode, and we don't need to go hunting elsewhere.

Wrong?

> 1TiB of data and somehow all this magic is done by the VFS. This is 

No, the fs reads.  But yes, the inode is "looked up once" on average, I
believe, and if it says there's 1TB of data on disk here, here and here,
then I am going to tell you that I think it's locked in the fs while we
go look up the data on disk in the fs.

What I am not clear about now is exactly when the data is looked up - I
get the impression from what I have seen of the code that the VFS passes
down a complete request for 1TB, and that the the FS then goes and locks
the inode and chases down the data.  What you are saying above gives me
the impression that things are broken down into 512B lumps FIRST in or
above VFS, and then sent to the fs as individual requests with no inode
or fs locking. And I simply don't buy that as a strategy.

> complete crap and is _NOT_ how the Linux kernel works. The VFS breaks every 
> request into super block->s_blocksize sized units and _each_ and _every_ 

Well, that's 4096 (or 1024), not 512.

> request is _individually_ looked up as to where it is on disk.

Then that's crazy, but, shrug, if you want to do things that way, it
means that locking the inode becomes even more important, so that you
can cache it safely for a while. I'm quite happy with that. Just tell
me about it .. after all, I want to issue an appropriate  "lock"
instruction from vfs before every vfs op. I would also like to remove
the dcache after every vfs opn, as we unlock. I'm asking for insight
into doing this ...

> Each of those lookups requires a lot of seeks, reads, memory allocations, 
> etc. Just _read_ my post...

No they don't. You don't seem to realize that the remote disk server is
doing all that and has the data cached. What we, the client kernels
get, is latency in accessing that info, and not even that if we lock,
cache, and unlock.

> Please, I really wouldn't have expected someone like you to come up with a 
> statement like that... You really should know better...

If you know the person involved then try and entertain the idea that
they're not crazy, and suspect that other people are not crazy (or
illogical) either!

Peter
