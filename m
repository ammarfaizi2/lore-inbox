Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbRF2MUr>; Fri, 29 Jun 2001 08:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265873AbRF2MUi>; Fri, 29 Jun 2001 08:20:38 -0400
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:52747 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S265872AbRF2MUY>; Fri, 29 Jun 2001 08:20:24 -0400
Date: Fri, 29 Jun 2001 14:20:20 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: "Ph. Marek" <marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: sparse file creation in existing data?
In-Reply-To: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at>
Message-Id: <Pine.A32.3.95.1010629135834.61212E-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Ph. Marek wrote:

> Hi everybody,
> 
> though looking and grepping through the sources I couldn't find a way (via
> fcntl() or whatever) to allow an existing file to get holes.

Indeed, I don't think there is any such syscall.

> I found that cp has a parameter --sparse (or suchlike) - but strace shows
> it doing a open(,O_TRUNC) which has a bit of impact on previous filedata :-)

Holes are not made by specific syscalls, just by not writing data to
certain places. In principle, the write syscall could check if it just
writes zeroes and create a hole instead. Of course,
this check would be much slower than just writing the data to disk.
Probably a 'write_zeroes' syscall to create a hole (if possible) would be
better.

While I see your purpose and the advantage, this is a pretty specific
question and doesn't look like std. unix semantics. I doubt you'll get
people to add such a syscall (maybe if you implement it yourself, people
will accept it for addition, but I doubt even that).

For your specific problem I'd suggest the following approach:

write a new filter prog, kind of a 'destructive cat' command.

Open the file for read-modify (non destructive)
Let it read some blocks (number controllable on commandline) from the
beginning and pipe them to stdout. Then.. read in same amount (well;
block aligned) from the end of file and copy it over the beginning,
truncate the file accordingly. After some time reading and truncating
will meet in the middle of the file, then you read the blocks back in
on reverse (and truncate them after reading)

It shouldn't be too difficult to write and result in a multipurpose
commandline utility.

It does some disk i/o but I don't think it will too bad due to disk
buffers of the kernel and read-ahead. Theoretically, the kernel, buffers
etc. could detect you are just moving file blocks to different places and
does this in a 'zero-copy' fashion by just moving some inode entries
around, but I doubt that it is soo smart.

Drawback: If you have choosen the read block size too large (hmm.. you
might want to read some data from beginning, some from the end, copy over
beginning, then truncate, and only then pipe to stdout: this should
eliminate this 'buffer/diskspace overrun')  of 'destructive cat' too big,
or the archive is compressed and doesn't fit uncompressed, the backup was
destructed. This is by far not as safe as any backup tool should be.

A major advantage, however, is that this tool will run w/o a kernel patch,
on any Unix on any filesystem, even those w/o holes (I think truncate
works in general, maybe not samba?) 

Just my 0.02$ (you asked for ideas, didn't you?)

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

