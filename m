Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319108AbSIDJL2>; Wed, 4 Sep 2002 05:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSIDJL2>; Wed, 4 Sep 2002 05:11:28 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:17158 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319108AbSIDJL1>;
	Wed, 4 Sep 2002 05:11:27 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209040915.g849Ftf29959@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <3D75ACFA.480860BB@aitel.hist.no> from Helge Hafting at "Sep 4,
 2002 08:49:30 am"
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 4 Sep 2002 11:15:55 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Helge Hafting wrote:"
> No problem if all you do is use file data.  A serious problem if
> the stuff you read is used to make a decision about where
> to write something else on that shared disk.  For example:
> The fs need to extend a file.  It reads the free block bitmap,
> and finds a free block.  Then it overwrites that free block,
> and also write back a changed block bitmap.  Unfortunately

That's the exact problem that's already been mentioned twice,
and I'm confident of that one being solved. Lock the whole
FS if necessary, but read the bitmap and lock the bitmap on disk
until the extension is finished and the bitmap is written back.
It has been suggested that the VFS support a "reserve/release blocks"
operation. It would simply mark the ondisk bitmap bits as used
and add them to our available list. Then every file extension
or creation would need to be preceded by a reserve command,
or fail, according to policy.

> some other machine just did the same thing and you
> know have a crosslinked and corrupt file.

There is no problem locking and serializing groups of
read/write accesses.  Please stop harping on about THAT at
least :-). What is a problem is marking the groups of accesses.

> There are several similiar scenarios. You can't really talk
> about "not caching".  Once you read something into
> memory it is "cached" in memory, even if you only use it once
> and then re-read it whenever you need it later.

That's fine. And I don't see what needs to be reread. You had this
problem once with smp, and you beat it with locks.

> > A generic mechanism is not a "no cache fs". It's a generic mechanism.
> > 
> > > Nobody will have time to wait for this, and this alone makes your
> > 
> > Try arguing logically. I really don't like it when people invent their
> > own straw men and then procede to  reason as though it were *mine*.
> > 
> Maybe I wasn't clear.  What I say is that a fs that don't cache
> anything in order to avoid cache coherency problems will be
> too slow for generic use.  (Such as two desktop computers

Quite possibly, but not too slow for reading data in and writing data
out, at gigabyte/s rates overall, which is what the intention is.
That's not general use. And even if it were general use, it would still
be pretty acceptable _in general_.

> > Then imagine some more. I'm not responsible for your imagination ...
> 
> You tell.  You keep asking why your idea won't work and I
> give you "performance problems" _even_ if you sort out the
> correctness issues with no other cost than the lack of cache.

The correctness issues are the only important ones, once we have
correct and fast shared read and write to (existing) files.

> it is useless for everything, although it certainly is useless
> for the purposes I can come up with.  The only uses *I* find
> for a shared writeable (but uncachable) disk is so special that 
> I wouldn't bother putting a fs like ext2 on it.  Sharing a
> raw block device is doable today if you let the programs

It's far too inconvenient to be totally without a FS. What we
want is a normal FS, but slower at some things, and faster at others,
but correct and shared. It's an approach. The caclulations show
clearly that r/w  (once!) to existing files are the only performance
issues. The rest is decor. But decor that is very nice to have around.

Peter
