Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266651AbRGTGvf>; Fri, 20 Jul 2001 02:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbRGTGvY>; Fri, 20 Jul 2001 02:51:24 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:30340 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266651AbRGTGvO>; Fri, 20 Jul 2001 02:51:14 -0400
Message-ID: <3B57D541.10312D18@uow.edu.au>
Date: Fri, 20 Jul 2001 16:52:49 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Niels Kristian Bech Jensen <nkbj@image.dk>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Oops in 2.4.7-pre9.
In-Reply-To: <Pine.LNX.4.33.0107200815230.858-100000@hafnium.nkbj.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Niels Kristian Bech Jensen wrote:
> 
> I get this oops while booting 2.4.7-pre9:

Kernel is trying to read /proc/pid entries for a kernel thread
which has called daemonize().  It has a null task_struct.mm.

I tested various other possible problems, such as making
/sbin/hotplug an elf executable and it looks OK, apart from
the /proc problem.

--- linux-2.4.7-pre9/fs/proc/base.c	Fri Jul 20 15:39:12 2001
+++ linux-akpm/fs/proc/base.c	Fri Jul 20 16:43:02 2001
@@ -670,7 +670,7 @@ static struct inode *proc_pid_make_inode
 	inode->u.proc_i.task = task;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_PID_INO || task->mm->dumpable) {
+	if (ino == PROC_PID_INO || (task->mm && task->mm->dumpable)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
