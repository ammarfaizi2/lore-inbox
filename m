Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbRIFTKf>; Thu, 6 Sep 2001 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272509AbRIFTKZ>; Thu, 6 Sep 2001 15:10:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41670 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272508AbRIFTKS>;
	Thu, 6 Sep 2001 15:10:18 -0400
Date: Thu, 6 Sep 2001 15:10:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Giacomo Catenazzi <cate@dplanet.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
In-Reply-To: <3B97744E.7020007@dplanet.ch>
Message-ID: <Pine.GSO.4.21.0109061454480.7097-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Sep 2001, Giacomo Catenazzi wrote:

> Hello.
> 
> Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without the 
> "devfs=nomount" I
> have two oops + /usr, /home /boot not mounted (all (also /): ext2).

	Don't use devfs. One of the known bugs - devfs passes a string to
vfs_follow_link() and doesn't care to preserve it until vfs_follow_link()
is done.

E.g. rmmod during the symlink traversal will end up with

vfs_follow_link(nd, s)
[working]
[blocked on IO/allocation/whatever]
rmmod
...
kfree(s)
...
[the first process wakes up and oopses on attempt to dereference s]

	There are other scenarios that end up freeing a string passed to
vfs_follow_link() (or, for that matter, being busily copied to userland by
readlink(2)).  Basically, if devfs decides that symlink is gone - pray.
If it's being accessed right now you are going to end up with oops.

	No idea why you've started triggering it only now - not enough
details to say.

	And yes, Richard had been informed about that months ago. Sigh...

