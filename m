Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTBBP3O>; Sun, 2 Feb 2003 10:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTBBP3O>; Sun, 2 Feb 2003 10:29:14 -0500
Received: from hera.cwi.nl ([192.16.191.8]:13516 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265373AbTBBP3N>;
	Sun, 2 Feb 2003 10:29:13 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Feb 2003 16:38:08 +0100 (MET)
Message-Id: <UTC200302021538.h12Fc8708721.aeb@smtp.cwi.nl>
To: viro@math.psu.edu
Subject: dev_t stuff
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Hope you are well. Haven't seen you for two months now.

People ask for 32-bit dev_t, and that causes minor changes
several places. One of these places is genhd.c.

The struct blk_probe *probes[MAX_BLKDEV]; must get size
MAX_PROBES, for some random value of MAX_PROBES, say 256
(or PROBES_HASH_SIZE or so to make clear that this is
essentially a hash), and dev_to_index() must return
for example MAJOR(dev)%MAX_PROBES.

Then there was a bug in blk_unregister_region where
the || should have been &&.

That settles this file minimally.

However, my own changes are much larger, that is why I write;
it is bad when two people undo work of each other, and I am
tempted to undo some small part of your work.

Motivation:
User space has dev_t, and MAJOR(), MINOR(), MKDEV() that operate on it.
The kernel has kdev_t, and kmajor(), kminor(), mk_kdev() that operate on it.

For backwards compatibility we must not change the structure
of already existing dev_t. Thus, for a 16-bit dev_t the
major/minor division has to be 8+8. For a larger dev_t it can
be whatever we want, like 16+16 or 12+20 or 32+32.
In all cases MKDEV is a slightly complicated operation, say

#define MKDEV(ma,mi)   ((dev_t)(((((ma) & ~0xff) == 0) && (((mi) & ~0xff) == 0)) ? (((ma) << 8) | (mi)) : (((ma) << DEV_MINOR_BITS) | (mi))))

and similarly MAJOR, MINOR have to distinguish cases.
Thus, the kernel becomes smaller and faster if we use
kdev_t, kmajor, kminor, mk_kdev - the kernel-internal
representation, which is just

#define __mkdev(major, minor)  (((major) << KDEV_MINOR_BITS) + (minor))

In other words, I am tempted to change some of the places where
you turned kdev_t into dev_t back to kdev_t.
Comments?

Andries


Consider blk_[un]register_region. All of its callers have MKDEV()
as first parameter.
Consider the interval setup in blk_probe. Do you want the intervals
to be in dev_t space or in kdev_t space? I would prefer the latter.
