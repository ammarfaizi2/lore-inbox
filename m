Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSC2XHL>; Fri, 29 Mar 2002 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312295AbSC2XHB>; Fri, 29 Mar 2002 18:07:01 -0500
Received: from air-2.osdl.org ([65.201.151.6]:43269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312296AbSC2XGo>;
	Fri, 29 Mar 2002 18:06:44 -0500
Subject: no locking on sys_stat() and smp race condition
From: Daniel McNeil <daniel@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Mar 2002 15:06:40 -0800
Message-Id: <1017443200.3058.228.camel@IBM-C>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the kernel does not do any locking when copying the
inode stat info.  This make stat very fast, but there is a small
race condition on SMP machines that can cause stat to return unexpected
results for if another process is simulteously changing something
returned by stat that is not updated atomically.

One example, is a stat() at the same time of a chown(new_uid, new_gid).
Since uid and gid are updated individually, the stat() can
return new_uid and old_gid.  I have a test program that sees
this on my 2 processor system running 2.4.18.  I am not sure if this
is a bug, but it is unexpected behavior.  One would expect to see the
stat() return the old_uid,old_gid OR new_uid,new_gid.

The 2nd example is a stat64() at the same time as a write() on a 32bit
cpu that causes the upper 32bits to be modified -- like a write causing
the length of a file to grow from 4GB-1 to 4GB. Obviously, compiling the
application for large file support is required.  Since the 64bit size
is not atomically updated on a 32bit cpu, it is possible, very rarely,
to see an incorrect size of 8GB-1 returned by stat64() in this case.
I have a test program that sees this on my 2 processor x86.  Also,
a stat64() racing with a truncate64() can see this on a x86 as well.  
This is a bug.

Both of these race conditions could be considered to be bugs.  The
second is more serious.  However, both are rare.  Can anyone tell me of
a case where the uid/gid race or the 64-bit increment race would cause a
problem for an application or utility?

Daniel




