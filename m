Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTAYEtI>; Fri, 24 Jan 2003 23:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTAYEtH>; Fri, 24 Jan 2003 23:49:07 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:49564 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S266161AbTAYEtH>; Fri, 24 Jan 2003 23:49:07 -0500
Date: Sat, 25 Jan 2003 13:56:11 +0900 (JST)
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: PID of multi-threaded core's file name is wrong in 2.5.59
To: linux-kernel@vger.kernel.org
Message-id: <20030125.135611.74744521.maeda@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 2.2 on Emacs 20.3 / Mule 4.0 (HANANOEN)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found sometimes pid of muitl-threaded core's file name shows
wrong number in 2.5.59 with NPTL-0.17. Problem is, pid of core file
name comes from currnet->pid, but I think it should be current->tgid.

Following patch fixes this problem.

MAEDA Naoaki

diff -Naur linux-2.5.59/fs/exec.c linux-2.5.59-corepidfix/fs/exec.c
--- linux-2.5.59/fs/exec.c	2003-01-17 11:22:02.000000000 +0900
+++ linux-2.5.59-corepidfix/fs/exec.c	2003-01-25 13:20:50.000000000 +0900
@@ -1166,7 +1166,7 @@
 			case 'p':
 				pid_in_pattern = 1;
 				rc = snprintf(out_ptr, out_end - out_ptr,
-					      "%d", current->pid);
+					      "%d", current->tgid);
 				if (rc > out_end - out_ptr)
 					goto out;
 				out_ptr += rc;
@@ -1238,7 +1238,7 @@
 	if (!pid_in_pattern
             && (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)) {
 		rc = snprintf(out_ptr, out_end - out_ptr,
-			      ".%d", current->pid);
+			      ".%d", current->tgid);
 		if (rc > out_end - out_ptr)
 			goto out;
 		out_ptr += rc;
