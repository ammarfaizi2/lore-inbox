Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbTCTDi0>; Wed, 19 Mar 2003 22:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbTCTDi0>; Wed, 19 Mar 2003 22:38:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53151 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261308AbTCTDiU>; Wed, 19 Mar 2003 22:38:20 -0500
Date: Wed, 19 Mar 2003 19:49:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 475] New: Cannot NFS mount from localhost 
Message-ID: <1850000.1048132156@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=475

           Summary: Cannot NFS mount from localhost
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: robbiew@us.ibm.com


Distribution: SuSE 8.0 and SuSE 8.1
Hardware Environment:
---------------------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 863.771
cache size      : 256 KB
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
bogomips        : 1708.03

 # cat /proc/meminfo
MemTotal:       252924 kB
MemFree:        176060 kB
Buffers:          2540 kB
Cached:          36276 kB
SwapCached:          0 kB
Active:          34700 kB
Inactive:        16764 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       252924 kB
LowFree:        176060 kB
SwapTotal:      530104 kB
SwapFree:       530104 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          24696 kB
Slab:             6396 kB
Committed_AS:    35624 kB
PageTables:        436 kB
ReverseMaps:      9997
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2              27G  3.2G   22G  13% /
# mount
/dev/hda2 on / type ext2 (rw,mand)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw)
----------------------


Software Environment:
---------------------
# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux volare 2.5.65 #1 Wed Mar 19 17:12:47 CST 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11z
mount                  2.11z
module-init-tools      implemented
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
Modules Loaded

# rpcinfo -p
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100003    2   udp   2049  nfs
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100024    1   udp  32770  status
    100024    1   tcp  32768  status
    100005    1   udp  32771  mountd
    100005    1   tcp  32769  mountd
    100005    2   udp  32771  mountd
    100005    2   tcp  32769  mountd
    100005    3   udp  32771  mountd
    100005    3   tcp  32769  mountd

# exportfs
/server         <world>

---------------------

Problem Description: In 2.5.65, I cannot NFS mount filesystems that are 
exported from myself....this works in 2.4.21-pre5. I receive the following 
message when I attempt the mount:
.........
# mount -o "vers=2,proto=udp,soft,intr,rw" localhost:/server /mnt
mount: wrong fs type, bad option, bad superblock on localhost:/server,
       or too many mounted file systems
.........

I also see the following messages logged in dmesg:
.........
nfs: server localhost not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
.........

I did some preliminary code tracing, and it looks like the changes in the 
sunrpc code has something to do with this.  What's even stranger, is that it 
only fails when mounting from yourself.  Mount requests from other clients to 
this same box are granted. Also, the box is able to mount from other NFS 
servers.

---------------------

Steps to reproduce:

1) NFS export a filesystem
2) NFS mount your exported filesystem on the same box

