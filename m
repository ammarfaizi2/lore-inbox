Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSIEOUd>; Thu, 5 Sep 2002 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSIEOUc>; Thu, 5 Sep 2002 10:20:32 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:40463 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317580AbSIEOU1>;
	Thu, 5 Sep 2002 10:20:27 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209051424.g85EOx105274@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <3D771613.783E3B15@aitel.hist.no> from Helge Hafting at "Sep 5,
 2002 10:30:11 am"
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Thu, 5 Sep 2002 16:24:59 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI .. I'm currently in an internet cafe in nice, france, watching the
rain come down, so forgive me if I don't do you justice. I find this
reply to be excelent for my purposes. Thank you.

"Helge Hafting wrote:"
> "Peter T. Breuer" wrote:
> > I'm not following you. It seems to me that you are discussing the
> > process of getting a buffer to write to prior to letting it age and
> > float down to the device driver via the block layers. But we have
    ...

> Some very basic definitions that anyone working on a 
> disk-based filesystem should know:

Thanks.

> Logical block number is the block's number in the file.  Example:
> "this is the 67th kilobyte of this file"

Aha. OK.

> Physical block number is something completely different, it
> is the block's location on disk.  Example:

Yes.

> 1.
> Your app asks for the first 10M or so of the file. (You're
> shuffling _big_ chunks around, possibly over the net, aren't you?)

Yes.

> 2.
> The fs however is using a smaller blocksize, such as 4k.  So your
> big request is broken down into a bunch of requests for the
> first 4k block, the second 4k block and so on up to the
> 2560th 4k block.  So far, everything happens fast no matter
> what kind of fs, or even your no-cache scheme.

Fine, but where is the log/phys translation done? I presume that the
actual inode contains sufficient info to do the translation, because
the inode has a physical location on disk, and it is also associated
with a file, and what we do is generally start from the inode and trace
down to where the inode says the logical block shoul dbe, and then look
it up. During this time the inode location on disk must be locked
(with a read lock). I can do that. If you let me have "tag 
requests" in the block layers and let me generate them in the VFS
layers. Yes, I agree, I have to know where the inode is on disk
in order to generate the block request, but the FS will know,
and I just want it to tell VFS .. well, too much detail.

> 3.
> The reason for this breakup is that the file might be fragmented
> on disk.  No one can know that until it is checked, so

Yes, indeed. I agree.

> each block is checked to see where it is.  The kernel
> tries to be smart and merges requests whenever the
> logical blocks in the file happens to be consecutive

That's fine. This is the elevator alg. working in the block layers.
Theer's no problem there. What I want to know is more about the
lookup procedure for the inode, but already this much info is enough
to confirm the picture I have. One needs to lock the inode position
on disk.

> 4. 
> The list of physical positions (or physical blocks)
> are passed to thbe disk drivers and the read 

> Number (3) is where the no-cache operation breaks
> down completely.  We have to look up where on the _disk_
> _every_ small block of the file exists.  The information

Yes. But this is not a "complete breakdown" but a requirement to 
(a) lock bits of disk not associated with data while we look at them,
and (b) relook again next time.

Frankly, a single FS lock works at this point. That is, a single
location on disk (say the sb) that can be locked by some layer.
It can be finer, but there's no need to. The problem is avoiding
caching the metadata lookup that results, so that next time we look it
up again.


> about where the blocks are is called "metadata".  
> So we need to look at metadata for every little 4k block.

No .. I don't see that. Not every block has some unique metadata
associated, with it, surely? I thought that normally inodes
were "direct", that is, pointing at contiguous lumps? Sure,
sometimes some other lookups might be required. but often? No.

Especially if you imagine that 99.99% of the ops on the file system will
be rewriting or rereading files. Just a "metadata updated" flag on the
FS might be useful to avoid looking everything up again avery time, 
but I realy would like to see how much overhead there IS first.

> That isn't a problem usually, because the metadata is
> small and is normally cached entirely, even for a large
> file.  So we can look up "wher block 1 is on disk, where block 2
> is on disk..." by looking at a little table in memory.

Well, or on disk :-)

> But wait - you don't allow caching, because some other node

Thanks, but I know. That's right - we have to look up the inode again.
That's precisely what I want to do.

> may have messed with this file!

May have, but probably won't. To have messed with it it must
have messed with the inode, and we can ask the driver if anyone
but us has written to that spot (the inode), and if not, not
reread it. That's just an idea, but really, I would prefer to reread
it. Data reads and writes will generally be in lumps the order of
0.25M. An extra 4K on that is latency, not appreciable extra data.

> So we have to read metadata *again* for each little
> block before we are able to read it, for you don't let

No, not each little block. I disagree totally. Remember that
we get the lock on the inode area at the start of the opn. Nobody
can mess with it while we do the sequence of small reads or writes
(which will be merged into large reads or writes). That was the
whole point of my request for extra "tag requests" in the block
layer. I want to be able to request a region lock, by whatever
mechanism.

> us cache that in order to look up the next block.

At this point the argument has gone wrong, so I can't follow ...

> Now metadata is small, but the disk have to seek
> to get it.  Seeking is a very expensive operation, having
> to seek for every block read will reduce performance to
> perhaps 1% of streaming, or even less.

Well, you forget that we had to seek there anyway, and that the
_server_ kernel has cached the result (I am only saying that the
_client_ kernels need O_*DIRECT) , and that therefore there is
no ondisk seek on the real device, just a "memory seek" in the
guardian of the real device.

> And where on disk is the metadata for this file?
> That information is cached too, but you
> disallow caching.  Rmemeber, the cache isn't just for 

You are confusing yourself with syntax instead of semantics, I think ..
I can't relate this account to anything that really happens right now.
The words "no caching" only apply to the kernel for which the
real device is remote. On the kernel for which it is local, of course
there is block-level caching (though not FS level caching, I hope!).

> And as Anton Altaparmakov pointed out, finding the metadata
> for a file with _nothing_ in cache requires several
> reads and seeks.  You end up with 4 or more seeks and

This is all way off beam .. sorry. I'd like to know why people
imagine in this way .. it doesn't correspond to the real state
of play.

> small reads for every block of your big file.
> 
> With this scheme, you need thousands of pcs just to match

No.

> the performance of a _single_ pc with caching, because
> the performance of _one_ of your nodes will be so low.

> > Uh, I'm not sure I understand any of this. You are saying something
> > about logical/physical that I don't follow or don't know. In
> 
> Take a course in fs design, or read some books at least.  Discussion

Well, tell me whatyou mean by "logical". telling me you mean "offset 
within file" is enough  explanation for me! I really wish you would
stop patronising - you are confusing unfamiliarity with YOUR jargon
for unfamiliarity with the logic and the science involved. Try again.

> is pointless when you don't know the basics - it is like discussing
> advanced math with someone who is eager and full of ideas but 
> know the single-digit numbers only.

No, it isn't. You way overestimate yourself, I am afraid.

> You can probably come up with something interesting _when_ you
> have learned how filesystems actually works - in detail.

I don't need to. Sorry.

> If you don't bother you'll end up a "failed visionary".

I am not trying to be a visionary. I am an extremely practical person.
I want your input so I can DO something. When I've tried it, we can
speak further.

> > Is that relevant?
> Both irrelevant and wrong.  Direct io isn't serialized, but

It appears to be. I have measured the sequencialization that takes
place on reads and writes through direct_io at the block level in
2.5.31, and as far as in can tell, a new write request does not go
out before the "previous" one has come back in. Shrug.

> it don't matter.
> 
Peter
