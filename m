Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265518AbTFMUJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265519AbTFMUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:09:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9352 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265518AbTFMUJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:09:35 -0400
Date: Fri, 13 Jun 2003 13:12:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 803] New: System crash with heavy NFS load
Message-ID: <23800000.1055535131@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=803

           Summary: System crash with heavy NFS load
    Kernel Version: 2.5.70
            Status: NEW
          Severity: high
             Owner: rml@tech9.net
         Submitter: robbiew@us.ibm.com


Distribution: SuSE 8.0

Hardware Environment:
---------------------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.199
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1384.44

# cat /proc/meminfo
MemTotal:      4325580 kB
MemFree:       3239332 kB
Buffers:        615592 kB
Cached:         316972 kB
SwapCached:          0 kB
Active:          95640 kB
Inactive:       852508 kB
HighTotal:     3465188 kB
HighFree:      3129856 kB
LowTotal:       860392 kB
LowFree:        109476 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
Dirty:            1868 kB
Writeback:           0 kB
Mapped:          21368 kB
Slab:            59364 kB
Committed_AS:    31852 kB
PageTables:        452 kB
VmallocTotal:   114680 kB
VmallocUsed:      2240 kB
VmallocChunk:   112440 kB

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda3              25G  4.5G   19G  19% /
/dev/sda1              23M   11M   10M  50% /boot
/dev/sdb1              33G  642M   31G   2% /nfsserver/ext3
/dev/sdc1              34G   96M   33G   1% /nfsserver/jfs
/dev/sdd1              34G  245M   33G   1% /nfsserver/reiserfs
---------------------

Software Environment:
---------------------
2 kernel patches applied from BugMe #780 and BugMe #796

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
nfs-utils              1.0.3
No Modules Loaded
--------------------

Problem Description: 
While running an intensive NFS test (see http://ltp.sf.net/nfs) I was able to 
create the following kernel crash on the server.  
===================
Call Trace:
 [<c01163f5>] schedule+0x2d/0x454
 [<c0123fe8>] schedule_timeout+0xa4/0xc4
 [<c0123f34>] process_timeout+0x0/0x10
 [<c010bb48>] die+0x1a4/0x1b8
 [<c010bd5c>] do_invalid_op+0x0/0x8c
 [<c010bdd9>] do_invalid_op+0x7d/0x8c
 [<c0144585>] check_highmem_ptes+0x41/0x5c
 [<c0116835>] default_wake_function+0x19/0x20
 [<c0116872>] __wake_up_common+0x36/0x50
 [<c011691b>] __wake_up+0x8f/0xf8
 [<c010b4cd>] error_code+0x2d/0x38
 [<c0144585>] check_highmem_ptes+0x41/0x5c
===================
The above section loops continuously with differences only seen in the first 
line:
 [<c01.....>] schedule+0x../0x454
-------------------

Steps to reproduce:

I modified the setup described in the NFS testplan to simply have the NFS 
server act as a client and mount from itself.  This eliminated any possible 
ethernet driver and physical networking problems.  Then I ran the test scenario 
described in the NFS plan to itself...causing the crash above within minutes.  
It is also reproducible.


