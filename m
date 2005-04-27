Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVD0UWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVD0UWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVD0UWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:22:36 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:48261 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261898AbVD0UWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:22:04 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,135,1112565600"; 
   d="scan'208"; a="8253184:sNHT23495184"
Message-ID: <426FF466.10501@fujitsu-siemens.com>
Date: Wed, 27 Apr 2005 22:21:58 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Again: UML on s390 (31Bit)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this mail again, because unfortunately I didn't receive
any reply. It was sent the first time at April, 5th.

Regards, Bodo


Hi,

currently I'm porting UML to s390 31-bit.
A first 2.6.11 UML system already is running in UML-SKAS0 mode,
which normally should run on an unpatched host (no skas3-patch).

To make UML build and run on s390, I needed to do these two little
changes (the patches are copy and paste. I hope that doesn't hurt,
since they are very small):

1) UML includes some of the subarch's (s390) headers. I had to
    change one of them with the following one-liner, to make this
    compile. AFAICS, this change doesn't break compilation of s390
    itself.

==============================================================================
--- linux-2.6.11.orig/include/asm-s390/user.h	2004-12-09 18:45:02.000000000 +0100
+++ linux-2.6.11/include/asm-s390/user.h	2004-12-09 18:48:11.000000000 +0100
@@ -10,7 +10,7 @@
  #define _S390_USER_H

  #include <asm/page.h>
-#include <linux/ptrace.h>
+#include <asm/ptrace.h>
  /* Core file format: The core file is written in such a way that gdb
     can understand it and provide useful information to the user (under
     linux we use the 'trad-core' bfd).  There are quite a number of
==============================================================================

2) UML needs to intercept syscalls via ptrace to invalidate the syscall,
    read syscall's parameters and write the result with the result of
    UML's syscall processing. Also, UML needs to make sure, that the host
    does no syscall restart processing. On i386 for example, this can be
    done by writing -1 to orig_eax on the 2nd syscall interception
    (orig_eax is the syscall number, which after the interception is used
    as a "interrupt was a syscall" flag only.
    Unfortunately, s390 holds syscall number and syscall result in gpr2 and
    its "interrupt was a syscall" flag (trap) is unreachable via ptrace.
    So I changed the host to set trap to -1, if the syscall number is written
    to a negative value on the first syscall interception.
    I hope, this adds what UML needs without changing ptrace visibly to other
    ptrace users.
    (This isn't tested on a 2.6 host yet, because my host still is a 2.4.21 SuSE.
    But I've adapted this change to 2.4 and tested, it works.)


==============================================================================
--- linux-2.6.11.orig/arch/s390/kernel/ptrace.c	2005-04-04 18:57:38.000000000 +0200
+++ linux-2.6.11/arch/s390/kernel/ptrace.c	2005-04-04 19:01:51.000000000 +0200
@@ -726,6 +726,13 @@
				  ? 0x80 : 0));

  	/*
+	 * If debugger has set an invalid syscall number,
+	 * we prepare to skip syscall restart handling
+	 */
+	if (!entryexit && (long )regs->gprs[2] < 0 )
+		regs->trap = -1;
+
+	/*
  	 * this isn't the same as continuing with a signal, but it will do
  	 * for normal use.  strace only continues with a signal if the
  	 * stopping signal is not SIGTRAP.  -brl
==============================================================================


It would be very helpful for me, if these changes could go into s390 mainline.
If there is something wrong with them, please help me find a better solution.


Regards, Bodo
