Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136461AbREDRkV>; Fri, 4 May 2001 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136462AbREDRkL>; Fri, 4 May 2001 13:40:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41636 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136461AbREDRj5>;
	Fri, 4 May 2001 13:39:57 -0400
Date: Fri, 4 May 2001 13:39:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        volodya@mindspring.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0105041015520.521-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105041330510.19970-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Linus Torvalds wrote:

> Now, if you want to speed up accesses, there are things you can do. You
> can lay out the filesystem in the access order - trace the IO accesses at
> bootup ("which file, which offset, which metadata block?") and lay out the
> blocks of the files in exactly the right order. Then you will get linear
> reads _without_ doing any "dd" at all.
> 
> Now, laying out the filesystem that way is _hard_. No question about it.
> It's kind of equivalent to doing a filesystem "defreagment" operation,
> except you use a different sorting function (instead of sorting blocks
> linearly within each file, you sort according to access order).

Ehh... There _is_ a way to deal with that, but it's deeply Albertesque:
	* add pagecache access for block device
	* put your "real" root on /dev/loop0 (setup from initrd)
	* dd
The last step will populate pagecache for underlying device and later
access to root fs will ultimately hit said pagecache, be it from page
cache of files or buffer cache of /dev/loop0 - loop_make_request() will
take care of that, by copying data from pagecache of /dev/<real_device>.

					Al, feeling sadistic today...

