Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266090AbRF1S3z>; Thu, 28 Jun 2001 14:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266089AbRF1S3p>; Thu, 28 Jun 2001 14:29:45 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:23313 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S266086AbRF1S3b>;
	Thu, 28 Jun 2001 14:29:31 -0400
Date: Thu, 28 Jun 2001 20:32:27 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
cc: Gerhard Wichert <Gerhard.Wichert@fujitsu-siemens.com>
Subject: [PATCH] Bug in 2.4.5 in proc_pid_make_inode ()
Message-ID: <Pine.LNX.4.30.0106281619150.17260-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have recently experienced a number of kernel OOPSes
in "top" under heavy load. Kernel is 2.4.5 (IA64, but
this has nothing to do the IA64 patch).

The OOPS happens in the call tree

open () system call
[...]
real_lookup ()
proc_base_lookup ()
proc_pid_make_inode ()
iput ()
proc_delete_inode () -> OOPS in __MOD_DEC_USE_COUNT

proc_pid_make_inode () calls iput () if it finds a task PID of 0
(jump to label out_unlock). If (PID == 0), the statement

	inode->i_ino = fake_ino(task->pid, ino);

sets    inode->i_ino = ((0 << 16) | ino) = ino.

Thus if (ino < (1 << 16)), the test

	if (PROC_INODE_PROPER(inode))

in proc_delete_inode () will fail, and proc_delete_inode will
erroneously assume this is a non-PID inode and
look for a proc_dir_entry struct which is of course bogus
(the OOPS happens when it tries to decrement the module use counter).

Therefore I propose the following patch:

--- 2.4.5mw/fs/proc/base.c.org	Wed Jun 27 12:36:18 2001
+++ 2.4.5mw/fs/proc/base.c	Thu Jun 28 20:52:22 2001
@@ -672,6 +672,8 @@
 	return inode;

 out_unlock:
+	/* Make sure proc_delete_inode does the right thing */
+	inode->i_ino |= (1 << 16);
 	iput(inode);
 	return NULL;
 }

This will tell proc_delete_inode that this is a PID entry.

PS:
I have seen 2.4.6-pre6 contains changes to this subroutine as well,
but they seem to be attacking a different problem.
Having analyzed the stack trace and the kernel code with objdump,
I am pretty certain that the changes in 2.4.6-pre6 do not fix my problem
(if they did, I would see a crash in proc_pid_delete_inode rather
than in proc_delete_inode).

The two patches are not in conflict.

Regards,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113




