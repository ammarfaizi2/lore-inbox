Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319145AbSIDLfM>; Wed, 4 Sep 2002 07:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319144AbSIDLfL>; Wed, 4 Sep 2002 07:35:11 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:62729 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319145AbSIDLfJ>;
	Wed, 4 Sep 2002 07:35:09 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209041139.g84Bdb314111@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.SOL.3.96.1020904114744.27919B-100000@libra.cus.cam.ac.uk>
 from Anton Altaparmakov at "Sep 4, 2002 12:05:04 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Wed, 4 Sep 2002 13:39:37 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Anton Altaparmakov wrote:"
> On Wed, 4 Sep 2002, Peter T. Breuer wrote:
> > I suggest that changing FS structure is an operation that is so
> > relatively rare  in the projected environment (in which gigabytes of
> > /data/ are streaming through every second) that you can make them as
> > expensive as you like and nobody will notice. Your frothing at the
> > mouth about it isn't going to change that. Moreover, _opening_
> > a file is a rare operation too, relative to all that data thruput.
> 
> Sorry but this really shows you lack of understanding for how a file
> system works. Every time you write a single byte(!!!) to a file, this
> involves modifying fs structures. Even if you do writes in 1MiB chunks,

OK .. in what way? 

> what happens is that all the writes are broken down into buffer head sized
> portions for the purposes of mapping them to disk (this is optimized by

Well, they'll be broken down, yes, quite probably.

> the get_blocks interface but still it means that every time get_blocks is

You mean that the buffer cache is looked up? But we know that we have
disabled caching on this device ... well, carry on anyway (it does
no harm to write to an already dirty buffer).

> involved you have to do a full lookup of the logical block and map it to
> an on disk block). For reading while you are not modifying fs structures
> you still need to read and parse them for each get_blocks call.

I'm not following you. It seems to me that you are discussing the
process of getting a buffer to write to prior to letting it age and
float down to the device driver via the block layers. But we have
disabled caching so we know that get_blocks will deliver a new
temporary buffer or block or something or at any rate do what it
should do ... anyway, I mumble.... what you are saying is that you
think we look up a logical block number and get a physical block
number and possibly a buffer associated with it. Well, maybe. So?

> This in turn means that each call to get_blocks within the direct_IO code
> paths will result in a full block lookup in the filesystem driver.

Uh, I'm not sure I understand any of this. You are saying something
about logical/physical that I don't follow or don't know. In
direct IO, one of the things that I believe happens is that writes are
serialized, in order to maintain semantics when we go RWRW (we don't
want it to work like WRWR or other), so that overlaps cannot happen. 
We should never be in the situation of having a dirty (or
cached) buffer that we rewrite before it goes to disk (again).

Is that relevant?

> I explained in a previous post how incredibly expensive that is.

Well, I simply don't follow you here. Can you unmuddle my understanding
of what you are saying about logical/physical?


> So even though you are streaming GiB of /data/ you will end up streaming
> TiB of /metadata/ for each GiB of /data/. Is that so difficult to
> understand?

Yep. Can you be concrete about this metadata? I'lll see if I can work
it out .. what I think you must be saying is that when we write to
a file, we write to a process address space, and that has to be
translated into a physical block number on disk. Well, but I imagine
that the translation was settled at the point that the inode was first
obtained, and now that we have the inode, data that goes to it gets
a physical address from the data in the inode. We can even be using an
inode that is unconnected to the FS, and we will still be writing away
to disk, and nobody else will be using that space, because the space
is marked as occupied in the bit map.

I see no continuous lookup of metadata.

> Unless you allow the FS to cache the /metadata/ you have already lost all

What metadata? I only see the inode, and that's not cached in any
meaningful sense (i.e. not available to other things) to but simply
"held" in kmem storage and pointed to.

> your performance and you will never be able to stream at the speads you
> require.

Can you be even MORE specific about what this metadata is? Maybe I'll
get it if you are very very specific.

> So far you are completely ignoring my comments. Is that because you see
> they are true and cannot come up with a counter argument?

No, I know of no comments that i have deliberately ignored. Bear in
mind that I have a plane to catch at 5.30 and an article to finish
before then :-).

> > situation. Nobody could care less how long it takes to open a file
> > or do a mkdir, and even if they did care it would take exactly as long
> > as it does on my 486 right now, which doesn't scare the pants off me.
> 
> We do care about such things a lot! What you are saying is true in you
> extremely specialised scientific application. In normal usage patterns

Well, there are a lot of such scientific applications, and they are
taking up a good slice of the computing budgets, and a huge number of
machines ... so I don't think you can ignore them in a meaningful way
:-).

> file creation, etc, are crucially important to be fast. For example file
> servers, email servers, etc create/delete huge amounts of files per
> second. 

Yep.


> > What we/I want is a simple way to put whatever FS we want on a shared
> > remote resource. It doesn't matter if you think it's going to be slow
> > in some aspects, it'll be fast enough, because those aspects merely
> > have to be correct, not fast.
> 
> Well normal users care about fast, sorry. Nobody will agree to making the

Normal users should see no difference, because they won't turn  on
O_DIRDIRECT, or whatever, and it should make no difference to them
that the dir cache /can/ be turned off. That should be a goal, anyway.
Can it be done? I think so, at least if it's restricted to directory
lookup in the first instance, but I would like your very concrete
example of what cached metadata is changed when I do a data write.

> generic kernel cater for your specialised application which will be used
> on a few systems on the planet when you would penalize 99.99999% of Linux
> users with your solution.

Where is the penalty?

> The only viable solution which can enter the generic kernel is to
> implement what you suggest at the FS level, not the VFS/block layer
> levels.

Why? Having VFS ops available does not mean you are obliged to use
them! And useing them means swapping them in via a pointer indirection,
not testing a flag always.

> Of course if you intend to maintain your solution outside the kernel as a
> patch of some description until the end of time then that's fine. It is
> irrelevant what solution you choose and noone will complain as you are not
> trying to force it onto anyone else.

I think you are imagining implementation that are simply not the way
I imagine them. Can you be specific about the exact metadata that is
changed when a data write is done? That will help me decide.

Thanks!

Peter
