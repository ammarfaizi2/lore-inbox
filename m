Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRFLFYZ>; Tue, 12 Jun 2001 01:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264176AbRFLFYP>; Tue, 12 Jun 2001 01:24:15 -0400
Received: from ugw.utcc.utoronto.ca ([128.100.100.3]:63479 "HELO
	ugw.utcc.utoronto.ca") by vger.kernel.org with SMTP
	id <S264173AbRFLFYG>; Tue, 12 Jun 2001 01:24:06 -0400
To: linux-kernel@vger.kernel.org
Subject: bug: getdents64() mangles most 32bit+ d_off values (x86 only?)
Date: Tue, 12 Jun 2001 01:23:41 -0400
From: Chris Siebenmann <cks@utcc.utoronto.ca>
Message-Id: <01Jun12.012344edt.230371@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The struct dirent64 that getdents64() returns is supposed to be able to
return 64 bit d_off values. This is handy for, for example, NFS v3.

 Unfortunately the current code will mangle anything more than 31 bits,
because the filldir functions (and the filldir_t prototype) all use
'off_t offset' instead of 'loff_t offset'. The net effect of the code is
that almost all offsets/directory cookies are first truncated to 32 bits
and then sign-extended into 64 bits again.

 The single exception is the last d_off value, which sys_getdents64()
copies directly from filp->f_pos, itself an loff_t, and thus passes
through intact.

 The obvious patch is to change the 'off_t offset' to 'loff_t offset' in
the relevant places. I have put together such a patch and can send it
if people think that this is the right fix. However, there is a wrinkle:

 Glibc 2.2's readdir() (actually its internal __getdents() routine) is
unhappy with dirent64 d_off values that are not arithmetically equal
to their off_t versions. If you have 32-bit d_off values with the high
bit set (such as NFS v2 directory cookies from SGI Irix XFS-based NFS
servers) __getdents() only accepts the truncated-and-sign-extended
versions (arithmetically equal); if passed through to user land as
proper 64 bit values, glibc detects a truncation error in the kernel
d_off to 32-bit user dirent d_off structure and bails out, making some
directory entries unreadable.

 The net result is that if the kernel is fixed to be correct, everyone
in this situation with applications that call readdir() are going to see
reasonably truncated directories. At current, they merely lose the last
entry in the directories, and would see everything if sys_getdents64()
was changed to truncate f_pos in the same way as filldir64 does.

 While my personal opinion is that the kernel change should happen,
since it makes getdents64() actually return what it certainly appears
it should, I didn't want to put forward the patch without mentioning
the downside.

 Any opinions from those wiser in the ways of this bit of the kernel
than myself? Damn the torpedos and full speed ahead?

	- cks
