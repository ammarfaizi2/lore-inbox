Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSKBG6E>; Sat, 2 Nov 2002 01:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265887AbSKBG6D>; Sat, 2 Nov 2002 01:58:03 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:55963 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265886AbSKBG6C>; Sat, 2 Nov 2002 01:58:02 -0500
Date: Sat, 02 Nov 2002 01:03:53 -0500
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Athlon cache-line fix
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>
Message-Id: <20021102005122.2205.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 01:04:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for Athlon cache-line.

For Athlon CPU, CONFIG_X86_MK7, 
the X86_L1_CACHE_SHIFT is set to 6, 128 Bytes, and this value is used 
for L1 cache aligning.

But the AMD’s document clearly states that the cache-line for 
Athlon is 64 Bytes. 
When I set the X86_L1_CACHE_SHIFT = 5 the performance increased 
significantly about 30%.

These are measurements from Taka’s simple socket benchmark program.
http://www.suna-asobi.com/~akira-t/linux/netio-bench/netio2.c

This is result for X86_L1_CACHE_SHIFT = 6.
(off:100, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.117 seconds at 341.6 Mbytes/sec
(off:104, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.116 seconds at 343.9 Mbytes/sec
(off:108, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.116 seconds at 345.4 Mbytes/sec
(off:112, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.115 seconds at 348.7 Mbytes/sec
(off:116, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.114 seconds at 352.4 Mbytes/sec
(Entire log is here, 
http://www.suna-asobi.com/~akira-t/linux/cache-align-fix/K7_cache_shift_6.log)

This is result for X86_L1_CACHE_SHIFT = 5
(off:100, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.086 seconds at 462.4 Mbytes/sec
(off:104, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.087 seconds at 458.5 Mbytes/sec
(off:108, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.087 seconds at 461.8 Mbytes/sec
(off:112, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.088 seconds at 453.9 Mbytes/sec
(off:116, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.088 seconds at 456.7 Mbytes/sec
(Entire log is here, 
http://www.suna-asobi.com/~akira-t/linux/cache-align-fix/K7_cache_shift_5.log)

I attached the patch to fix this. But a bit worry that somebody might
reverse this changes because Athlon has 128bytes L1.
(Athlon-L1, data 64bytes + instruction 64bytes = total 128bytes)

(I found this problem by accident while I was making faster 
user_to/from_copy function, inspired from taka's faster_intel_copy,
which went into 2.5.45)


--- linux-2.5.45/arch/i386/Kconfig	Thu Oct 31 22:40:01 2002
+++ linux-2.5.45-tkcp-1/arch/i386/Kconfig	Sat Nov  2 01:34:19 2002
@@ -190,9 +190,8 @@
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || M686 || M586MMX || M586TSC || M586
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MK7|| MPENTIUMIII || M686 || M586MMX || M586TSC || M586
 	default "4" if MELAN || M486 || M386
-	default "6" if MK7
 	default "7" if MPENTIUM4
 
 config RWSEM_GENERIC_SPINLOCK

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


