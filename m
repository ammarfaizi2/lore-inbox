Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRFQKun>; Sun, 17 Jun 2001 06:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264718AbRFQKud>; Sun, 17 Jun 2001 06:50:33 -0400
Received: from KMLinux.fjfi.cvut.cz ([147.32.8.9]:46353 "EHLO
	KMLinux.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id <S264717AbRFQKuT>; Sun, 17 Jun 2001 06:50:19 -0400
Date: Sun, 17 Jun 2001 12:49:30 +0200 (CEST)
From: Henryk Paluch <paluch@KMLinux.fjfi.cvut.cz>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5: K7 MCE reporting not enabled due missing mcheck_init()
Message-ID: <Pine.LNX.4.33.0106171240100.3936-100000@KMLinux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

It seems, that 2.4.5 is supposed to support K7 Machine Check Exception
in arch/i386/kernel/bluesmoke.c. However mcheck_init() is called from
init_intel() in arch/i386/kernel/setup.c only. Therefore it is never
invoked from init_amd() - so not enabled.

I tried following patch:

--- arch/i386/kernel/setup.c.orig	Sat Jun 16 22:20:41 2001
+++ arch/i386/kernel/setup.c	Sun Jun 17 10:44:50 2001
@@ -1126,6 +1126,7 @@
 	unsigned long flags;
 	int mbytes = max_mapnr >> (20-PAGE_SHIFT);
 	int r;
+	extern void mcheck_init(struct cpuinfo_x86 *c);

 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -1237,6 +1238,7 @@
 	}

 	display_cacheinfo(c);
+	mcheck_init(c);
 	return r;
 }

and my life had changed suddenly:
...
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
...

According to /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 699.693
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91

this Duron really supports both MCE & MCA, so I hope, that this patch is
correct. I'd like to ask brave/stupid overclockers to try this patch - it
would prove, whether MCE really works on AMD K7 :-)

-- 

Sincerely
    Henryk Paluch, paluch@bimbo.fjfi.cvut.cz


