Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129447AbRBMTSl>; Tue, 13 Feb 2001 14:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129626AbRBMTSV>; Tue, 13 Feb 2001 14:18:21 -0500
Received: from CRUSH.REM.CMU.EDU ([128.2.81.185]:32909 "EHLO crush.hunch.net")
	by vger.kernel.org with ESMTP id <S129558AbRBMTSN>;
	Tue, 13 Feb 2001 14:18:13 -0500
Date: Tue, 13 Feb 2001 14:22:05 -0500 (EST)
From: John Langford <l_k_account@crush.hunch.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 loopback bug
Message-ID: <Pine.LNX.4.21.0102131414210.16046-100000@crush.hunch.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a heisenbug embedded in the 2.4 loopback driver.  The
symptom is that at some point a kernel call just fails to return.  I've
tried to reduce this to the simplest possible example and came up with the
following trace for a generic 2.4.1 kernel.

[root@crush jl]# ls -l bigrandom 
-rw-r--r--    1 jl       500      2097152000 Feb  6 12:16 bigrandom
[root@crush jl]# /sbin/losetup /dev/loop1 bigrandom 
Feb  6 14:46:24 crush kernel: loop: enabling 8 loop devices
[root@crush jl]# strace /sbin/mke2fs /dev/loop1
lseek(3, 1745338368, SEEK_SET)          = 1745338368
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,32768) = 32768
lseek(3, 1745371136, SEEK_SET)          = 1745371136
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,32768

This last write never returned, the mke2fs process became unkillable, and
load went to '4'.  There were no interesting messages in the log.  The
thing which makes this bug nasty is that it surfaces at a random
time.  I've had it happen on a file size of 1GB, but it only reliably
happens on a 2GB file.

Is anyone working on this?  Or do you have suggestions for debugging it?

-John

