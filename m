Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319102AbSIDIh1>; Wed, 4 Sep 2002 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319103AbSIDIh0>; Wed, 4 Sep 2002 04:37:26 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:23569 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319102AbSIDIhY>;
	Wed, 4 Sep 2002 04:37:24 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209040841.g848fsT26299@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <3D75B344.66D4166@aitel.hist.no> from Helge Hafting at "Sep 4, 2002
 09:16:20 am"
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 4 Sep 2002 10:41:54 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Helge Hafting wrote:"
> > The "big view" calculations indicate that we must have distributed
> > shared writable data.
> > 
> Increasing demands for performance may indeed force a need
> for shared writeable data someday.  Several solutions for that is
> being developed.
> Your idea about re-reading stuff over and over isn't going to help 

I really don't see why you people don't get it. Rereading is a RARE
operation. Normally we write once and read once. That's all. Once
the data's in memory we use it.

And if we ever have to reread something, it will very very rarely be
metadata.

> because that sort of thing consumes much more bandwith. Caches help
> because they _avoid_ data transfers.  So shared writeable data

Tough. Data transfers are inevitable in this scenario. There's no
sense in trying to avoid them. Data comes in at A and goes out at B.
Ergo it's transfered.

> > So, start thinking about general mechanisms to do distributed storage.
> > Not particular FS solutions.
> Distributed systems will need somewhat different solutions, because
> they are fundamentally different.  Existing fs'es like ext2 is built
> around a single-node assumption.  I claim that making a new fs from

I am still getting afeel for the problem. Only avoiding directory
caching (and inode caching) has worried me. I looked at the name
lookup routines on the train and I don't see we onne can't force a
reread from root every time, or a reread every time there is a
"changed" bit set in the sb.

> scratch for the distributed case is easier than tweaking ext2

No tweak. But I'm looking.

> The case of distributed storage is similiar, it is fundamentally
> different from the one-node case just as random-access media

I agree. But the case of one FS accessed from different nodes is not
fundamentally different from the situation we have now. It requires
locking. It also requires either explicit sharing of cached
information, or no caching (which is the same thing :-). I merely
opine that the latter is easier to try first and may not be so bad.

> If you merely proposed making the VFS and existing fs'es
> cache-coherent,then I'd agree it might work well, but

I'm proposing making no caching _possible_. Not mandatory, but
_possible_. If you like, you can see it as a trivial case of cache
sharing.

> by throwing away caching _will_ be too slow, it certainly

Why? The only thing I've seen mentioned that might slow things down
is that at every open we have to trace the full path anew. So what?
OK, so there's also objections about what happens if one kernel frees
the data and anotehr adds to it. I'm thinking about what that implies.

> There will probably be different needs for which people
> will build different distributed fs'es.  So a 
> "VDFS" makes sense for those fs'es, putting the common stuff
> in one place.  But I am sure the VDFS will contain cache
> coherency calls for dropping pages from cache when 
> necessary, instead of dropping the cache unconditionally
> in every case.

That's possible, but right now I don't know any way of saying to the
kernel "I just stepped all over X on disk, please invalidate anything
you have cached that points to X". I'd like it very much in the
buffering layer too (i.e. vMs).

Peter
