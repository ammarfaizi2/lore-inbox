Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTGBWMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTGBWMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:12:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43970 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264948AbTGBWMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:12:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 3 Jul 2003 00:27:01 +0200 (MEST)
Message-Id: <UTC200307022227.h62MR1h07192.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com
Subject: Re: [PATCH] cryptoloop
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[on large dev_t]:

> I was wondering what had happened here with this.
> What is left to do to finish full support?

It is not quite clear what "full support" means.
(And not clear what "left" means. Roughly speaking I did
everything, but today part of that would have to be redone.)


Suppose that one regards stat/mknod as communication
userspace <-> filesystem.
Then one wants stat() to be able to return 64-bit dev_t,
and mknod() to be able to bring 64 bits to the filesystem.

Several filesystems have room for only 16 or 32 bits, while some
have room for 128 bits. So details will be filesystem-dependent.

I seem to recall that among the submitted patches was one
that added ext2 support for 64-bit dev_t.
For some other filesystems things were settled. E.g. for NFS.
And there was mknod64.


That is one part. But there is more than stat/mknod.
Every system call and ioctl that uses a dev_t parameter or
a dev_t field in some parameter struct must be looked at.
Do we want to deprecate the thing that has not been used
the past nine years? Or do we need a foo64 version?
Maybe I have patches for all cases.
Don't recall whether I finished the audit. Anyhow,
I would have to do it again - last time was several months ago,
new calls may have been added since.


That is the interface with user space.
Strange enough people are not satisfied with nice large numbers
in special device nodes on the filesystem. They would like to
see something meaningful happen when they open() such a node.

This means that the kernel must be able to find a device driver
or so given a large number. That can be done using a hash table
lookup. But what one really wants is that a device driver can
register an interval of device numbers. Then hash lookup does
not work so well, and one needs a tree lookup. Maybe Al did this
wrong at first in the block device code. I have not checked whether
that has improved recently, but I saw that he did work on the
character device part. Must read that in case this series of
patches is restarted.


So, coming back to your question: what is needed?
Maybe I already had all needed fragments, and earlier my
uncertainty was mostly about the possible existence of
some obscure ioctl on some obscure architecture (not m68, Geert)
that I might have overlooked.

I think the -mm kernels have had (still have?) most of these
large dev_t patches, and basically these did not cause problems.

So what is needed today is looking at the present kernel.
Redoing the syscall and ioctl audit.
Getting the patches into the tree.
Getting glibc to update <sys/sysmacros.h> and stat/mknod/ustat.


And all of this is only the use of the numbers.
Good support for large numbers of disks is something entirely
different. I recall that there were scaling problems, e.g.
with sysfs.

Andries
