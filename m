Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319084AbSIDGon>; Wed, 4 Sep 2002 02:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319085AbSIDGon>; Wed, 4 Sep 2002 02:44:43 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:35594 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319084AbSIDGom>; Wed, 4 Sep 2002 02:44:42 -0400
Message-ID: <3D75ACFA.480860BB@aitel.hist.no>
Date: Wed, 04 Sep 2002 08:49:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
References: <200209040621.g846LTO10461@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> "A month of sundays ago Helge Hafting wrote:"
> > "Peter T. Breuer" wrote:
> > > "A month of sundays ago David Lang wrote:"
> > > > Peter, the thing that you seem to be missing is that direct mode only
> > > > works for writes, it doesn't force a filesystem to go to the hardware for
> > > > reads.
> > >
> > > Yes it does. I've checked! Well, at least I've checked that writing
> > > then reading causes the reads to get to the device driver. I haven't
> > > checked what reading twice does.
> >
> > You tried reading from a file?  For how long are you going to
> 
> Yes I did. And I tried readingtwice too, and it reads twice at device
> level.
> 
> > work on that data you read?  The other machine may ruin it anytime,
> 
> Well, as long as I want to. What's the problem? I read file X at time
> T and got data Y. That's all I need.

No problem if all you do is use file data.  A serious problem if
the stuff you read is used to make a decision about where
to write something else on that shared disk.  For example:
The fs need to extend a file.  It reads the free block bitmap,
and finds a free block.  Then it overwrites that free block,
and also write back a changed block bitmap.  Unfortunately
some other machine just did the same thing and you
know have a crosslinked and corrupt file.

There are several similiar scenarios. You can't really talk
about "not caching".  Once you read something into
memory it is "cached" in memory, even if you only use it once
and then re-read it whenever you need it later.
> 
> > even instantly after you read it.
> 
> So what?
See above. 

> > Now, try "ls -l" twice instead of reading from a file.  Notice
> > that no io happens the second time.  Here we're reading
> 
> Directory data is cached.
> 
> > metadata instead of file data.  This sort of stuff
> > is cached in separate caches that assumes nothing
> > else modifies the disk.
> 
> True, and I'm happy to change it. I don't think we always had a
> directory cache.

> 
> > > > filesystem you end up only haivng this option on the one(s) that you
> > > > modify.
> > >
> > > I intend to make the generic mechanism attractive.
> >
> > It won't be attractive, for the simple reason that a no-cache fs
> > will be devastatingly slow.  A program that read a file one byte at
> 
> A generic mechanism is not a "no cache fs". It's a generic mechanism.
> 
> > Nobody will have time to wait for this, and this alone makes your
> 
> Try arguing logically. I really don't like it when people invent their
> own straw men and then procede to  reason as though it were *mine*.
> 
Maybe I wasn't clear.  What I say is that a fs that don't cache
anything in order to avoid cache coherency problems will be
too slow for generic use.  (Such as two desktop computers
sharing a single main disk with applications and data)
Perhaps it is really useful for some special purpose, I haven't
seen you claim what you want this for, so I assumed general use.

There is nothing illogical about performance problems.  A
cacheless system may _work_ and it might be simple, but
it is also _useless_ for a a lot of common situations
where cached fs'es works fine.


> > The main reason I can imagine for letting two machines write to
> > the *same* disk is performance.  Going cacheless won't give you
> 
> Then imagine some more. I'm not responsible for your imagination ...

You tell.  You keep asking why your idea won't work and I
give you "performance problems" _even_ if you sort out the
correctness issues with no other cost than the lack of cache.

Please tell what you think it can be used for.  I do not say
it is useless for everything, although it certainly is useless
for the purposes I can come up with.  The only uses *I* find
for a shared writeable (but uncachable) disk is so special that 
I wouldn't bother putting a fs like ext2 on it.  Sharing a
raw block device is doable today if you let the programs
using it keep track of data themselves instead of using
a fs.  This isn't what you want though.  It could be interesting
to know what you want, considering what your solution looks like.

Helge Hafting
