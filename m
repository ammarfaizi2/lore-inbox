Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136706AbRASWhQ>; Fri, 19 Jan 2001 17:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136935AbRASWhG>; Fri, 19 Jan 2001 17:37:06 -0500
Received: from gw.atria.com ([192.88.237.2]:48142 "EHLO gw.atria.com")
	by vger.kernel.org with ESMTP id <S136706AbRASWg7>;
	Fri, 19 Jan 2001 17:36:59 -0500
Message-Id: <200101192237.RAA00039@cryolite.atria.com>
Date: Fri, 19 Jan 2001 17:37:38 -0500 (EST)
From: William Taber <wtaber@rational.com>
Reply-To: William Taber <wtaber@rational.com>
Subject: fs/readdir.c:fillonedir() vs. fs/readdir.c:filldir()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: EcCXX0dZWmtnGSuDrK2EFA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.3.4p_5 SunOS 5.7 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

In porting our file system to Linux, we discovered a discrepancy in the
old and new method of returning directory entries to programs.  This
exists in 2.2.x and 2.4.x kernels (and maybe older ones too?)

fs/readdir.c:filldir(), used by most (?) programs, expects the
directory entry provided by the file system to have the d_offset field
set to the offset of the *current* entry, and it plays games to use the 
next entry's offset to return to the user for the current directory
entry's d_offset field.

fs/readdir.c:fillonedir(), used by (apparently?) ancient
programs/libraries, expects the directory entry provided by the file
system to have the d_offset field set to what should be sent to the
user, i.e. the offset of the *next* entry.

These two are mutually incompatible interpretations of how to fill in
directory entries, and there's no way for the file system to tell which
one is going to be used when its file_ops->readdir() function is
invoked.

I would guess this is rarely a problem because fillonedir() is rarely
used, and it should be fixed to use the readdir results as expected by
filldir().  But I'm not sure it's possible to find/save enough state to
do this right, as the old readdir gets a single entry per syscall.

Perhaps the readdir interface to the file systems should expect the file
system to provide the proper d_offset field in each entry (holding the
offset of the following entry), then filldir() and sys_getdents() can
avoid all the mucking about with d_offset?

Will Taber

+---------------------------------------------------------------------+
| Will Taber                                                          |
| Software Engineer, CMBU                 E-mail  wtaber@rational.com |
| Rational Software Corporation           Phone:  781-676-2436        |
| 20 Maguire Road, Lexington, Mass. 02421                             |
+---------------------------------------------------------------------+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
