Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264308AbRF2SjO>; Fri, 29 Jun 2001 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRF2SjE>; Fri, 29 Jun 2001 14:39:04 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:13559 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264308AbRF2Siw>; Fri, 29 Jun 2001 14:38:52 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106291838.f5TIcbAM015809@webber.adilger.int>
Subject: Re: Q: sparse file creation in existing data?
In-Reply-To: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at>
 "from Ph. Marek at Jun 29, 2001 01:39:15 pm"
To: "Ph. Marek" <marek@bmlv.gv.at>
Date: Fri, 29 Jun 2001 12:38:37 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil writes:
> though looking and grepping through the sources I couldn't find a way (via
> fcntl() or whatever) to allow an existing file to get holes.
> 
> What I'd like to do is something like
> 
>   fh=open( ... , O_RDWR);
>   lseek(fh, position ,SEEK_START); 
> // where position is a multiple of fs block size
>   fcntl(fh,F_MAKESPARSE,16384);
> 
> to create a 16kB hole in a file.
> If the underlying fs doesn't support holes, I'd get ENOSYS or something.

Peter Braam <braam@clusterfilesystem.com> implemented such a syscall, and
support for it in ext2, in the 2.2 kernel.  It is called "sys_punch"
(punching holes in a file).  I'm not sure how applicable the patch is
in the 2.4 world (probably not at all, unfortunately).  I did a port of
this code to 2.2 ext3 a long time ago, but have not kept it updated.
I'm not sure it was 100% race free (Al would probably say not), but it
worked well enough while I was using it.

The basic premise is that it will write zero's to partial blocks at the
beginning and end of the punch region, and make holes of any intervening
blocks.  It did NOT do checks to see if a partial block was entirely
zero filled and make it a hole (although that would be a possible feature).

It could be used as a replacement for the truncate code, because then
truncate is simply a special case of punch, namely punch(0, end).

> What I'd like to use that for:
> 
> I imagine having a file on hd (eg. tar) and not enough space to decompress.
> So with SOME space at least I'd open the file and stream it's data to tar,
> after each few kB read I'd free some space - so this could eventually succeed.
> 
> I also thought about simple reversing the filedata - so I'd read off the
> end of the file and truncate() downwards - but that would mean reversing
> the whole file which could take some time on creation and would solve only
> this specific case.

I'm not sure I would agree with your application, but I do agree that there
are some uses for it.  In Peter's case he used it for implementing a
cacheing HFS storage system, but he also wanted to use it for InterMezzo
(a cacheing network filesystem) to do several things:
- delete entries from a transaction log, in a way that actually reduces
  the physical size of the log.  The log itself could be always appended
  to the end (for 64-bit file size), but transactions/blocks would be
  punched from the beginning.
- delete blocks from the beginning/middle of large files cached on the client.
  This is useful if the file size is too large to fit into the cache, or if
  you are doing some sort of LRU replacement of blocks in the cache.

I don't think any of this has been implemented in InterMezzo yet.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
