Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313489AbSDLKGz>; Fri, 12 Apr 2002 06:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313491AbSDLKGy>; Fri, 12 Apr 2002 06:06:54 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:46293 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S313489AbSDLKGx>;
	Fri, 12 Apr 2002 06:06:53 -0400
Message-Id: <3.0.6.32.20020412121109.0090fd80@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 12 Apr 2002 12:11:09 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: BUG: 2.4.19pre1 & journal_thread & open filehandles
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!

I think I have discovered a bug in the way the kernel journal thread is
created.
I tested with ext3 but believe that every fs using jbd has this bug.

Description:
------------

A kernel journaling thread is created for every journaled filesystem which
gets mounted. The problem is, that the thread gets every open filehandle of
the mount-process added to the thread-filedescriptor-table.

Example:
Process 4 is a kjournald
On the shell (bash) I do a 
   exec 10< /etc/services
to open fd 10, then
   mount -t ext3 /usr
to create a new kjournald with pid (eg) 25.
Now
	ls -la /proc/4/fd 
or
	ls -la /proc/25/fd
BOTH show a link "10 -> /etc/services".

I tried a short program which closes all filehandles and then execs mount,
but as of this test the filehandles get only added, never removed.

I believe this to be a serious bug as it's impossible to umount the
underlying filesystems (devfs and /) as AT LEAST 0,1 & 2 are used with
mount, and using pivot_root to change to a shmfs and then umounting
everything INCLUDING / isn't possible - the kjournald for / has
/dev/console open, and /dev is mounted below / ...


BTW: is the VFS-lock patch already in 2.4.19preX or will it be included in
the near future??

Thanks for reading and giving some replies.


Regards,

Phil



