Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319072AbSIDFxC>; Wed, 4 Sep 2002 01:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319073AbSIDFxC>; Wed, 4 Sep 2002 01:53:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:26889 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319072AbSIDFxB>; Wed, 4 Sep 2002 01:53:01 -0400
Message-ID: <3D75A0DB.AAA60362@aitel.hist.no>
Date: Wed, 04 Sep 2002 07:57:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
References: <200209031730.g83HUIb15556@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> "A month of sundays ago David Lang wrote:"
> > Peter, the thing that you seem to be missing is that direct mode only
> > works for writes, it doesn't force a filesystem to go to the hardware for
> > reads.
> 
> Yes it does. I've checked! Well, at least I've checked that writing
> then reading causes the reads to get to the device driver. I haven't
> checked what reading twice does.

You tried reading from a file?  For how long are you going to
work on that data you read?  The other machine may ruin it anytime,
even instantly after you read it.

Now, try "ls -l" twice instead of reading from a file.  Notice
that no io happens the second time.  Here we're reading
metadata instead of file data.  This sort of stuff
is cached in separate caches that assumes nothing
else modifies the disk.



> 
> If it doesn't cause the data to be read twice, then it ought to, and
> I'll fix it (given half a clue as extra pay ..:-)
> 
> > for many filesystems you cannot turn off their internal caching of data
> > (metadata for some, all data for others)
> 
> Well, let's take things one at a time. Put in a VFS mechanism and then
> convert some FSs to use it.
> 
> > so to implement what you are after you will have to modify the filesystem
> > to not cache anything, since you aren't going to do this for every
> 
> Yes.
> 
> > filesystem you end up only haivng this option on the one(s) that you
> > modify.
> 
> I intend to make the generic mechanism attractive.

It won't be attractive, for the simple reason that a no-cache fs
will be devastatingly slow.  A program that read a file one byte at
a time will do 1024 disk accesses to read a single kilobyte.  And
it will do that again if you run it again.  

Nobody will have time to wait for this, and this alone makes your
idea useless.  To get an idea  - try booting with mem=4M and suffer.
a cacheless fs will be much much worse than that.

Using nfs or similiar will be so much faster.  Existing
network fs'es work around complexities by using one machine as
disk server, others simply transfers requests to and from that machine
and let it sort things out alone.

The main reason I can imagine for letting two machines write to
the *same* disk is performance.  Going cacheless won't give you
that.  But you *can* beat nfs and friends by going for
a "distributed ext2" or similiar where the participating machines
talks to each other about who writes where.  
Each machine locks down the blocks they want to cache, with
either a shared read lock or a exclusive write lock.

There is a lot of performance tricks you may use, such as
pre-reserving some free blocks for each machine, some ranges
of inodes and so on, so each can modify those without
asking the others.  Then re-distribute stuff occationally so
nobody runs out while the others have plenty.


Helge Hafting
