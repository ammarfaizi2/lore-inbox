Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRASJjq>; Fri, 19 Jan 2001 04:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRASJj0>; Fri, 19 Jan 2001 04:39:26 -0500
Received: from eugate.sgi.com ([192.48.160.10]:50201 "EHLO yog-sothoth.sgi.com")
	by vger.kernel.org with ESMTP id <S129652AbRASJjO>;
	Fri, 19 Jan 2001 04:39:14 -0500
Message-ID: <3A67FA33.25F188E0@sgi.com>
Date: Fri, 19 Jan 2001 09:26:27 +0100
From: Dag Bakke <dagb@sgi.com>
Organization: Silicon Graphics, Inc.
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Inconsistent cache size reporting.?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed something strange about the L1/L2 cache size reporting in the
2.4.0 kernel which could need a little explanation. 

It looks as if /proc/cpuinfo reports the L2 cache size on a PII, while it
reports the L1 cache size on a K6-2. 

Either that, or my external L2 cache is 64kB, and not 512 as it is supposed
to be. memtest86 reports 'cacheable memory' to be 128MB, which is according
to spec. I can verify with lmbench that I *have* a l2 cache, by switching it
on/off in bios. (Larry: any chance of detecting/measuring l2 cache size?)



My friend's system reports:

dmesg:
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 01

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 350.799
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat
pse36 mmx fxsr
bogomips        : 699.59


My own system reports:

dmesg:
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.121
cache size      : 64 KB         <-------????
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 999.42


I also note that performance on this system isn't quite what I would expect
it to be. compiling glibc 2.1.3 takes longer time on my system than on a
PII-366.
A Celeron 300 outperforms the K6 when running 'mpeg2dec -o null'. Is the K6-2
really this bad? Or is it my memory latency/bandwidth which is hurting me?

lmbench data. Notice that the 2nd run is with external cache switched off.
Kernel is 2.4.0-ac6.

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
dagb      Linux 2.4.0-a   93   56   41     89    272     73     73  272   103
dagb      Linux 2.4.0-a   54   38   28     59    270     79     80  270   112

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
dagb      Linux 2.4.0-a   501 3.996    133    235
dagb      Linux 2.4.0-a   501 3.996    233    238    No L2 cache?



Regards,

Dag B
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
