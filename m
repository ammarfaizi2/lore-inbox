Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSIERDU>; Thu, 5 Sep 2002 13:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSIERDU>; Thu, 5 Sep 2002 13:03:20 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:12492 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S317855AbSIERDS>; Thu, 5 Sep 2002 13:03:18 -0400
Date: Thu, 5 Sep 2002 09:59:51 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209051424.g85EOx105274@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0209050940370.3871-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Peter T. Breuer wrote:

> HI .. I'm currently in an internet cafe in nice, france, watching the
> rain come down, so forgive me if I don't do you justice. I find this
> reply to be excelent for my purposes. Thank you.

enjoy yourself

> "Helge Hafting wrote:"
> > "Peter T. Breuer" wrote:
> > 2.
> > The fs however is using a smaller blocksize, such as 4k.  So your
> > big request is broken down into a bunch of requests for the
> > first 4k block, the second 4k block and so on up to the
> > 2560th 4k block.  So far, everything happens fast no matter
> > what kind of fs, or even your no-cache scheme.
>
> Fine, but where is the log/phys translation done? I presume that the
> actual inode contains sufficient info to do the translation, because
> the inode has a physical location on disk, and it is also associated
> with a file, and what we do is generally start from the inode and trace
> down to where the inode says the logical block shoul dbe, and then look
> it up. During this time the inode location on disk must be locked
> (with a read lock). I can do that. If you let me have "tag
> requests" in the block layers and let me generate them in the VFS
> layers. Yes, I agree, I have to know where the inode is on disk
> in order to generate the block request, but the FS will know,
> and I just want it to tell VFS .. well, too much detail.
>

ahh, but the problem is that you have to lookup where the inode is, so you
have to start from the layer above that, etc eventually getting to the
large number of accesses required that were documented in an earlier post.
remember that the low levels don't know the difference between data and an
Inode, only the filesystem code knows which is which.

> > about where the blocks are is called "metadata".
> > So we need to look at metadata for every little 4k block.
>
> No .. I don't see that. Not every block has some unique metadata
> associated, with it, surely? I thought that normally inodes
> were "direct", that is, pointing at contiguous lumps? Sure,
> sometimes some other lookups might be required. but often? No.

but if you cache the inode contents then you have consistancy problems
between multiple machines, if you don't cache the inodes then you have to
find them and read their contents each time.

> Especially if you imagine that 99.99% of the ops on the file system will
> be rewriting or rereading files. Just a "metadata updated" flag on the
> FS might be useful to avoid looking everything up again avery time,
> but I realy would like to see how much overhead there IS first.

but now this is filesystem specific, not a generic mechanism.

> > That isn't a problem usually, because the metadata is
> > small and is normally cached entirely, even for a large
> > file.  So we can look up "wher block 1 is on disk, where block 2
> > is on disk..." by looking at a little table in memory.
>
> Well, or on disk :-)

take a look at disk seek times, newer disks have increased the transfer
rate and capacity significantly, but seek times are hovering in the mid
single digit ms range, you have to seek to the place on disk that holds
your metadata (potentially several seeks) and then seek back to the data,
if the data happened to be the next block on disk you have now bounced the
ehad all over the disk in between, eliminating the elevator algorithm and
any chance of merging the requests.

> May have, but probably won't. To have messed with it it must
> have messed with the inode, and we can ask the driver if anyone
> but us has written to that spot (the inode), and if not, not
> reread it. That's just an idea, but really, I would prefer to reread
> it. Data reads and writes will generally be in lumps the order of
> 0.25M. An extra 4K on that is latency, not appreciable extra data.

but at the low levels the data is all 4K reads, these reads can be merged
if the metadata tells you that they are adjacent, but if you have to
lookup the metadata between each block (since you can't look it up in
memory...)

> > So we have to read metadata *again* for each little
> > block before we are able to read it, for you don't let
>
> No, not each little block. I disagree totally. Remember that
> we get the lock on the inode area at the start of the opn. Nobody
> can mess with it while we do the sequence of small reads or writes
> (which will be merged into large reads or writes). That was the
> whole point of my request for extra "tag requests" in the block
> layer. I want to be able to request a region lock, by whatever
> mechanism.

This locking is the coordination between multiple machines that the
specialized distributed filesystems implement. if you are going to
implement this on every filesystem then you are going to turn every one of
them into a cooperative DFS.

> Well, you forget that we had to seek there anyway, and that the
> _server_ kernel has cached the result (I am only saying that the
> _client_ kernels need O_*DIRECT) , and that therefore there is
> no ondisk seek on the real device, just a "memory seek" in the
> guardian of the real device.
>
> > And where on disk is the metadata for this file?
> > That information is cached too, but you
> > disallow caching.  Rmemeber, the cache isn't just for
>
> You are confusing yourself with syntax instead of semantics, I think ..
> I can't relate this account to anything that really happens right now.
> The words "no caching" only apply to the kernel for which the
> real device is remote. On the kernel for which it is local, of course
> there is block-level caching (though not FS level caching, I hope!).

Ok, here is one place where the disconnect is happening.

you are thinking of lots of disks attached to servers that the servers
then reexport out to the network. this is NFS with an added layer on top
of it. sharing this is simple, but putting another filesystem on top of it
is of questionable use.

what the rest of us are thinking of is the Storage Area Network (SAN
topology where you have large arrays of disks with fibre channel on each
disk (or each shelf of disks) and fibre channel into each server. every
server can access every disk directly. there is not 'local' server to do
any caching.

anyplace that is running multi TB of disks to multiple servers is almost
certinly going to be doing something like this, otherwise you waste
bandwidth on your 'local' server when a remote machine wants to access the
drives, and that bandwidth is frequently the bottleneck of performance for
those local boxes (even 66MHz 64 bit PCI is easily swamped when you start
talking about multiple Gb NICs plus disk IO)

 David Lang
