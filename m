Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266238AbUF0EdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbUF0EdS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUF0EdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 00:33:18 -0400
Received: from relay.pair.com ([209.68.1.20]:516 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266238AbUF0EdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 00:33:04 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <40DE3E95.4070702@kegel.com>
Date: Sat, 26 Jun 2004 20:27:17 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.20 rh9 thrashing unreasonably
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for posting a tuning question on a non-vanilla kernel -
I'll switch to a recent 2.6 vanilla kernel next chance I get.
But just in case this situation sounds familliar to anyone:

I have a zippy little 2GHz Athlon XP with 512 MB RAM running
2.4.20 (as supplied by Red Hat 9) which
normally builds gcc/glibc toolchains very quickly.   However,
when I wrote a script to build 200 different combinations of gcc / glibc / target
one after the other, deleting each one immediately after installing it,
performance mysteriously drops after about the 40th iteration;
the CPU is mostly idle, and the system is swapping like crazy.
It's turning a several day job into a several week job :-(

I see someone else reported a similar problem (http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118397),
and said adjusting a proc setting helped, but they didn't say which one :-(

Any suggestions on tuning the existing kernel before I pitch it?
I'll append the contents of /proc/meminfo etc below.
Thanks!
- Dan

$ uname -a
Linux fast 2.4.20-6 #1 Thu Feb 27 10:01:19 EST 2003 i686 athlon i386 GNU/Linux

$ free
              total       used       free     shared    buffers     cached
Mem:        513852     507464       6388          0       1456       6012
-/+ buffers/cache:     499996      13856
Swap:      1052248      16276    1035972

$ cat meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  526184448 515788800 10395648        0  1277952  8548352
Swap: 1077501952 17084416 1060417536
MemTotal:       513852 kB
MemFree:         10152 kB
MemShared:           0 kB
Buffers:          1248 kB
Cached:           5532 kB
SwapCached:       2816 kB
Active:            972 kB
ActiveAnon:        312 kB
ActiveCache:       660 kB
Inact_dirty:      3944 kB
Inact_laundry:       0 kB
Inact_clean:      4816 kB
Inact_target:     1944 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513852 kB
LowFree:         10152 kB
SwapTotal:     1052248 kB
SwapFree:      1035564 kB

$ vmstat 5
    procs                      memory      swap          io     system      cpu
  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
  0  3  2  52456   6304    876   2080    1    2     9     8    3     4  3  2  2
  0  1  2  52596   6304    824    524 12519  118 12806   129  575  1026  0  3 97
  1  0  2  52596   6396    836    560 10437   74 10864    77  517   921  0  2 98
  0  1  2  52596   6308    804    644 10522   72 10996    75  519   919  0  2 98

$ ps augxw | egrep 'dank|kswapd|bdflush'
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         9  0.0  0.0     0    0 ?        SW   May09   0:27 [bdflush]
root         5  0.0  0.0     0    0 ?        DW   May09  18:57 [kswapd]
dank     21494  0.0  0.0  4144    0 pts/1    SW   14:55   0:00 sh /home/dank/wk/crosstool-0.28-rc26/crosstool.sh
dank     20973  0.0  0.0  3572    0 pts/1    SW   17:54   0:00 make LD=arm-softfloat-linux-gnu-ld RANLIB=arm-softfloat-linux-gnu-ranlib
dank     20974  0.0  0.0  5920    0 pts/1    SW   17:54   0:03 make -r PARALLELMFLAGS= CVSOPTS= -C /home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/gl
ibc-2.3.2 objdir=/home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/build-glibc all
dank     27105  0.9  0.2 46920 1228 pts/1    D    17:58   1:03 make -C iconvdata subdir_lib

... wait a second just to see what's running besides make ...

$ ps augxw | egrep 'dank'
dank     21494  0.0  0.0  4144    0 pts/1    SW   14:55   0:00 sh /home/dank/wk/crosstool-0.28-rc26/crosstool.sh
dank     20973  0.0  0.0  3572    0 pts/1    SW   17:54   0:00 make LD=arm-softfloat-linux-gnu-ld RANLIB=arm-softfloat-linux-gnu-ranlib
dank     20974  0.0  0.0  5920    0 pts/1    SW   17:54   0:03 make -r PARALLELMFLAGS= CVSOPTS= -C /home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/glibc-2.3.2 
objdir=/home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/build-glibc all
dank     29787  3.3  0.1  5100  528 pts/1    S    19:56   0:00 make -C locale subdir_lib
dank     30180  1.0  0.0  4168  412 pts/1    S    19:57   0:00 /bin/sh -c arm-softfloat-linux-gnu-gcc  -M -MP C-ctype.c -std=gnu99 -O -Wall -Winline -Wstrict-prototypes -Wwrite-strings     -DLOCALE_PATH='"/usr/lib/locale:/usr/share/i18n"' 
-DLOCALEDIR='"/usr/lib/locale"' -DLOCALE_ALIAS_PATH='"/usr/share/locale"' -DCHARM
dank     30181  0.0  0.0  1448  140 pts/1    S    19:57   0:00 arm-softfloat-linux-gnu-gcc -M -MP C-ctype.c -std=gnu99 -O -Wall -Winline -Wstrict-prototypes -Wwrite-strings -DLOCALE_PATH="/usr/lib/locale:/usr/share/i18n" 
-DLOCALEDIR="/usr/lib/locale" -DLOCALE_ALIAS_PATH="/usr/share/locale" -DCHARMAP_PATH="/usr/share/i1
dank     30182  5.0  0.3  5308 1676 pts/1    D    19:57   0:00 /opt/crosstool/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/lib/gcc-lib/arm-softfloat-linux-gnu/3.3.3/cc1 -E -quiet -nostdinc -Iprograms -I../include -I. 
-I/home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/build-glibc/lo
dank     30183  0.0  0.0  3560  148 pts/1    S    19:57   0:00 sed -e s,C-ctype\.o,/home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/build-glibc/locale/C-ctype.o 
/home/dank/wk/crosstool-0.28-rc26/build/arm-softfloat-linux-gnu/gcc-3.3.3-glibc-2.3.2/build-glibc/locale/C-ctype.os /home/

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
