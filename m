Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTJZPdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 10:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTJZPdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 10:33:02 -0500
Received: from aeimail.aei.ca ([206.123.6.14]:26334 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263207AbTJZPc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 10:32:57 -0500
Subject: Re: Linux 2.6.0-test9
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-W5ndiius3UV4fAaOBl/l"
Organization: 
Message-Id: <1067182375.17710.11.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Oct 2003 10:32:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W5ndiius3UV4fAaOBl/l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

gcc2.96, from Mandrake 8.2 (I would suspect that Redhat 7.* releases are
in this boat too) has a bug that prevents the compilation -test9.

fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1337 1673 1667 (parallel[ 
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1331 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2

and a little patch that resolves it for me

diff -ur linux-2.6.0-test9/fs/proc/array.c
linux-2.6.0-test9-A/fs/proc/array.c
--- linux-2.6.0-test9/fs/proc/array.c   Sat Oct 25 18:21:46 2003
+++ linux-2.6.0-test9-A/fs/proc/array.c Sat Oct 25 19:14:15 2003
@@ -295,7 +295,8 @@
 {
        unsigned long vsize, eip, esp, wchan;
        long priority, nice;
-       int tty_pgrp = -1, tty_nr = 0;
+       int tty_pgrp = -1;
+       volatile int tty_nr = 0;
        sigset_t sigign, sigcatch;
        char state;
        int res;

Attached as well in case it gets mangled.

Regards,

Shane

--=-W5ndiius3UV4fAaOBl/l
Content-Disposition: attachment; filename=gcc2.96.patch
Content-Type: text/x-patch; name=gcc2.96.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ur linux-2.6.0-test9/fs/proc/array.c linux-2.6.0-test9-A/fs/proc/array.c
--- linux-2.6.0-test9/fs/proc/array.c	Sat Oct 25 18:21:46 2003
+++ linux-2.6.0-test9-A/fs/proc/array.c	Sat Oct 25 19:14:15 2003
@@ -295,7 +295,8 @@
 {
 	unsigned long vsize, eip, esp, wchan;
 	long priority, nice;
-	int tty_pgrp = -1, tty_nr = 0;
+	int tty_pgrp = -1;
+	volatile int tty_nr = 0;
 	sigset_t sigign, sigcatch;
 	char state;
 	int res;

--=-W5ndiius3UV4fAaOBl/l--

