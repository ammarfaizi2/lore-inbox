Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbREUMkF>; Mon, 21 May 2001 08:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbREUMj4>; Mon, 21 May 2001 08:39:56 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:36335 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S261405AbREUMjl>; Mon, 21 May 2001 08:39:41 -0400
Message-ID: <3B090C81.53F163C3@TeraPort.de>
Date: Mon, 21 May 2001 14:39:29 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: rhw@memalpha.cx, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 while trying to enhance a small hardware inventory script, I found that
cpuinfo is missing the details of L1, L2 and L3 size, although they may
be available at boot time. One could of cource grep them from "dmesg"
output, but that may scroll away on long lived systems.

 The following small patch (against 2.4.4-ac11) extracts/outputs the
cache sizes (i386 only) in arch/i386/kernel/setup.c. It also stores them
in the cpuinfo_x86 structure. This may not be necessary for a one time
usage.

--- linux-2.4.4-ac11.orig/arch/i386/kernel/setup.c      Mon May 21
14:15:27 2001
+++ linux-2.4.4-ac11/arch/i386/kernel/setup.c   Mon May 21 14:27:58 2001
@@ -67,6 +67,10 @@
  *
  *  AMD Athlon/Duron/Thunderbird bluesmoke support.
  *  Dave Jones <davej@suse.de>, April 2001.
+ *
+ *  More detailed output of L1, L2 and L3 cache sizes to /proc/cpuinfo,
if available.
+ *  Martin Knoblauch <m.knoblauch@teraport.de>, May 2001
+ *
  */

 /*
@@ -1113,6 +1117,8 @@
                printk(KERN_INFO "CPU: L1 I Cache: %dK (%d bytes/line),
D cache %dK (%d bytes/line)\n",
                        edx>>24, edx&0xFF, ecx>>24, ecx&0xFF);
                c->x86_cache_size=(ecx>>24)+(edx>>24);
+               c->x86_L1I_size = edx>>24;
+               c->x86_L1D_size = ecx>>24;
        }

        if (n < 0x80000006)     /* Some chips just has a large L1. */
@@ -1133,6 +1139,7 @@
                return;         /* Again, no L2 cache is possible */

        c->x86_cache_size = l2size;
+       c->x86_L2_size = ecx >> 16;

        printk(KERN_INFO "CPU: L2 Cache: %dK (%d bytes/line)\n",
               l2size, ecx & 0xFF);
@@ -1883,6 +1890,8 @@
                                cpuid(0x80000005,&aa,&bb,&cc,&dd);
                                /* Add L1 data and code cache sizes. */
                                c->x86_cache_size = (cc>>24)+(dd>>24);
+                               c->x86_L1I_size = cc>>24;
+                               c->x86_L1D_size = dd>>24;
                        }
                        sprintf( c->x86_model_id, "WinChip %s", name );
                        mcheck_init(c);
@@ -2141,6 +2150,10 @@
                 * SMP switching weights.
                 */
                c->x86_cache_size = l2 ? l2 : (l1i+l1d);
+               if(l1i) c->x86_L1I_size = l1i;
+               if(l1d) c->x86_L1D_size = l1d;
+               if(l2)  c->x86_L2_size = l2;
+               if(l3)  c->x86_L3_size = l3;
        }

        /* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
@@ -2446,6 +2459,10 @@

        c->loops_per_jiffy = loops_per_jiffy;
        c->x86_cache_size = -1;
+       c->x86_L1D_size = -1;
+       c->x86_L1I_size = -1;
+       c->x86_L2_size = -1;
+       c->x86_L3_size = -1;
        c->x86_vendor = X86_VENDOR_UNKNOWN;
        c->cpuid_level = -1;    /* CPUID not detected */
        c->x86_model = c->x86_mask = 0; /* So far unknown... */
@@ -2736,9 +2753,17 @@
                                cpu_khz / 1000, (cpu_khz % 1000));
                }
 
-               /* Cache size */
+               /* Cache size(s) */
                if (c->x86_cache_size >= 0)
                        p += sprintf(p, "cache size\t: %d KB\n",
c->x86_cache_size);
+               if (c->x86_L1I_size >= 0)
+                       p += sprintf(p, "L1-I cache size\t: %d KB\n",
c->x86_L1I_size);
+               if (c->x86_L1D_size >= 0)
+                       p += sprintf(p, "L1-D cache size\t: %d KB\n",
c->x86_L1D_size);
+               if (c->x86_L2_size >= 0)
+                       p += sprintf(p, "L2 cache size\t: %d KB\n",
c->x86_L2_size);
+               if (c->x86_L3_size >= 0)
+                       p += sprintf(p, "L3 cache size\t: %d KB\n",
c->x86_L3_size);
 
                /* We use exception 16 if we have hardware math and
we've either seen it or the CPU claims it is internal */
                fpu_exception = c->hard_math && (ignore_irq13 ||
cpu_has_fpu);
--- linux-2.4.4-ac11.orig/include/asm-i386/processor.h  Mon May 21
14:16:20 2001
+++ linux-2.4.4-ac11/include/asm-i386/processor.h       Mon May 21
09:01:21 2001
@@ -44,6 +44,10 @@
        char    x86_model_id[64];
        int     x86_cache_size;  /* in KB - valid for CPUS which support
this
                                    call  */
+       int     x86_L1D_size;
+       int     x86_L1I_size;
+       int     x86_L2_size;
+       int     x86_L3_size;
        __u16   clockmul;        /* Clock multiplier */
        int     fdiv_bug;
        int     f00f_bug;


Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
