Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271348AbRIAUm7>; Sat, 1 Sep 2001 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271349AbRIAUmt>; Sat, 1 Sep 2001 16:42:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18339 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271348AbRIAUmg>;
	Sat, 1 Sep 2001 16:42:36 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Sep 2001 20:42:20 GMT
Message-Id: <200109012042.UAA17644@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Sat Sep  1 18:26:53 2001

    On Sat, 1 Sep 2001 Andries.Brouwer@cwi.nl wrote:

    > A kdev_t is a pointer to a struct that has the info now found in
    > the arrays (and major, minor fields, and a name function..).
    > This struct is allocated by the driver.

    Umm... Apply the arguments from the char_device thread - pointers to
    unions are rather bad idea.  IOW, kdev_t must die - kernel always
    knows which kind we are dealing with.

I don't mind.
Nothing really changes if you split it into kbdev_t and kcdev_t.

(Splitting is a lot of work, a large source edit,
but basically straightforward. I did similar things a few times,
splitting MKDEV into MKBDEV and MKCDEV [and MKXDEV].
However, a union is not so bad. It seems a pity to avoid unions
and waste 4 bytes for every inode with separate i_bdev and i_cdev
instead of a single i_bcdev.
Anyway, this has nothing to do with the present discussion.)

...
    > This "a refcount" is the openct field of the device struct,
    > somewhat like the present bd_openers.
    > 
    > The decrements of the refcount are done in kill_super() for s_dev
    > and at the close/umount corresponding to the open/mount that set it for i_bcdev.

    ??? So you decrement twice on umount?

Yes, and increment twice on mount.
That may be easiest since s_dev can also come from get_unnamed_dev().

...
    How do you tell when inode is not opened anymore?
...
    When do you reset it [i_bcdev]?

Now I see what you are asking - at first I thought you wondered
about the bookkeeping for the device struct, and there is no problem there,
but you ask about the bookkeeping for i_bcdev.

Since the refcount is for the device struct, we cannot do anything
until that count hits zero. Then the release method of the device struct
is called (which frees it, or decrements a refcount for the module).
After this i_bcdev cannot be used anymore.
Since we don't know whether this happened already, i_bcdev must be
recomputed on each open or mount.

(One might invent additional data structure to avoid this recomputation,
but data structures take memory and add the complication that they
must be kept consistent and up-to-date. Since mounting, or opening
a block device, are very infrequent operations, it does not matter
that we do a possibly superfluous bdopen().)

Andries
