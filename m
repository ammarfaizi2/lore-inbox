Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311497AbSCSRtN>; Tue, 19 Mar 2002 12:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311499AbSCSRtC>; Tue, 19 Mar 2002 12:49:02 -0500
Received: from morrison.empeg.co.uk ([193.119.19.130]:60157 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S311497AbSCSRss>; Tue, 19 Mar 2002 12:48:48 -0500
Message-ID: <006701c1cf6d$d9701230$2701230a@electronic>
From: "Peter Hartley" <pdh@utter.chaos.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Date: Tue, 19 Mar 2002 17:45:24 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When setrlimit/getrlimit were changed to take unsigned rather than signed
limits, a new syscall was invented for getrlimit that returned the signed
values that old programs expected. But no new syscall was invented for
setrlimit; both old and new programs come to the same function (in
kernel/sys.c). This was, according to the glibc source, at about 2.3.25
time.

This breaks any old program which tries to set a limit of RLIM_INFINITY.
Such a program will end up passing a 0x7FFFFFFF to sys_setrlimit, which will
be dutifully placed in the current->rlim array. Once there it will
completely fail to compare equal to the kernel's RLIM_INFINITY value,
0xFFFFFFFF.

"Old" in this context means any program linked against a glibc that was
built against 2.2 headers.

In particular, this means that an e2fsck 1.27 built against such a glibc
will fail with SIGXFS every time on any block device bigger than 2Gbytes.
This is because:

 * e2fsck calls setrlimit(RLIMIT_FSIZE, RLIM_INFINITY) in
   an attempt to unset the limit. RLIM_INFINITY here is
   0xFFFFFFFF. This is IMO the Right Thing.
 * glibc knows nothing about the new unsigned limits, because
   it's compiled against 2.2 headers. So it clips the limit
   value to 0x7FFFFFFF to "correct" it before calling the
   setrlimit syscall. This is IMO still the Right Thing,
   because it's trying to call the old syscall as if to run
   a new program on a 2.2 kernel.
 * The kernel writes the 0x7FFFFFFF value uninterpreted into
   the current->rlim array. This is IMO the bug.

Surely the only Right Things to do in the kernel are (a) invent a new
setrlimit call that corrects the RLIM_INFINITY value, or (b) have the
current setrlimit call correct the RLIM_INFINITY value unconditionally.

Answer (b) breaks programs that deliberately set a limit of 0x7FFFFFFF, but
it's less intrusive than answer (a). The patch for (b) is fairly trivial and
I'll rustle one up if people agree it's the Right Thing.

Complete test situation that reproduced the bug: 2.2.20 system (with
glibc-2.2.5, and 2.2.20 headers in /usr/include) compiling a glibc-2.2.5 and
e2fsprogs-1.27 which are then run on a 2.4.18 system. (As e2fsck is
statically linked, it gets the compile host's glibc, of course.) Root fs is
a 4.5Gbyte ext2 on a 5Gbyte Quantum IDE.

So for my purposes I can fix this by upgrading my compile host to a glibc
that's built against 2.4.18 headers, but I still reckon there's a kernel bug
here.

        Peter


PS. Please CC me on replies, as I only read the list on an archive site. Ta.


