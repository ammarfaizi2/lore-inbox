Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSKBTjL>; Sat, 2 Nov 2002 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKBTjK>; Sat, 2 Nov 2002 14:39:10 -0500
Received: from pmesmtp01.wcom.com ([199.249.20.1]:39044 "EHLO
	pmesmtp01.wcom.com") by vger.kernel.org with ESMTP
	id <S261301AbSKBThq>; Sat, 2 Nov 2002 14:37:46 -0500
Date: Sat, 02 Nov 2002 13:40:39 -0600
From: steve roemen <steve.roemen@wcom.com>
Subject: RE: [PATCH] Athlon cache-line fix
In-reply-to: <20021102005122.2205.AKIRA-T@suna-asobi.com>
To: "'Akira Tsukamoto'" <akira-t@suna-asobi.com>, linux-kernel@vger.kernel.org
Cc: "'Hirokazu Takahashi'" <taka@valinux.co.jp>,
       "'Andrew Morton'" <akpm@digeo.com>
Reply-to: steve.roemen@wcom.com
Message-id: <001e01c282a7$b99da1a0$e70a7aa5@WSXA7NCC106.wcomnet.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.3719.2500
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: multipart/mixed; boundary="Boundary_(ID_gI7When+Le3S/xm2ak7eiA)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_gI7When+Le3S/xm2ak7eiA)
Content-type: text/plain; charset=iso-2022-jp
Content-transfer-encoding: 7bit

it speeds mine up too.

-steve



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Akira Tsukamoto
Sent: Saturday, November 02, 2002 12:04 AM
To: linux-kernel@vger.kernel.org
Cc: Hirokazu Takahashi; Andrew Morton
Subject: [PATCH] Athlon cache-line fix


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
http://www.suna-asobi.com/~akira-t/linux/cache-align-fix/K7_cache_shift_6.lo
g)

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
http://www.suna-asobi.com/~akira-t/linux/cache-align-fix/K7_cache_shift_5.lo
g)

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
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE ||
MCYRIXIII || MK6 || MPENTIUMIII || M686 || M586MMX || M586TSC || M586
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE ||
MCYRIXIII || MK6 || MK7|| MPENTIUMIII || M686 || M586MMX || M586TSC || M586
 	default "4" if MELAN || M486 || M386
-	default "6" if MK7
 	default "7" if MPENTIUM4

 config RWSEM_GENERIC_SPINLOCK

--
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--Boundary_(ID_gI7When+Le3S/xm2ak7eiA)
Content-type: text/plain; CHARSET=us-ascii; name=netio_test_shift_6.txt
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=netio_test_shift_6.txt

./netio=20
processor: 0
vendor_id: AuthenticAMD
cpu family: 6
model: 6
model name: AMD Athlon(tm) MP 1800+
stepping: 2
cpu MHz: 1533.423
cache size: 256 KB
fdiv_bug: no
hlt_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 1
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips: 3014.65

processor: 1
vendor_id: AuthenticAMD
cpu family: 6
model: 6
model name: AMD Athlon(tm) Processor
stepping: 2
cpu MHz: 1533.423
cache size: 256 KB
fdiv_bug: no
hlt_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 1
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips: 3063.80

cpu: 1533 MHz

################ to(0x804e000) from(0x886e000) ##############
######################### buffer size (0x2000:8192) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.062 =
seconds at 650.1 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 494.9 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 525.5 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 526.0 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 663.1 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 528.5 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 536.0 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 532.6 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 552.8 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 638.6 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 504.9 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 545.6 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 536.8 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.064 =
seconds at 625.6 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.084 =
seconds at 477.9 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.065 =
seconds at 614.5 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.071 =
seconds at 560.7 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 547.6 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 577.0 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 571.8 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.082 =
seconds at 490.6 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 568.5 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 600.3 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 529.6 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 631.2 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 633.3 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.074 =
seconds at 543.0 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 630.4 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 630.0 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 548.1 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.062 =
seconds at 642.3 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 666.7 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 555.5 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 589.3 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.074 =
seconds at 541.7 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 534.7 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.064 =
seconds at 621.4 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 525.5 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 554.8 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.066 =
seconds at 602.5 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 531.0 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.065 =
seconds at 614.4 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 630.9 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 528.1 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.064 =
seconds at 629.2 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.064 =
seconds at 624.1 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.075 =
seconds at 536.1 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.065 =
seconds at 614.1 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.062 =
seconds at 649.6 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 501.0 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.064 =
seconds at 629.2 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 592.8 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 502.6 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 631.5 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 639.9 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 555.0 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.062 =
seconds at 645.2 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 514.1 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 548.5 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.066 =
seconds at 608.3 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 542.4 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 632.6 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 661.4 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 560.4 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 644.2 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.064 seconds at 627.7 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 508.5 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.066 seconds at 602.2 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 642.1 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.072 seconds at 555.0 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 653.2 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.076 seconds at 525.6 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 644.0 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 636.5 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 547.2 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.065 seconds at 613.7 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 641.2 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 513.9 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 660.0 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 662.9 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 562.4 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 645.0 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 543.8 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 540.2 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.067 seconds at 599.4 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.077 seconds at 518.3 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.072 seconds at 556.3 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 660.3 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 562.5 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 657.4 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 586.1 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 545.4 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.067 seconds at 599.6 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.064 seconds at 623.4 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 547.0 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.067 seconds at 597.6 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 654.1 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.072 seconds at 557.4 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 630.9 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.075 seconds at 536.3 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.077 seconds at 517.5 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.064 seconds at 629.7 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 545.6 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.064 seconds at 626.9 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 588.7 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 550.6 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.066 seconds at 606.1 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 632.6 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 507.3 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 576.0 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.065 seconds at 617.5 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.075 seconds at 536.0 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 635.7 Mbytes/sec
######################### buffer size (0x10000:65536) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.133 =
seconds at 300.7 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.150 =
seconds at 266.7 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.151 =
seconds at 265.1 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.154 =
seconds at 259.3 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.140 =
seconds at 284.7 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.147 =
seconds at 271.7 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.148 =
seconds at 270.1 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.147 =
seconds at 271.6 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.134 =
seconds at 298.6 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 288.2 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.146 =
seconds at 274.5 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.143 =
seconds at 279.7 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.152 =
seconds at 262.9 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 287.4 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.151 =
seconds at 265.8 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.140 =
seconds at 284.7 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.146 =
seconds at 274.8 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.133 =
seconds at 301.3 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.134 =
seconds at 298.5 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 287.4 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.144 =
seconds at 278.7 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.137 =
seconds at 292.0 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.143 =
seconds at 279.8 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.137 =
seconds at 291.6 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.136 =
seconds at 294.1 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.141 =
seconds at 284.4 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.138 =
seconds at 290.4 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.136 =
seconds at 294.9 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.140 =
seconds at 286.4 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.141 =
seconds at 283.7 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.135 =
seconds at 296.6 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.140 =
seconds at 284.8 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.125 =
seconds at 319.1 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.126 =
seconds at 318.2 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.130 =
seconds at 307.4 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.137 =
seconds at 292.2 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.137 =
seconds at 291.8 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.141 =
seconds at 283.5 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 288.5 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 287.8 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.142 =
seconds at 282.1 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.138 =
seconds at 290.9 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.137 =
seconds at 291.0 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.141 =
seconds at 284.3 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.136 =
seconds at 295.1 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.135 =
seconds at 297.0 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.142 =
seconds at 281.2 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.130 =
seconds at 308.3 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.133 =
seconds at 301.3 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.123 =
seconds at 326.2 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.122 =
seconds at 326.9 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.125 =
seconds at 319.6 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.123 =
seconds at 325.7 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.124 =
seconds at 321.7 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.136 =
seconds at 294.3 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.132 =
seconds at 302.1 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.132 =
seconds at 302.4 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.139 =
seconds at 287.0 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.135 =
seconds at 296.5 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.136 =
seconds at 295.0 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.139 seconds at 287.4 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.136 seconds at 293.2 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.134 seconds at 298.1 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.136 seconds at 293.4 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.139 seconds at 287.8 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.135 seconds at 297.3 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.137 seconds at 292.0 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.134 seconds at 298.1 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.134 seconds at 299.5 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.136 seconds at 293.9 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.130 seconds at 308.1 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.130 seconds at 308.2 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.136 seconds at 294.0 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 302.3 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.131 seconds at 304.4 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.137 seconds at 291.9 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.121 seconds at 329.6 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.122 seconds at 327.6 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.124 seconds at 322.7 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.119 seconds at 335.9 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.107 seconds at 372.2 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.112 seconds at 358.2 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.115 seconds at 348.4 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.118 seconds at 340.0 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.118 seconds at 338.5 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.121 seconds at 329.6 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.123 seconds at 324.9 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.124 seconds at 323.7 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.121 seconds at 329.9 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.123 seconds at 326.5 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.122 seconds at 328.5 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.137 seconds at 291.3 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.137 seconds at 291.9 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.136 seconds at 293.8 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.140 seconds at 285.6 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.133 seconds at 299.8 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.130 seconds at 308.0 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.137 seconds at 292.6 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 302.9 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 303.2 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.144 seconds at 277.3 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.122 seconds at 327.2 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.121 seconds at 330.3 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.122 seconds at 327.0 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.120 seconds at 332.6 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.119 seconds at 334.8 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.120 seconds at 332.4 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.122 seconds at 327.0 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.134 seconds at 299.0 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 302.1 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 302.8 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.132 seconds at 304.1 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.125 seconds at 320.4 Mbytes/sec
######################### buffer size (0x100000:1048576) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 164.9 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.254 =
seconds at 157.7 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.264 =
seconds at 151.6 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.264 =
seconds at 151.7 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.249 =
seconds at 160.9 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.248 =
seconds at 161.5 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.262 =
seconds at 152.9 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.257 =
seconds at 155.8 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.8 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.8 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.247 =
seconds at 162.2 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.257 =
seconds at 155.8 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.258 =
seconds at 154.9 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.7 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.246 =
seconds at 162.7 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.4 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.263 =
seconds at 152.4 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 165.6 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.6 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.248 =
seconds at 161.6 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.263 =
seconds at 152.1 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.3 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.7 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.262 =
seconds at 152.8 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.5 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.248 =
seconds at 161.5 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 165.7 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.256 =
seconds at 156.2 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.4 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 165.8 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.246 =
seconds at 162.9 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.2 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.255 =
seconds at 157.1 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.3 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.7 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.6 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.249 =
seconds at 160.3 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.9 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.8 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.259 =
seconds at 154.6 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.6 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.248 =
seconds at 161.4 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.3 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.7 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.262 =
seconds at 152.6 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.2 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.246 =
seconds at 162.6 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.5 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.257 =
seconds at 155.9 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.1 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.239 =
seconds at 167.4 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.255 =
seconds at 156.9 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.252 =
seconds at 158.5 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.245 =
seconds at 163.4 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.1 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.261 =
seconds at 153.3 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.4 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.8 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.5 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.2 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.257 seconds at 155.7 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.240 seconds at 166.5 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.246 seconds at 162.3 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.2 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.256 seconds at 156.3 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.2 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.239 seconds at 167.7 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.255 seconds at 156.8 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.250 seconds at 159.8 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 163.8 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.240 seconds at 166.6 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.254 seconds at 157.6 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.254 seconds at 157.8 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.241 seconds at 166.0 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.254 seconds at 157.7 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.250 seconds at 159.8 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.1 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.242 seconds at 165.4 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.258 seconds at 154.8 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.257 seconds at 155.9 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.241 seconds at 165.7 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.5 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.250 seconds at 160.0 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.253 seconds at 158.4 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.241 seconds at 166.1 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.2 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.253 seconds at 158.4 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.249 seconds at 160.8 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.2 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.239 seconds at 167.0 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.254 seconds at 157.7 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.248 seconds at 161.4 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.4 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.241 seconds at 166.3 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.7 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.255 seconds at 156.7 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.240 seconds at 166.5 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.4 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.251 seconds at 159.2 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.246 seconds at 162.8 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.7 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.4 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.231 seconds at 173.0 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.232 seconds at 172.7 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.235 seconds at 170.0 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.231 seconds at 173.0 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.235 seconds at 170.2 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.229 seconds at 174.8 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.1 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.231 seconds at 172.8 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.4 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.232 seconds at 172.5 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.3 Mbytes/sec
steve@lws04:~/test$ =

--Boundary_(ID_gI7When+Le3S/xm2ak7eiA)
Content-type: text/plain; CHARSET=us-ascii; name=netio_test_shift_5.txt
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=netio_test_shift_5.txt

./netio=20
processor: 0
vendor_id: AuthenticAMD
cpu family: 6
model: 6
model name: AMD Athlon(tm) MP 1800+
stepping: 2
cpu MHz: 1533.680
cache size: 256 KB
fdiv_bug: no
hlt_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 1
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips: 3022.84

processor: 1
vendor_id: AuthenticAMD
cpu family: 6
model: 6
model name: AMD Athlon(tm) Processor
stepping: 2
cpu MHz: 1533.680
cache size: 256 KB
fdiv_bug: no
hlt_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 1
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips: 3063.80

cpu: 1533 MHz

################ to(0x804e000) from(0x886e000) ##############
######################### buffer size (0x2000:8192) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.061 =
seconds at 657.3 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 585.3 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 592.3 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 594.6 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 671.3 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 557.8 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 601.4 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 519.9 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 674.7 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 668.8 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 526.0 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 669.5 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 586.6 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 585.7 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 581.4 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.057 =
seconds at 695.9 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 513.3 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.057 =
seconds at 701.2 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 512.7 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 597.3 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 577.3 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 587.0 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 686.4 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.057 =
seconds at 697.1 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 584.9 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 679.9 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 682.0 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 575.5 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 679.8 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 574.1 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.061 =
seconds at 656.7 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 667.7 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 583.9 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 678.1 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 590.5 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 687.7 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 679.3 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 584.5 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 686.9 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 667.3 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 583.0 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.061 =
seconds at 659.6 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 576.7 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.061 =
seconds at 657.5 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 668.4 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 550.5 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.063 =
seconds at 639.7 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.061 =
seconds at 656.2 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 581.6 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 689.2 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 587.0 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 682.3 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 687.4 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 579.6 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.059 =
seconds at 676.5 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.060 =
seconds at 661.9 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 573.7 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.057 =
seconds at 695.8 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 587.5 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.058 =
seconds at 686.5 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 684.1 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 575.8 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 668.2 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 561.2 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 571.3 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 683.0 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 575.5 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 685.4 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 680.6 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 578.8 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 670.8 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 560.1 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 670.9 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 686.1 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 586.6 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 691.5 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 685.3 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 590.7 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 685.0 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 572.3 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 658.8 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 674.3 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 578.3 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 688.9 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 572.9 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 581.8 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 675.2 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 585.0 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 661.8 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 674.8 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 590.1 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 681.5 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 586.3 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 691.4 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 681.9 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 585.1 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.062 seconds at 648.7 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 677.3 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 585.6 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 680.9 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 583.2 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 677.2 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 684.8 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 574.7 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.061 seconds at 660.5 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 579.0 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.058 seconds at 684.7 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 679.7 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 579.0 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.059 seconds at 677.4 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.060 seconds at 666.1 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 560.5 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.063 seconds at 636.3 Mbytes/sec
######################### buffer size (0x10000:65536) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 492.7 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.088 =
seconds at 454.9 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 520.7 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 517.1 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 500.0 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.086 =
seconds at 465.6 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 529.7 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 522.0 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 520.4 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 589.2 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.076 =
seconds at 524.7 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 494.9 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.089 =
seconds at 450.5 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 583.5 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.089 =
seconds at 451.1 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 506.0 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 520.7 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.067 =
seconds at 598.3 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.088 =
seconds at 456.8 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 513.8 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 499.6 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 588.5 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 510.5 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 592.2 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 590.1 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 506.3 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 573.4 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 568.5 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 504.2 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 558.7 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.071 =
seconds at 562.2 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 496.3 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 494.1 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 557.2 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 493.7 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 494.0 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 572.4 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 580.7 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 496.8 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.071 =
seconds at 562.8 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.070 =
seconds at 572.3 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.081 =
seconds at 491.5 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.071 =
seconds at 560.1 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.071 =
seconds at 564.9 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.082 =
seconds at 487.3 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.083 =
seconds at 482.4 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.073 =
seconds at 544.4 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.072 =
seconds at 553.0 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 498.3 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 575.6 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 578.4 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 507.6 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 590.4 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 584.6 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.079 =
seconds at 505.6 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.080 =
seconds at 502.0 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.069 =
seconds at 575.9 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.078 =
seconds at 513.1 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.077 =
seconds at 516.6 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.068 =
seconds at 590.4 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 511.1 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 510.7 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 587.0 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.080 seconds at 500.6 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 506.5 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 575.5 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.068 seconds at 584.5 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 512.0 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 583.2 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 577.7 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 505.7 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.071 seconds at 565.4 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 571.1 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 508.3 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.070 seconds at 573.4 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.069 seconds at 582.9 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 513.8 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.083 seconds at 481.3 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 551.0 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.075 seconds at 536.9 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.087 seconds at 459.7 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 537.6 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.073 seconds at 545.8 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.085 seconds at 472.7 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.084 seconds at 476.6 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 537.8 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.076 seconds at 529.1 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.086 seconds at 463.5 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.087 seconds at 462.1 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 539.0 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.084 seconds at 476.7 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.084 seconds at 478.8 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 542.3 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.074 seconds at 541.2 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.085 seconds at 471.1 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.085 seconds at 470.1 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 509.1 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.076 seconds at 525.6 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.086 seconds at 462.8 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.087 seconds at 459.5 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 513.0 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.088 seconds at 455.9 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.089 seconds at 450.4 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 511.7 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.080 seconds at 501.8 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.087 seconds at 462.0 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.086 seconds at 463.4 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.076 seconds at 526.4 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.076 seconds at 525.7 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.087 seconds at 460.5 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.088 seconds at 456.8 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.078 seconds at 512.8 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.079 seconds at 505.4 Mbytes/sec
######################### buffer size (0x100000:1048576) =
######################
send/recv(off:0, size:0x800000) send/recv: copied 40.0 Mbytes in 0.246 =
seconds at 162.9 Mbytes/sec
send/recv(off:1, size:0x800000) send/recv: copied 40.0 Mbytes in 0.250 =
seconds at 159.9 Mbytes/sec
send/recv(off:2, size:0x800000) send/recv: copied 40.0 Mbytes in 0.240 =
seconds at 166.6 Mbytes/sec
send/recv(off:3, size:0x800000) send/recv: copied 40.0 Mbytes in 0.240 =
seconds at 166.5 Mbytes/sec
send/recv(off:4, size:0x800000) send/recv: copied 40.0 Mbytes in 0.246 =
seconds at 162.7 Mbytes/sec
send/recv(off:5, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.6 Mbytes/sec
send/recv(off:6, size:0x800000) send/recv: copied 40.0 Mbytes in 0.240 =
seconds at 166.7 Mbytes/sec
send/recv(off:7, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.3 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.9 Mbytes/sec
send/recv(off:8, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.6 Mbytes/sec
send/recv(off:10, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.2 Mbytes/sec
send/recv(off:12, size:0x800000) send/recv: copied 40.0 Mbytes in 0.236 =
seconds at 169.3 Mbytes/sec
send/recv(off:14, size:0x800000) send/recv: copied 40.0 Mbytes in 0.251 =
seconds at 159.5 Mbytes/sec
send/recv(off:16, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.8 Mbytes/sec
send/recv(off:18, size:0x800000) send/recv: copied 40.0 Mbytes in 0.239 =
seconds at 167.6 Mbytes/sec
send/recv(off:20, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.9 Mbytes/sec
send/recv(off:22, size:0x800000) send/recv: copied 40.0 Mbytes in 0.249 =
seconds at 160.7 Mbytes/sec
send/recv(off:24, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.3 Mbytes/sec
send/recv(off:26, size:0x800000) send/recv: copied 40.0 Mbytes in 0.240 =
seconds at 166.9 Mbytes/sec
send/recv(off:28, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 164.2 Mbytes/sec
send/recv(off:30, size:0x800000) send/recv: copied 40.0 Mbytes in 0.250 =
seconds at 160.1 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.234 =
seconds at 170.9 Mbytes/sec
send/recv(off:32, size:0x800000) send/recv: copied 40.0 Mbytes in 0.235 =
seconds at 170.3 Mbytes/sec
send/recv(off:36, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.8 Mbytes/sec
send/recv(off:40, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.9 Mbytes/sec
send/recv(off:44, size:0x800000) send/recv: copied 40.0 Mbytes in 0.234 =
seconds at 170.9 Mbytes/sec
send/recv(off:48, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 164.1 Mbytes/sec
send/recv(off:52, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.2 Mbytes/sec
send/recv(off:56, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.6 Mbytes/sec
send/recv(off:60, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.8 Mbytes/sec
send/recv(off:64, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.7 Mbytes/sec
send/recv(off:68, size:0x800000) send/recv: copied 40.0 Mbytes in 0.235 =
seconds at 170.2 Mbytes/sec
send/recv(off:72, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 172.0 Mbytes/sec
send/recv(off:76, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.9 Mbytes/sec
send/recv(off:80, size:0x800000) send/recv: copied 40.0 Mbytes in 0.231 =
seconds at 173.1 Mbytes/sec
send/recv(off:84, size:0x800000) send/recv: copied 40.0 Mbytes in 0.230 =
seconds at 174.1 Mbytes/sec
send/recv(off:88, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.2 Mbytes/sec
send/recv(off:92, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.5 Mbytes/sec
send/recv(off:96, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.9 Mbytes/sec
send/recv(off:100, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.1 Mbytes/sec
send/recv(off:104, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.2 Mbytes/sec
send/recv(off:108, size:0x800000) send/recv: copied 40.0 Mbytes in 0.231 =
seconds at 172.9 Mbytes/sec
send/recv(off:112, size:0x800000) send/recv: copied 40.0 Mbytes in 0.231 =
seconds at 172.8 Mbytes/sec
send/recv(off:116, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.7 Mbytes/sec
send/recv(off:120, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.4 Mbytes/sec
send/recv(off:124, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.6 Mbytes/sec
send/recv(off:128, size:0x800000) send/recv: copied 40.0 Mbytes in 0.245 =
seconds at 163.2 Mbytes/sec
send/recv(off:896, size:0x800000) send/recv: copied 40.0 Mbytes in 0.245 =
seconds at 163.4 Mbytes/sec
send/recv(off:904, size:0x800000) send/recv: copied 40.0 Mbytes in 0.234 =
seconds at 171.2 Mbytes/sec
send/recv(off:912, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.1 Mbytes/sec
send/recv(off:920, size:0x800000) send/recv: copied 40.0 Mbytes in 0.243 =
seconds at 164.3 Mbytes/sec
send/recv(off:928, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.8 Mbytes/sec
send/recv(off:936, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.9 Mbytes/sec
send/recv(off:944, size:0x800000) send/recv: copied 40.0 Mbytes in 0.241 =
seconds at 166.0 Mbytes/sec
send/recv(off:952, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.4 Mbytes/sec
send/recv(off:960, size:0x800000) send/recv: copied 40.0 Mbytes in 0.234 =
seconds at 170.6 Mbytes/sec
send/recv(off:968, size:0x800000) send/recv: copied 40.0 Mbytes in 0.244 =
seconds at 163.8 Mbytes/sec
send/recv(off:976, size:0x800000) send/recv: copied 40.0 Mbytes in 0.242 =
seconds at 165.0 Mbytes/sec
send/recv(off:984, size:0x800000) send/recv: copied 40.0 Mbytes in 0.232 =
seconds at 172.1 Mbytes/sec
send/recv(off:992, size:0x800000) send/recv: copied 40.0 Mbytes in 0.233 =
seconds at 171.8 Mbytes/sec
send/recv(off:1000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.242 seconds at 165.5 Mbytes/sec
send/recv(off:1008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.233 seconds at 171.9 Mbytes/sec
send/recv(off:1016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.231 seconds at 172.8 Mbytes/sec
send/recv(off:1024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.3 Mbytes/sec
send/recv(off:1032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 163.9 Mbytes/sec
send/recv(off:1040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.238 seconds at 168.3 Mbytes/sec
send/recv(off:1048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.2 Mbytes/sec
send/recv(off:1056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.0 Mbytes/sec
send/recv(off:1064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.261 seconds at 153.4 Mbytes/sec
send/recv(off:1072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.233 seconds at 171.7 Mbytes/sec
send/recv(off:1080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.3 Mbytes/sec
send/recv(off:1088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.1 Mbytes/sec
send/recv(off:1096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.239 seconds at 167.2 Mbytes/sec
send/recv(off:1104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 163.9 Mbytes/sec
send/recv(off:1112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.3 Mbytes/sec
send/recv(off:1120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 170.9 Mbytes/sec
send/recv(off:1128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.233 seconds at 171.5 Mbytes/sec
send/recv(off:1136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.4 Mbytes/sec
send/recv(off:1144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.232 seconds at 172.8 Mbytes/sec
send/recv(off:1152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.3 Mbytes/sec
send/recv(off:3968, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.265 seconds at 151.2 Mbytes/sec
send/recv(off:3976, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.5 Mbytes/sec
send/recv(off:3984, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 171.0 Mbytes/sec
send/recv(off:3992, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 171.1 Mbytes/sec
send/recv(off:4000, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.2 Mbytes/sec
send/recv(off:4008, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 170.7 Mbytes/sec
send/recv(off:4016, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.233 seconds at 172.0 Mbytes/sec
send/recv(off:4024, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.241 seconds at 165.7 Mbytes/sec
send/recv(off:4032, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.246 seconds at 162.7 Mbytes/sec
send/recv(off:4040, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.235 seconds at 170.2 Mbytes/sec
send/recv(off:4048, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.233 seconds at 171.7 Mbytes/sec
send/recv(off:4056, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.6 Mbytes/sec
send/recv(off:4064, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 170.7 Mbytes/sec
send/recv(off:4072, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 170.9 Mbytes/sec
send/recv(off:4080, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.1 Mbytes/sec
send/recv(off:4088, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.6 Mbytes/sec
send/recv(off:4096, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.235 seconds at 169.9 Mbytes/sec
send/recv(off:4104, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.1 Mbytes/sec
send/recv(off:4112, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.5 Mbytes/sec
send/recv(off:4120, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.236 seconds at 169.7 Mbytes/sec
send/recv(off:4128, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.235 seconds at 170.4 Mbytes/sec
send/recv(off:4136, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.3 Mbytes/sec
send/recv(off:4144, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.5 Mbytes/sec
send/recv(off:4152, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.234 seconds at 170.7 Mbytes/sec
send/recv(off:4160, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.3 Mbytes/sec
send/recv(off:4168, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.244 seconds at 164.1 Mbytes/sec
send/recv(off:4176, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.232 seconds at 172.6 Mbytes/sec
send/recv(off:4184, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.237 seconds at 168.4 Mbytes/sec
send/recv(off:4192, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.245 seconds at 163.5 Mbytes/sec
send/recv(off:4200, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.243 seconds at 164.9 Mbytes/sec
send/recv(off:4208, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.232 seconds at 172.1 Mbytes/sec
send/recv(off:4216, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.242 seconds at 165.1 Mbytes/sec
send/recv(off:4224, size:0x800000) send/recv: copied 40.0 Mbytes in =
0.247 seconds at 162.1 Mbytes/sec
steve@lws04:~/test$ =

--Boundary_(ID_gI7When+Le3S/xm2ak7eiA)--
