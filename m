Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130803AbRAVIva>; Mon, 22 Jan 2001 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131180AbRAVIvU>; Mon, 22 Jan 2001 03:51:20 -0500
Received: from quechua.inka.de ([212.227.14.2]:23889 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130803AbRAVIvF>;
	Mon, 22 Jan 2001 03:51:05 -0500
Date: Mon, 22 Jan 2001 09:32:34 +0100
From: Bernd Eckenfels <lists@lina.inka.de>
To: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: the remount problem [2.4.0] kind of solved [patch]
Message-ID: <20010122093234.A9194@lina.inka.de>
In-Reply-To: <20010121130745.A1383@lina.inka.de> <87snmcl31k.fsf@mose.informatik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87snmcl31k.fsf@mose.informatik.uni-tuebingen.de>; from goswin.brederlow@student.uni-tuebingen.de on Mon, Jan 22, 2001 at 03:43:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

for Short: I had a mail exchange with Vic Abell, the lsof Author, and in the
next Version of lsof the open shared libs will be detected. So my Kernel
Patch is no longer needed:

# ~root/rw
# rm /usr/lib/jabber/jsm/libjsm.so
# ~root/ro
mount: /usr busy
# lsof_4.55A.linux/lsof -a +L1 /usr
COMMAND  PID   USER  FD   TYPE DEVICE SIZE NLINK   NODE NAME
jabberd 9657 daemon mem    DEL    8,5          0 145429 /usr/lib/jabber/jsm/jsm.so
jabberd 9658 daemon mem    DEL    8,5          0 145429 /usr/lib/jabber/jsm/jsm.so
#

Still we need to address the problem of upgraded libs (at least in a Great
Distribution like Debian is :)

> Why in hell are library open for write? But it doesn't seem to be only
> libraries:

They are not open for write. They are open for mmaped read. The Problem with
this is, that as long as the files are open, the filesystem cannot remove
them from disk. This means, that as long as you have files open, even for
read, which are deleted, a remount ro will fail.

The new lsof will find those mmaped files, so you can simply restart the
associated binary.

> At boottime the filesystems are readonly, so any deamon that gets
> startet can only have read and exec permissions on files. Deleting a
> library and replacing it with a new one can't change that.

Deleteing a lib which is open (which will happen if u upgrade a lib*.deb)
will leave a open-but-delted file on the system, which in turn will disable
you to remount the file system read only. In my case i switch from read-only
/usr to read-write user, use apt-get -ufm upgrade and then want to switch
back to read-only /usr. But exactly the later is not possible. It is also
wasting shared memory since freshly started programs will use the new lib,
the old ones will use the old, unlinked libs.

> I think the problem comes from daemons that actually get restarted,
> maybe before the library is updated (so they will load the old/deleted
> one).

Yes, all daemons will get started with the old libs, since a upgrade always
happens after system start :) But not only daemons. Think of Shells, getty,
login, ...

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
