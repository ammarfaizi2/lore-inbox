Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283243AbRLIJAe>; Sun, 9 Dec 2001 04:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283233AbRLIJAZ>; Sun, 9 Dec 2001 04:00:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45717 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S283234AbRLIJAM>;
	Sun, 9 Dec 2001 04:00:12 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 9 Dec 2001 08:59:21 GMT
Message-Id: <UTC200112090859.IAA242651.aeb@cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: Linux/Pro  -- clusters
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Viro <viro@math.psu.edu>

    > > I am sure also Al will tell you that there is no problem.

    <raised brows>  What gave you such impression?  IIRC, I've described
    the problems several months ago.  Three words: object freeing policy.

    The fundamental reason why we can't replace kdev_t with pointer and hope
    to survive is that YOU DON'T FREE NUMBERS.  Integer is an integer - it's
    always valid.  We will need to free the structures and _that_ is where the
    problems will start.

Yes, you are quite right, this is a difficulty, more serious
than the bdev/cdev distinction Linus mentions.

But for me the difficulty is far away.

Let me once more sketch the mechanical change.

Part 1: Invent some random structures, to be changed when needed,
that contain all data we want to refer to via our pointer.
Since the procedure was supposed to be mechanical, take
the arrays indexed today by major or major,minor and make
their contents fields in these structs.

Work to do: global search and replace of
	blk_size[MAJOR(dev)][MINOR(dev)]
by
	dev->size
(possibly with a shift: I was going to bytes instead of blocks;
possibly with an inline function
	get_size(dev)
so that changing the setup of these structs later is easier).

Part 2: These structures have to be allocated. Let the allocating
happen in the same place where the arrays like blk_size[][] are
initialized today.

Part 3: These structures have to be found, given a dev_t.
Use a hash table.

Now you see no refcounting, and no freeing.
But my point is that that does not matter.
At least not at first.

I have run for months with systems like this, and typically saw
2000 or so such structures allocated. But they are small structures,
a few dozen bytes, nobody cares - at first.

Result of the mechanical change: a system without arrays,
with large device numbers, so that people can have ten thousand
SCSI disk partitions, should they want to.

In other words, two problems are solved: the arrays are gone,
and the device numbers no longer live in this cramped space.


Yes, now you want, and I want, to go further.
As long as these structs are not located in memory that goes away,
and do not contain pointers that point to stuff that goes away
when a module is unloaded it does not matter much that they are
never freed. But in the long run we of course want to free all
that is allocated. So, later we must audit what happens to them.
I can say more about that, but our difference is that it is your
first worry and my last worry.

(Roughly speaking the situation is still as I ordained six years ago:
things of type kdev_t only live in ROOT_DEV, inode->i_dev, inode->i_rdev,
sb->s_dev, bh->b_dev, req->rq_dev, tty->device.
We change inode->i_rdev back to a dev_t.
One does not want to free the struct upon the last close; soon there
will be an open again. One only wants to free the struct when the module
is unloaded, or perhaps when it is certain that the device will never
be used again, like in my version with 40-bit anonymous device numbers
that are never reused. So, inode, sb, bh, req, tty belonging to a
module that is unloaded must be freed. But we wanted that already,
also without device structs.)

[There is more to say, but I have to go, and maybe you and Linus
can start telling me why this mechanical approach is silly.
Hope to be back twelve hours from now.]

Andries
