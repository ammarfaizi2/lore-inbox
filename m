Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbQKER10>; Sun, 5 Nov 2000 12:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKER1G>; Sun, 5 Nov 2000 12:27:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1517 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129475AbQKER06>;
	Sun, 5 Nov 2000 12:26:58 -0500
Date: Sun, 5 Nov 2000 12:26:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Zarzycki <dave@thor.sbay.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: taskfs and kernfs
In-Reply-To: <Pine.LNX.4.21.0011050108020.3045-100000@vaio.thor.sbay.org>
Message-ID: <Pine.GSO.4.21.0011051213570.25503-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2000, Dave Zarzycki wrote:

> I got bored this evening and decided to learn more about the Linux kernel
> by splitting out procfs into two separate file systems:
> 
> taskfs which contains /proc/self and /proc/[1-9]*
> kernfs which contains everything else that procfs provides.
> 
> You can get the quick hack from here (this patch is against 2.4.0-test10):
> 
> http://thor.sbay.org/~dave/taskfs_and_kernfs.diff.gz
> 
> I've tested the two file systems on the user-mode-linux kernel. :-)
> They both seem to work as expected, even when /proc is mounted.
> 
> Alexander Viro, is this kernfs at all useful as a starting point for your
> kernfs goals?

Not really. Sure, splitting procfs-proper (per-process stuff) is a nice
thing, but it's hardly a real problem. All preliminary work for that
had been done about a year ago - base.c and array.c vs. everything else.

The reason why this splitup didn't happen yet is the lack of union-mount.
IOW, we can split them, but we will not be able to preserve the namespace.
Union-mount is a 2.5 stuff - involves credentials cache and change of
->readdir() prototype, so freeze is not a time for that.

However, kernfs is _not_ procfs \setminus procfs-proper. It's our current
/proc/sys. And here we have an interesting set of problems due to the way
it is populated and accessed. We have sysctl(2) to deal with, we have
static initializers for sysctl tables and we have rather odd combination of
three tree-like structures: dcache tree, proc_dir_entry tree and list
of trees consisting of ctl_table. That's where the problems are. And yes, once
kernfs is split off the rest of procfs \setminus procfs-proper will become
much simpler. Sigh..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
