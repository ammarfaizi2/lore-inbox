Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUAFWtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAFWtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:49:23 -0500
Received: from gizmo13ps.bigpond.com ([144.140.71.23]:59067 "HELO
	gizmo13ps.bigpond.com") by vger.kernel.org with SMTP
	id S265433AbUAFWtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:49:18 -0500
Message-ID: <3FFB3B6A.C294D7F3@eyal.emu.id.au>
Date: Wed, 07 Jan 2004 09:49:14 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.24-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>,
       valgrind-developers list 
	<valgrind-developers@lists.sourceforge.net>
Subject: 2.4.24 asm/timex.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the current patch:

--- linux-2.4.24/include/asm-i386/timex.h       2002-11-28
23:53:15.000000000 +0000
+++ linux-2.4.25-pre4/include/asm-i386/timex.h  2004-01-06
12:43:33.000000000 +0000
@@ -40,14 +40,10 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-       return 0;
-#else
-       unsigned long long ret;
-
-       rdtscll(ret);
+       unsigned long long ret = 0;
+       if(cpu_has_tsc)
+               rdtscll(ret);
        return ret;
-#endif
 }
 
 extern unsigned long cpu_khz;

Building valgrind, it includes <linux/timex.h> and then tries
to use the adjtimex syscall. This ends up with an undefined
error for 'cpu_has_tsc'. This did not happen with earlier
kernels.

In file included from /usr/include/linux/timex.h:152,
                 from vg_unsafe.h:66,
                 from vg_syscalls.c:35:
/usr/include/asm/timex.h: In function `get_cycles':
/usr/include/asm/timex.h:44: `cpu_has_tsc' undeclared (first use in this
function)


Is this a problem with 2.4-pre or is valgrind inappropriately
messing with kernel headers?

For the moment I hacked it badly in coregrind/vg_unsafe.h:
	#define cpu_has_tsc 1
	#include <linux/timex.h>

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
