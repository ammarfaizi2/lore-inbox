Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281724AbRKQLwD>; Sat, 17 Nov 2001 06:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281725AbRKQLvo>; Sat, 17 Nov 2001 06:51:44 -0500
Received: from smtp.jadedirect.com ([143.96.9.53]:6405 "EHLO
	cnwchcm6.cnw.co.nz") by vger.kernel.org with ESMTP
	id <S281724AbRKQLvk>; Sat, 17 Nov 2001 06:51:40 -0500
Message-ID: <00e801c16f5e$3319eab0$9681608f@cnw.co.nz>
From: "Matthew Gregan" <mgregan@jade.co.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Alpha XLT 366 fails to boot kernel >= 2.4.14
Date: Sun, 18 Nov 2001 00:51:31 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Alpha XLT 366 fails to boot kernels 2.4.14 and higher - the problem
appears to be related to the cpu_hz struct added in (I think)
2.4.14-pre8 or detection of the CPU (EV5, EV56, etc.)

Linux 2.4.12 boots fine - one thing I have noticed is that the bogomips
have doubled since 2.2.19, not that it should matter...

Booting 2.4.15-pre5 (generic, I have some other problems with an alcor
specific kernel) the machine freezes during bogomips calculation -
before that is an error about HWRPB being bogus and failing to guess a
usable value.

The 2.2.19 (alcor) kernel detects the machine as:
Booting on Alcor using machine vector Alcor from MILO

cat /proc/cpuinfo under 2.2.19 gives:
cpu                     : Alpha
cpu model               : EV5
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : Alcor
system variation        : 0
system revision         : 0
system serial number    : MILO-0000
cycle frequency [Hz]    : 0
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 362.80
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : N/A
cpus detected           : 0

The cpu_hz struct in arch/alpha/kernel/time.c lists the EV5 as being
between 266 and 333 MHz. The CPU in this box is 366 MHz.

So... either this machine is being misdetected as an EV5 when it's an
EV56, or there really _are_ 366MHz EV5s, and cpu_hz needs fixing.

I have attached a patch to fix cpu_hz, which gets the machine booting
with 2.4.15-pre5.

I also have some other problems with an alcor specific kernel, in the
form of lots of machine checks on boot, but I have not investigated that
yet.

diff -ru linux-2.4.15-pre5.orig/arch/alpha/kernel/time.c
linux-2.4.15-pre5/arch/alpha/kernel/time.c
--- linux-2.4.15-pre5.orig/arch/alpha/kernel/time.c     Sun Nov 18
00:17:55 2001
+++ linux-2.4.15-pre5/arch/alpha/kernel/time.c  Sun Nov 18 00:16:32 2001
@@ -186,7 +186,7 @@
                [EV4_CPU]    = {  150000000,  300000000 },
                [LCA4_CPU]   = {  150000000,  300000000 },      /* guess
*/
                [EV45_CPU]   = {  200000000,  300000000 },
-               [EV5_CPU]    = {  266000000,  333333333 },
+               [EV5_CPU]    = {  266000000,  366000000 },
                [EV56_CPU]   = {  366000000,  667000000 },
                [PCA56_CPU]  = {  400000000,  600000000 },      /* guess
*/
                [PCA57_CPU]  = {  500000000,  600000000 },      /* guess
*/

--
Matthew Gregan                                     Operations Consultant
JADE Direct Central Systems                            NZ: 0 800 65 2266
Aoraki Corporation Limited                             AU: 1 800 12 0181
PO Box 20-152, Christchurch 8005                     Cell: +64 2977 8839
New Zealand                                           Fax: +64 3358 7156

