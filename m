Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271880AbRHUWku>; Tue, 21 Aug 2001 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271875AbRHUWkk>; Tue, 21 Aug 2001 18:40:40 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:56297 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271859AbRHUWkb>;
	Tue, 21 Aug 2001 18:40:31 -0400
Date: Tue, 21 Aug 2001 23:40:43 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Theodore Tso <tytso@mit.edu>
Subject: /dev/random entropy calcs - patch [not related to net devices]
Message-ID: <9547398.998437243@[169.254.198.40]>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Anyone have a problem with using xtime rather
   than jiffies on architectures which don't support cycle
   counters? (completely untested patch attached to illustrate)

2. Anyone have any problem changing fs/proc/proc_misc.c to
   register /proc/interrupts to be 0600 instead of 0644 to help
   prevent entropy attacks that way?

--
Alex Bligh

--- drivers/char/random.c.keep       Sat Feb 17 00:02:36 2001
+++ drivers/char/random.c     Tue Aug 21 23:19:17 2001
@@ -710,16 +710,27 @@
        int             entropy = 0;

 #if defined (__i386__)
+       /* If possible, use the clock cycle counter */
        if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
                __u32 high;
                __asm__(".byte 0x0f,0x31"
                        :"=a" (time), "=d" (high));
                num ^= high;
        } else {
-               time = jiffies;
+               time = (__u32)(xtime.tv_usec) ^ (__u32)(xtime.tv_sec);
        }
 #else
-       time = jiffies;
+       /* If we can't get the clock cycle counter, get the number
+        * of elapsed microseconds. Note:
+        * - we don't need the xtime spinlock as we are only reading
+        *   one half (even then, the odd SMP race is only going to
+        *   add to entropy)
+        * - this may indeed wrap; but so could the original cycle
+        *   counter, and as us occur less frequently than clock cycles,
+        *   it's less of a problem. In any case it would underestimate
+        *   entropy on a wrap.
+        */
+       time = (__u32)(xtime.tv_usec) ^ (__u32)(xtime.tv_sec);
 #endif

        /*

