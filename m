Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSKQWoV>; Sun, 17 Nov 2002 17:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSKQWoV>; Sun, 17 Nov 2002 17:44:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23801 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267007AbSKQWoS>;
	Sun, 17 Nov 2002 17:44:18 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 17 Nov 2002 23:51:09 +0100 (MET)
Message-Id: <UTC200211172251.gAHMp9Q22607.aeb@smtp.cwi.nl>
To: marcelo-leal@procergs.rs.gov.br
Subject: Re: hexa minor number...
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Marcelo Leal <marcelo-leal@procergs.rs.gov.br>

    I have one linux file server, that serves filesystems to
    some machines (FreeBSD, Solaris, windows and etc...).
    My problem is the /dev filesystem. The freebsd wants to
    create a /dev/da0s1e device with a hexa minor number (0x00020014),
    and the linux machine write decimal (20).
    Did you know how i fix this?

[Maybe your /dev/da0s1e was really da2s1e?]

    My opinion is that linux truncate the numbers to "255" (8bits).
    My linux filesystem is xfs. So, the filesystem supports....
    If i could to write 13192 (decimal), i guess that it will work too.
    But the linux do not do it.

Yes, that is an old problem. It requires a kernel patch.
Linux dev_t is split into 8+8 bits for major+minor.
FreeBSD uses 8+24.
Solaris uses 14+18.

There are plans to change Linux dev_t into 12+20, but things
will still fail (since FreeBSD has more minor bits and Solaris
has more major bits).

For some purposes it sometimes helps to mount /dev using NFS v2.

[NFS v3 transmits 2 32-bit integers with the mknod command.
NFS v2 used create instead of mknod, and stuffs major,minor
in the size field. For communication between FreeBSD and Solaris
that happens to work, since the 32-bit number is transferred as
a cookie.]

[stat and mknod form a channel between the user application
and the bits in the filesystem; unfortunately, under Linux
this channel truncates the values passed along; however, a
rather small patch makes Linux behave and leave a dev_t in peace;
if this is important for you I can dig up this old patch again,
or recreate it; even though the patch is small, some hassle is
involved - on the one hand, with a 32-bit dev_t you still have
problems with FreeBSD and Solaris (but using NFS v2 might help),
on the other hand, with a 64-bit dev_t you can handle all filesystems,
but if I recall correctly that required a new system call, and
recompilation of glibc]


Andries


Let me cc linux-kernel and Linus.
There is a feature freeze in 2.5. Probably that means that
this truncation of major and minor numbers will not be removed,
but it would still be interesting to hear what people say today.

