Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTD2Cyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 22:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbTD2Cyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 22:54:33 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:55452 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261524AbTD2Cya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 22:54:30 -0400
Message-Id: <200304290311.h3T3BEjd006153@pasta.boston.redhat.com>
To: Andries Brouwer <aeb@cwi.nl>
cc: linux-kernel@vger.kernel.org
Subject: manual page update for semop(2)/semtimedop(2)
Date: Mon, 28 Apr 2003 23:11:13 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andries.  Below is a patch for updating the semop(2) manual page
to incorporate additional text relating to the new Linux semtimedop(2)
system call.  The new name should probably be symlink'ed to the old one.

I apologize for copying LKML if this was inappropriate, but I did want
to point out the addition of this proposed sentence:

	"If the timeout parameter is NULL, then semtimedop
	 behaves exactly like semop."

This should serve as clarification to architecture maintainers that no
fetch of the user program's timespec structure should be performed if
the timeout parameter is NULL.  This is a subtle issue for consistent
behavio(u)r provided by 32-bit-compatibility mode support.

Cheers.  -ernie



diff -u man-pages-1.56/man2/semop.2{.orig,}
--- man-pages-1.56/man2/semop.2.orig	2003-04-28 21:47:56.000000000 -0400
+++ man-pages-1.56/man2/semop.2	2003-04-28 22:33:45.000000000 -0400
@@ -23,9 +23,11 @@
 .\" Modified Tue Oct 22 17:55:06 1996 by Eric S. Raymond <esr@thyrsus.com>
 .\" Modified 8 Jan 2002, Michael Kerrisk <mtk16@ext.canterbury.ac.nz>
 .\"
-.TH SEMOP 2 2002-01-08 "Linux 2.4" "Linux Programmer's Manual" 
+.TH SEMOP 2 2003-04-28 "Linux 2.4" "Linux Programmer's Manual" 
 .SH NAME
 semop \- semaphore operations
+.sp
+semtimedop \- semaphore operations with timeout
 .SH SYNOPSIS
 .nf
 .B
@@ -39,6 +41,14 @@
 .BI "int semop(int " semid ,
 .BI "struct sembuf *" sops ,
 .BI "unsigned " nsops );
+.sp
+.BI "int semtimedop(int " semid ,
+.BI "struct sembuf *" sops ,
+.BI "unsigned " nsops ,
+.br
+.in +15n
+.BI "struct timespec *" timeout );
+.in -15n
 .SH DESCRIPTION
 A semaphore is represented by an anonymous structure
 including the following members:
@@ -158,6 +168,15 @@
 .I errno
 set to
 .BR EINTR .
+.IP \(bu
+The time limit specified by
+.I timeout
+in a
+.B semtimedop
+call expires: the system call fails, with
+.I errno
+set to
+.BR EAGAIN .
 .PP
 If
 .I sem_op
@@ -225,6 +244,15 @@
 .I errno
 set to
 .BR EINTR .
+.IP \(bu
+The time limit specified by
+.I timeout
+in a
+.B semtimedop
+call expires: the system call fails, with
+.I errno
+set to
+.BR EAGAIN .
 .PP
 On successful completion, the
 .I sempid
@@ -236,6 +264,33 @@
 .\" and
 .\" .I sem_ctime
 is set to the current time.
+.PP
+The function
+.B semtimedop
+behaves identically to the function
+.B semop
+except that in those cases were the calling process would sleep,
+the duration of that sleep is limited by the amount of elapsed
+time specified by the
+.B timespec
+structure whose address is passed in the
+.I timeout
+parameter.  If the specified time limit has been reached,
+the system call fails with
+.I errno
+set to
+.B EAGAIN
+(and none of the operations in
+.I sops
+is performed).
+If the
+.I timeout
+parameter is
+.BR NULL ,
+then
+.B semtimedop
+behaves exactly like
+.BR semop .
 .SH "RETURN VALUE"
 If successful the system call returns
 .BR 0 ,
@@ -262,15 +317,20 @@
 semaphore set as required by one of the specified operations.
 .TP
 .B EAGAIN
-An operation could not proceed immediately and
+An operation could not proceed immediately and either
 .BR IPC_NOWAIT
 was asserted in its
-.IR sem_flg .
+.I sem_flg
+or the time limit specified in
+.I timeout
+expired.
 .TP
 .B EFAULT
-The address pointed to by
+An address specified in either the
 .I sops
-isn't accessible.
+or
+.I timeout
+parameters isn't accessible.
 .TP
 .B EFBIG
 For some operation the value of
