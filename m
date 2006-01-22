Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAVSzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAVSzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWAVSzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:55:33 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:734 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750773AbWAVSzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:55:32 -0500
Message-ID: <43D3D4DF.2000503@comcast.net>
Date: Sun, 22 Jan 2006 13:54:23 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org>
In-Reply-To: <20060122093144.GA7127@thunk.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Theodore Ts'o wrote:
> On Sun, Jan 22, 2006 at 01:42:38AM -0500, John Richard Moser wrote:
> 
>>Soft Update appears to have the advantage of not needing multiple
>>writes.  There's no need for journal flushing and then disk flushing;
>>you just flush the meta-data.  
> 
> 
> Not quite true; there are cases where Soft Update will have to do
> multiple writes, when a particular block containing meta-data has
> multiple changes in it that have to be committed to the filesystem at
> different times in order to maintain consistency; this is particularly

Yes, that makes sense.

> true when a block is part of the inode table, for example.  When this
> happens, the soft update machinery has to allocate memory for a block
> and then undo changes to that block which come from transactions that
> are not yet ready to be written to disk yet.
> 
> In general, though, it is true that Soft Updates can result in fewer
> disk writes compared to filesystems that utilizing traditional
> journaling approaches, and this might even be noticeable if your
> workload is heavily skewed towards metadata updates.  (This is mainly
> true in benchmarks that are horrendously disconneted to the real
> world, such as dbench.)

Yeah, microbenchmarks are like "AFAFAFAFAFFAF THIS WILL NEVAR HAPPAN MOR
THAN 1 EVERY BILLION ZILLION YARS BUT LOOK WER FASTAR BY LIKE 1
MICROSECOND" stuff.

> 
> One major downside with Soft Updates that you haven't mentioned in
> your note, is that the amount of complexity it adds to the filesystem
> is tremendous; the filesystem has to keep track of a very complex
> state machinery, with knowledge of about the ordering constraints of
> each change to the filesystem and how to "back out" parts of the
> change when that becomes necessary.

Yes, I had figured soft update would be a lot more complex than
journaling.  Though, could this be majorly implimented filesystem
independent?  I could see a "Soft Update API" to allow file systems to
sketch out dependencies each meta-data operation has and describe order;
it would, of course, be a total pain in the ass to do.

> 
> Whenever you want to extend a filesystem to add some new feature, such
> as online resizing, for example, it's not enough to just add that

Online resizing is ever safe?  I mean, with on-disk filesystem layout
support I could somewhat believe it for growing; for shrinking you'd
need a way to move files around without damaging them (possible).  I
guess it would be.

So how does this work?  Move files -> alter file system superblocks?

> feature; you also have to modify the black magic which is the Soft
> Updates machinery.  This significantly increases the difficulty to add
> new features to a filesystem, and can add as a roadblock to people
> wanting to add new features.  I can't say for sure that this is why
> 
> BSD UFS doesn't have online resizing yet; and while I can't
> conclusively blame the lack of this feature on Soft Updates, it is
> clear that adding this and other features is much more difficult when
> you are dealing with soft update code.
> 

Nod.

> 
>>Also, soft update systems mount instantly, because there's no
>>journal to play back, and the file system is always consistent.  
> 
> 
> This is only true if you don't care about recovering lost data blocks.
> Fixing this requires that you run the equivalent of fsck on the
> filesystem.  If you do, then it is major difference in performance.
> Even if you can do the fsck scan on-line, it will greatly slow down
> normal operations while recovering from a system crash, and the
> slowdown associated with doing a journal replay is far smaller in
> comparison.

A passive-active approach could passively generate a list of inodes from
dentries as they're accessed; and actively walk the directory tree when
the disk is idle.  Then a quick allocation check between inodes and
whatever allocation lists or trees there are could be done.

This has the disadvantage that if the system is under heavy load, the
recovery won't be done.  There's also a period where the disk may be
rather full, causing fragmentation or out of space errors along the way.
 The only way to counter this would be to force a mandatory minimum
amount of recovery activity per time interval, which again causes your
problem.

> 
> 
>>Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
>>USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
>>Sure it could be done in 8 or 4 or so; or (in one of my file system
>>designs) a static 16KiB block could reference dynamicly allocated
>>journal space, allowing the system to sacrifice performance and shrink
>>the journal when more space is needed.  Either way, slow media like
>>floppies will suffer, HARD; and flash devices will see a lot of
>>write/erase all over the journal area, causing wear on that spot.
> 
> 
> If you are using flash, use a filesystem which is optimized for flash,
> such as JFFS2.  Otherwise, note that in most cases disk space is

What about a NAND flash chip on a USB drive like a SanDisk Cruizer Mini?
 Or hell, a compact flash card for use in a digital camera.

> nearly free, so allocating even 128 megs for the journal is chump
> change when you're talking about a 200GB or larger hard drive.
> 
> Also note that if you have to use slow media, one of the things which
> you can do is use a separate (fast) device for your journal; there is
> no rule which says the journal has to be on the slow device.  

Unless it's portable and you don't want to reconfigure every system.

> 
> 						- Ted
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD09TdhDd4aOud5P8RAv1HAJ9SUeY0c42RognwsR6ve1w4XvFalwCdFc8N
feGuco4l9lz4yQB4U3tDcW8=
=4QFG
-----END PGP SIGNATURE-----
