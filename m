Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262893AbREVXeS>; Tue, 22 May 2001 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262896AbREVXeI>; Tue, 22 May 2001 19:34:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19645 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262893AbREVXeA>;
	Tue, 22 May 2001 19:34:00 -0400
Date: Wed, 23 May 2001 01:33:23 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105222333.BAA77751.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] struct char_device
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From torvalds@transmeta.com Wed May 23 00:39:23 2001

    On Tue, 22 May 2001 Andries.Brouwer@cwi.nl wrote:
    > 
    > The operations are different, but all bdev/cdev code is identical.
    > 
    > So the choice is between two uglies:
    > (i) have some not entirely trivial amount of code twice in the kernel
    > (ii) have a union at the point where the struct operations
    > is assigned.
    > 
    > I preferred the union.

    I would much prefer a union of pointers over a pointer to a union.

    Why? Because if you have a "struct inode", you also have enough
    information to decide _which_ of the two types of pointers you have, so
    you can do the proper dis-ambiguation of the union and properly select
    either 'inode->dev.char' or 'inode->dev.block' depending on other
    information in the inode.

I am not sure whether we agree or differ in opinion. I wouldn't mind

/* pairing for dev_t to bd_op/cd_op */
struct bc_device {
        struct list_head        bd_hash;
        atomic_t                bd_count;
        dev_t                   bd_dev;
        atomic_t                bd_openers;
        union {
		struct block_device_operations_and_data *bd_op;
		struct char_device_operations_and_data *cd_op;
	}
        struct semaphore        bd_sem;
};

typedef struct bc_device *kdev_t;

and in an inode

	kdev_t dev;
	dev_t rdev;

In reality we want the pair (dev_t, pointer to stuff), but then
there is all this administrative nonsense needed to make sure
that nobody uses the pointer after the module has been unloaded
that makes the pointer a bit thicker.

       And we should not depend on the "inode->dev.xxxx" pointer
       being valid all the time, as there is absolutely zero point
       in initializing the pointer every time somebody does a "ls -l /dev".

Yes, that is why I want to go back and have dev_t rdev, not kdev_t.
The lookup is done when the device is opened.

Andries
