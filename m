Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbVGAONc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbVGAONc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVGAONc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:13:32 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:2231 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263356AbVGAONV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:13:21 -0400
Date: Fri, 1 Jul 2005 16:13:20 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6 mm->total_vm accounting imbalance?
Message-ID: <20050701141320.GA6692@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that mm->vm_total is decreased too many times and wraps below
zero:

$ cat /proc/16736/status
Name:   XFree86
State:  S (sleeping)
SleepAVG:       98%
Tgid:   16736
Pid:    16736
PPid:   16735
TracerPid:      0
Uid:    916     0       0       0
Gid:    1500    0       0       0
FDSize: 256
Groups: 1500 
VmSize: 4294966376 kB			<==
VmLck:         0 kB
VmRSS:     30996 kB
VmData: 4294960304 kB			<==
VmStk:        88 kB
VmExe:      1512 kB
VmLib:      1584 kB
VmPTE:       176 kB
Threads:        1
SigQ:   0/8180
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000010000000
SigIgn: 8000000000301000
SigCgt: 00000000418066cb
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff
$ cat /proc/16736/maps  
000a0000-000c0000 rwxs 000a0000 08:02 502100     /dev/mem
000f0000-00100000 r-xs 000f0000 08:02 502100     /dev/mem
08048000-081c2000 r-xp 00000000 08:02 598142     /usr/X11R6/bin/XFree86
081c2000-081f3000 rwxp 00179000 08:02 598142     /usr/X11R6/bin/XFree86
081f3000-0906b000 rwxp 081f3000 00:00 0          [heap]
aecb4000-aecb6000 rwxp aecb4000 00:00 0 
aed27000-aed29000 rwxp aee7c000 00:00 0 
aed5e000-aed60000 rwxp afb4c000 00:00 0 
aed98000-aed9a000 rwxp aed98000 00:00 0 
aedd1000-aedd3000 rwxp aedd1000 00:00 0 
aee0a000-aee0c000 rwxp aee0a000 00:00 0 
aee43000-aee45000 rwxp aee43000 00:00 0 
aee7d000-aee7f000 rwxp aed5f000 00:00 0 
aeeb4000-aeeb6000 rwxp aeeb5000 00:00 0 
aeeee000-aef4e000 rwxs 00000000 00:07 2654229    /SYSV00000000 (deleted)
aef4e000-aef51000 rwxs 00000000 00:07 2621460    /SYSV00000000 (deleted)
aef51000-af452000 rwxp aef51000 00:00 0 
af452000-af4b2000 rwxs 00000000 00:07 2588691    /SYSV00000000 (deleted)
af4b2000-af9b3000 rwxp af4b2000 00:00 0 
af9d8000-afa38000 rwxs 00000000 00:07 2555922    /SYSV00000000 (deleted)
afa38000-afa98000 rwxs 00000000 00:07 2523153    /SYSV00000000 (deleted)
afa98000-afaf8000 rwxs 00000000 00:07 2490384    /SYSV00000000 (deleted)
afb13000-afb15000 rwxp afb13000 00:00 0 
afb85000-afbe5000 rwxs 00000000 00:07 2457614    /SYSV00000000 (deleted)
afbe5000-afc45000 rwxs 00000000 00:07 2424845    /SYSV00000000 (deleted)
afc45000-afc7e000 rwxp afd29000 00:00 0 
afc7e000-afcb7000 rwxp afd29000 00:00 0 
afcb7000-afcf0000 rwxp afd29000 00:00 0 
afcf0000-afd29000 rwxp afd29000 00:00 0 
afd60000-b7d50000 rwxs d0000000 08:02 502100     /dev/mem
b7d50000-b7d60000 rwxs dfde0000 08:02 502100     /dev/mem
b7d60000-b7e00000 rwxp b7d60000 00:00 0 
b7e00000-b7f2a000 r-xp 00000000 08:02 259908     /lib/tls/libc-2.3.2.so
b7f2a000-b7f33000 rwxp 00129000 08:02 259908     /lib/tls/libc-2.3.2.so
b7f33000-b7f35000 rwxp b7f33000 00:00 0 
b7f35000-b7f3d000 r-xp 00000000 08:02 258997     /lib/libgcc_s.so.1
b7f3d000-b7f3e000 rwxp 00007000 08:02 258997     /lib/libgcc_s.so.1
b7f3e000-b7f40000 r-xp 00000000 08:02 259910     /lib/tls/libdl-2.3.2.so
b7f40000-b7f41000 rwxp 00002000 08:02 259910     /lib/tls/libdl-2.3.2.so
b7f41000-b7f62000 r-xp 00000000 08:02 259911     /lib/tls/libm-2.3.2.so
b7f62000-b7f63000 rwxp 00020000 08:02 259911     /lib/tls/libm-2.3.2.so
b7f63000-b7f64000 rwxp b7f63000 00:00 0 
b7f64000-b7f75000 r-xp 00000000 08:02 674545     /usr/lib/libz.so.1.2.2
b7f75000-b7f76000 rwxp 00010000 08:02 674545     /usr/lib/libz.so.1.2.2
b7f8c000-b7f8d000 rwxp b7f8c000 00:00 0 
b7f8d000-b7fa3000 r-xp 00000000 08:02 258972     /lib/ld-2.3.2.so
b7fa3000-b7fa4000 rwxp 00015000 08:02 258972     /lib/ld-2.3.2.so
bfd8d000-bfda3000 rwxp bfd8d000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

-- 
Frank
