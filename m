Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269833AbUJGNAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbUJGNAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUJGM5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:57:37 -0400
Received: from science.horizon.com ([192.35.100.1]:27698 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269697AbUJGMtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:49:10 -0400
Date: 7 Oct 2004 12:49:09 -0000
Message-ID: <20041007124909.12995.qmail@science.horizon.com>
From: linux@horizon.com
To: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: cfriesen@nortelnetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the following?  Should I make a similar addition to
poll(2)?

Legalese:
These changes are works of original authorship.
These changes are hereby released into the public domain; copyright abandoned.

--- man2/select.2.old	2004-10-07 07:58:46.000000000 -0400
+++ man2/select.2	2004-10-07 08:38:24.000000000 -0400
@@ -170,7 +170,7 @@
 .IR sigmask ,
 avoiding the race.)
 Since Linux today does not have a
-.IR pselect ()
+.BR pselect ()
 system call, the current glibc2 routine still contains this race.
 .SS "The timeout"
 The time structures involved are defined in
@@ -291,6 +291,18 @@
     return 0;
 }
 .fi
+.SH BUGS
+.B pselect
+is currently emulated with a user-space wrapper that has a race condition.
+For reliable (and more portable) signal trapping, use the self-pipe trick.
+(Where a signal handler writes to a pipe whose other end is read by the
+main loop.)
+
+.B select
+and
+.B pselect
+permit blocking file descritprs in the fd_sets, even though
+there is no valid reason for a program to do this.
 .SH "CONFORMING TO"
 4.4BSD (the
 .B select
@@ -315,6 +327,39 @@
 .I fd
 to be a valid file descriptor.
 
+When
+.B select
+indicates that a file descriptor is ready, this is only a strong hint,
+not a guarantee, that a read or write is possible without blocking.
+For this reason, the associated file descriptors must always be in
+non-blocking mode (see
+.BR fcntl (2))
+in a correct program.  Reasons why the I/O could block include:
+.TP
+(i)
+Another process may have performed I/O on the
+.I fd
+in the meantime.
+.TP
+(ii)
+Some needed kernel buffer space may have been consumed for reasons
+totally unrelated to this I/O, or
+.TP
+(iii)
+Since 2.4.x, Linux has overlapped UDP checksum verification with
+copying to user-space.  If a UDP packet arrives,
+.B select
+will indicate that data is ready, but during the read, if the checksum is
+bad, the packet will disappear and (if no subsequent packet with a
+valid checksum is waiting) the read will indicate that no data is available.
+.PP
+In general, it is legal for
+.B select
+to make some optimistic assumptions, subject to later verification by the
+subsequent I/O, as long as this does not result in a busy-loop where
+.B select
+is stuck thinking data is ready when it is not.
+
 Concerning the types involved, the classical situation is that
 the two fields of a struct timeval are longs (as shown above),
 and the struct is defined in
