Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285749AbRLHBvV>; Fri, 7 Dec 2001 20:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbRLHBvA>; Fri, 7 Dec 2001 20:51:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:11170 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285745AbRLHBun>;
	Fri, 7 Dec 2001 20:50:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Dec 2001 01:50:17 GMT
Message-Id: <UTC200112080150.BAA195557.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: Linux/Pro  -- clusters
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alan Cox <alan@lxorguk.ukuu.org.uk>

    > > For those of us who want to run a standards based operating system can
    > > you do the 32bit dev_t.
    > 
    > You asked for an _internal_ data structure. dev_t is the external
    > representation, and has _nothing_ to do with any drivers at all.

    The internal representation is kdev_t, which wants to turn into a pointer
    from what Aeb has been saying for a long time.

Yes and no. If I am not mistaken there are three details:

(i) Linus prefers to separate block and character devices.
I agree that that makes the code a bit cleaner, but dislike
the code duplication: the interface to user space, the allocation,
deallocation, registering is completely identical for the two.
But apparently Linus does not mind a little bloat if that avoids
an ugly cast in two or three places.

(ii) So, we split kdev_t into kbdev_t and kcdev_t.
Al (and/or Linus) baptizes the struct that a kbdev_t is pointing at
"struct block_device". I usually had a two-layer version, with
device_struct and driver_struct, while struct genhd disappeared.
Don't know whether Al has similar ideas.
The current struct block_device is an ordered pair (dev_t, ops *)
and does not seem to give easy access to the partitions, so maybe Al
still has to reshuffle things a bit, or add a pointer to a struct genhd.
We'll see.

(iii) The past months Al has been nibbling away a little at the road
that makes kdev_t (or kbdev_t or so) a pointer to a device_struct.
Instead it looks like he wants to construct a parallel and equivalent
road starting from the already present basis for a struct block_device.

So, yes, internally we'll have a pointer. No, it doesnt look like
the name of the pointer will be kdev_t.

No doubt Linus or Al or somebody will correct me if the above is all wrong.


    A 32bit "dev_t" is needed so that we can label over 65536 file systems
    to things like ls, regardless of how
    "/dev/sdfoo" is mapped onto a driver

    I'm sure that dev_t (the cookie we feed to user space) going to 32bits is
    going to break something and I'd rather it broke early

Yes, that is an entirely independent matter.
User space uses a 64bit cookie today, and the kernel throws away
three quarters of that. Very little breaks if the kernel throws away less.

[As you know I like a large dev_t, and Linus hated it before he understood
the use of a large dev_t. (For example, he worried that an "ls" would take
many centuries.) Don't know about current opinions. Such a lot of nice
applications: use any device description you like, take a cryptographic
hash and have a device number. Or, generate a new anonymous device by
incrementing a counter. Or, support full NFS.
It would really be a pity to go only to 32 bits. Indeed, 32 bits is
large but not large enough to be collision-free for random assignments,
so one would need a registry of numbers. With a much larger device
number the registry is superfluous.]

Andries
