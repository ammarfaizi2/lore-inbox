Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRASUmr>; Fri, 19 Jan 2001 15:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135432AbRASUmg>; Fri, 19 Jan 2001 15:42:36 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:12541 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S131353AbRASUmX>; Fri, 19 Jan 2001 15:42:23 -0500
Message-ID: <3A68A7D0.FF534B97@att.net>
Date: Fri, 19 Jan 2001 15:47:12 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: select() on TCP socket sleeps for 1 tick even if data available
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] select() sleeps for 1 tick even if data available
[2.] Full description of the problem/report:
	If select() is waiting for data to become available on a TCP socket FD,
and
	data becomes available, it doesn't return until the next clock tick.
This
	produces large latencies when passing data between processes several
times,
	since each transaction (which requires microseconds) does not occur
until
	the next clock tick, limiting the entire throughput of the system to
100
	transactions/second.
[3.] Keywords: select, socket, networking
[4.] Kernel version (from /proc/version): 2.2.18
[5.] Output of Oops.. message (not applicable)
[6.] A small shell script or example program which triggers the
     problem (if possible)

	#include <sys/time.h>
	#include <sys/types.h>
	#include <unistd.h>

	/* this program should take 1 second to complete, but takes 10 */
	/* yes i know, it doesn't do any I/O, but the behavior is the
		same as if it did */
	main()
	{
	        for (int i = 0; i < 1000; i++) {
			struct timeval to;
			to.tv_sec = 0;
			to.tv_usec = 1000;
			select(0, 0, 0, 0, &to);
		}
		return 0;
	}

[7.] Environment
	Red Hat 7.0 with kernel upgraded to 2.2.18

[7.1.] Software (add the output of the ver_linux script here)
	ver_linux di dnot appear to work. However, here's its output.

Linux mlindner-ras.sonusnet.com 2.2.18 #8 Wed Jan 3 01:40:29 EST 2001
i586 unknown
Kernel modules         found
Gnu C                  2.96
Binutils               2.10.0.18
Linux C Library        ..
ldd: missing file arguments
Try `ldd --help' for more information.
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.7
Mount                  2.10m
Net-tools              (2000-05-21)
Kbd                    [option...]
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.033
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 897.84

[7.3.] Module information (from /proc/modules): N/A
[7.4.] SCSI information (from /proc/scsi/scsi) N/A
[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
