Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbRAVCnu>; Sun, 21 Jan 2001 21:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130916AbRAVCnk>; Sun, 21 Jan 2001 21:43:40 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:59146 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130797AbRAVCne>; Sun, 21 Jan 2001 21:43:34 -0500
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org,
        Werner.Almesberger@epfl.ch
Subject: Re: the remount problem [2.4.0] kind of solved [patch]
In-Reply-To: <20010121130745.A1383@lina.inka.de>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 22 Jan 2001 03:43:35 +0100
In-Reply-To: Bernd Eckenfels's message of "Sun, 21 Jan 2001 13:07:45 +0100"
Message-ID: <87snmcl31k.fsf@mose.informatik.uni-tuebingen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bernd Eckenfels <ecki@lina.inka.de> writes:

     > Hello, the following patch against 2.4.0 will allow the kernel
     > to write a message to the kernel log in case files are open for
     > write or delete on a partition which should be remounted.

     > I run my System with Read-Only /usr File System and this works
     > fairly well.  I have a script to remount the different
     > Filesystems if I want to upgrade them (using the cool apt-get
     > from Debian).

     > Sometimes after upgrades I noticed, that I am unable to remount
     > the /usr File system read only. Since I was unable to detect
     > the Reason for it (no file according to lsof or fuser was open
     > for writing) i decided to patch the kernel to debug the
     > problem.

     > The Solution: some files are deleted but open. Most of the time
     > this is due to an upgrade of a shared lib without restarting
     > the related daemon. I am not sure why I dont see the open but
     > deleted files in lsof (according to its man page "lsof -aL1
     > /usr" should work, but anyway. Here is my patch, in case you
     > experience the same problems. Not sure if it is ok to include
     > it that way into mainstream kernel since it might produce quite
     > a few lines of logs and i am not sure if prinkt is save inside
     > the file list lock anyway.

Make it optional. Add an entry in proc that turns the feature on and
of and an config option disabling the code alltogether. Then send the
patch in and see what they say.

     > So my question: which user mode program can be used to detect
     > those "open but deleted" mmaped files?

     > With my patch i get the inode an can grep in maps...

     > calista:/usr/src/linux# grep 145429 /proc/*/maps
     > /proc/354/maps:40156000-4016d000 r-xp 00000000 08:05 145429
     > /usr/lib/jabber/jsm/jsm.so (deleted)
     > /proc/354/maps:4016d000-4016e000 rw-p 00016000 08:05 145429
     > /usr/lib/jabber/jsm/jsm.so (deleted)
     > /proc/366/maps:40156000-4016d000 r-xp 00000000 08:05 145429
     > /usr/lib/jabber/jsm/jsm.so (deleted)
     > /proc/366/maps:4016d000-4016e000 rw-p 00016000 08:05 145429
     > /usr/lib/jabber/jsm/jsm.so (deleted)

Why in hell are library open for write? But it doesn't seem to be only
libraries:

% cat /proc/self/maps          
08048000-0804b000 r-xp 00000000 03:01 22109      /bin/cat
0804b000-0804c000 rw-p 00002000 03:01 22109      /bin/cat
40000000-40016000 r-xp 00000000 03:01 18160      /lib/ld-2.2.1.so
40016000-40017000 rw-p 00015000 03:01 18160      /lib/ld-2.2.1.so
40017000-40018000 rw-p 00000000 00:00 0
4001f000-40120000 r-xp 00000000 03:01 18171      /lib/libc-2.2.1.so
40120000-40127000 rw-p 00100000 03:01 18171      /lib/libc-2.2.1.so
40127000-4012b000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0

     > Perhaps it is enough to run "grep '(deleted)' /proc/*/maps" in
     > cron.daily?

     > Well, for Debian, it would be nice if we can make sure that on
     > shared lib upgrade at least a list of programs which needs to
     > be restarted is mailed to root. We do restartes on libc
     > upgrade, but I guess it is not possible to restart for other
     > shared libs (automatically).

At boottime the filesystems are readonly, so any deamon that gets
startet can only have read and exec permissions on files. Deleting a
library and replacing it with a new one can't change that.

I think the problem comes from daemons that actually get restarted,
maybe before the library is updated (so they will load the old/deleted
one).

MfG
        Goswin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
