Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278682AbRJ1Vkx>; Sun, 28 Oct 2001 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278683AbRJ1Vko>; Sun, 28 Oct 2001 16:40:44 -0500
Received: from pl038.nas921.ichikawa.nttpc.ne.jp ([210.165.234.38]:7737 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S278682AbRJ1Vkf>;
	Sun, 28 Oct 2001 16:40:35 -0500
Date: Mon, 29 Oct 2001 06:39:06 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20-pre11 fails to compile (still)
Message-Id: <20011029063906.609cbe6b.bruce@ask.ne.jp>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent a similar report to the list earlier. I've had some more time to look at
the problem myself, but 2.2.20-pre11 still fails to compile for me, as it stops
in the changes in process.c, signal.c and traps.c. Examples of the errors are:

-------
make[1]: Entering directory `/usr/src/linux-2.2.20/arch/i386/kernel'
cc -D__KERNEL__ -I/usr/src/linux-2.2.20/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer  -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functions=2 -DCPU=586   -c -o process.o process.c
process.c: In function `sys_execve':
process.c:812: structure has no member named `ptrace'
process.c:812: `PT_DTRACE' undeclared (first use this function)
process.c:812: (Each undeclared identifier is reported only once
process.c:812: for each function it appears in.)
make[1]: *** [process.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.2.20/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2
-------

I reverted the change:

-               current->flags &= ~PF_DTRACE;
+               current->ptrace &= ~PT_DTRACE;

and process.c then compiled. However, signals.c then hit a problem with the
following change:

-              if ((current->flags & PF_PTRACED) && signr != SIGKILL) {
+              if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {

After reverting that, the compile then stops in traps.c:

-------
cc -D__KERNEL__ -I/usr/src/linux-2.2.20/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer  -pipe -fno-strength-reduce -m486 -malign-loops=2
-malign-jumps=2 -malign-functions=2 -DCPU=586   -c -o traps.o traps.c
traps.c: In function `do_debug':
traps.c:383: structure has no member named `ptrace'
traps.c:383: `PT_DTRACE' undeclared (first use this function)
traps.c:383: (Each undeclared identifier is reported only once
traps.c:383: for each function it appears in.)
traps.c:383: `PT_PTRACED' undeclared (first use this function)
make[1]: *** [traps.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.2.20/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2
-------

I believe these changes are related to the SUID ptrace fixes, but why am I
missing the definitions for these symbols? I can keep on reverting the changes
to get it compiled, but I'd rather figure out what's going wrong.
The system is an old Slackware 3.6 box with libc5 (ver 5.4.46).


Bruce
