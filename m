Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSLTLwz>; Fri, 20 Dec 2002 06:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSLTLwz>; Fri, 20 Dec 2002 06:52:55 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:49599 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S261544AbSLTLwx>; Fri, 20 Dec 2002 06:52:53 -0500
Date: Fri, 20 Dec 2002 12:48:37 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021220114837.GC13591@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Right now we're trying to implement a large scale Squid proxy on
Debian/testing. We're using 2.4.20-aa and Squid-2.4.7-1.

We're encountering sporadic crashes of the squid children (SIGSEGV,
signal 11). We were investigating in several directions:

* the Kernel has highmem support enabled (we have 2GB RAM and 4 GB swap)

* we tried different kernels (with or without highmem support)

* we tried another squid version (Squid-2.4.6 from the "stable"
  distribution of Debian)

* We recompiled Squid using gcc-3.2, since -- according to the FAQ --
  squid may crash with signal 11 with optimization enabled when using
  gcc-2.95.4 (Debian uses gcc-2.95.4, but still build squid using -O!)

* we closely observed dmesg, messages and syslog. No oddities were
  found. Squid simply crashes.

* we tried both ufs and aufs as cache filesystems, since the FAQ tells
  us the async I/O may have bugs.

* We use two identical machines -- the crash happens on both machines.
  Same CPU, disks, RAM, manufacturer, heck -- even the same series!
  
To no avail -- Squid simply crashes from time to time. It's
impossible to predict when.

Then we wrote a program which allocates large amounts of memory:

--- snip ---
#include <stdlib.h>
#include <stdio.h>

main(){
  char *buf;
  long c;
  FILE *fp;

  fp = fopen("/dev/null","a");
  while(1){
    buf = (char *)malloc(100000000);
    c = random();
    if (c > 100000000)
      continue;
    fprintf(fp,"%c",buf[c]);
    printf("hier\n");
  }
}
--- snip ---

And we found that this program will be killed with a SIGSEGV as well.

So, what are we doing wrong? Since we have 2GB RAM and 4GB swap,
shouldn't the machine start to swap and execute the program above
successfully?

# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  2119065600 2111709184  7356416        0   299008 1438240768
Swap: 4293509120        0 4293509120
MemTotal:      2069400 kB
MemFree:          7184 kB
MemShared:           0 kB
Buffers:           292 kB
Cached:        1404532 kB
SwapCached:          0 kB
Active:         387796 kB
Inactive:      1317064 kB
HighTotal:     1703872 kB
HighFree:         2960 kB
LowTotal:       365528 kB
LowFree:          4224 kB
SwapTotal:     4192880 kB
SwapFree:      4192880 kB
BigFree:             0 kB

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2785.629
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5557.45

# cat /proc/swaps   
Filename                        Type            Size    Used    Priority
/dev/sda6                       partition       2096440 0       -1
/dev/sda7                       partition       2096440 0       -2

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
I've got the perfect system.  I never need to do maintenance on it, or
software upgrades, patches, or anything.  It's great.  It never wakes me up,
or gets hacked into.  It's completely perfect.  That was the first step in
my plan to build the perfect Postfix system. 
The second step is to plug it in. 

