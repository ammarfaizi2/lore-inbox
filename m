Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTEHW4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTEHW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:56:35 -0400
Received: from 193-153-110-76.uc.nombres.ttd.es ([193.153.110.76]:53405 "EHLO
	dardhal.mired.net") by vger.kernel.org with ESMTP id S262231AbTEHWya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:54:30 -0400
Date: Fri, 9 May 2003 01:06:56 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Subject: [BUG] [2.4.20] Adding drive to degraded RAID1 array hangs
Message-ID: <20030508230656.GA7178@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Doing some tests with software RAID in Linux I have had a problem when
trying to re-add a formerly (manually) failed and then removed drive
from a two-disk software RAID1 (mirror). Be warned that the problem
occurred with a kernel tainted by VMware's binary modules. I have tried
to reproduce the problem again with and without those modules loaded,
but these times everything worked as expected.

* Base configuration
- Vanilla Linux kernel version 2.4.20 plus XFS patches applied and
  compiled XFS as a module, but not loaded
- raidtools2 version 1.00.3-2 (Debian Sid)
- mdadm version 1.2.0-1  (Debian Sid)


* RAID configuration (raidtools2 format)

raiddev /dev/md0
    raid-level 1
    nr-raid-disks  2
    nr-spare-disks 0
    chunk-size     4
    
    device /dev/Grupo00/Crecimiento
    raid-disk 0

    device /dev/Grupo00/Suplemento
    raid-disk 1

lvscan -- ACTIVE            "/dev/Grupo00/Crecimiento" [224 MB]
lvscan -- ACTIVE            "/dev/Grupo00/Suplemento" [224 MB]

--- Volume group ---
VG Name               Grupo00
VG Access             read/write
VG Status             available/resizable

Partition Table for /dev/hdc (only PV in VG is /dev/hdc2)
            First    Last
 # Type     Sector   Sector   Offset  Length   Filesystem Type (ID)
 # Flags
-- ------- -------- --------- ------ --------- -------------------------------
 1 Primary        0  6136829      63  6136830  HPFS/NTFS (07) None (00)
 2 Primary  6136830 12659219       0  6522390  Linux LVM (8E) None (00)


* Steps leading to the problem

1. Create the array (using either mdadm or mkraid)
  mdadm --create /dev/md0 --chunk=4 --level=1 --raid-devices=2 \
      /dev/Grupo00/Crecimiento /dev/Grupo00/Suplemento
  mkraid /dev/md0 (using the /etc/raidtab show above)
2. Create a filesystem on the RAID1 device and mount it somewhere
  mke2fs /dev/md0 ; mount -t ext2 /dev/md0 /mnt/tests
3. Populate it with some data
  cp -Rvp /etc/ /mnt/tests
4. Check array reconstruction is over (/proc/mdstat)

...and now for the real problem...

5. Generate some I/O load on the device
  while :; do ls -lR /mnt/tests ; done

6. Fail one of the devices (works OK, as seen on /proc/mdstat)
  mdadm --manage /dev/md0 --fail /dev/Grupo00/Crecimiento
Personalities : [raid1] 
read_ahead 1024 sectors
md0 : active raid1 Grupo00/Suplemento[1]
      229312 blocks [2/1] [_U]

7. Remove the failed device from the array (works OK)
  mdadm --manage /dev/md0 --remove /dev/Grupo00/Crecimiento

8. Shortly afterwards, re-add the same device to the same array (fails)
  mdadm --manage /dev/md0 --add /dev/Grupo00/Crecimiento

The process hangs: "ps" shows the following:
1     0 15251     1  -1 -20     0    0 ?      SW<  ?          0:00 [raid1d]
4     0 16885 14558   9   0  1248  300 rwsem_ D    pts/2      0:00 mdadm --manage /dev/md0 --add /dev/Grupo00/Crecimiento

"mdadm" gets blocked waiting for data at "rwsem_down_read_failed". A
subsequent attempt to access the RAID device fails. For example:
  mdadm --misc --detail /dev/md0
gives us a process...
4     0 17586 16933   9   0  1252  300 down_i S    pts/1      0:00 mdadm --misc --detail /dev/md0
... that never ends "blocked" in down_interruptible


Via "SysRq+T" we get a listing of processes and their stacks, that
feeded through "ksymoops" gives us the following _complete_ dump:

ksymoops 2.4.8 on i686 2.4.20-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-xfs/ (default)
     -m /boot/System.map-2.4.20-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

FFC8  5604     7      1             8     6 (L-TLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c0133e3c>] [<c0105578>]
kjournald     S 00000282  5136     8      1            60     7 (L-TLB)
Call Trace:    [<c011231d>] [<c015ffa9>] [<c015fe60>] [<c0105578>]
mdrecoveryd   S CF396000  5816    60      1           295     8 (L-TLB)
Call Trace:    [<d087f29b>] [<c0105578>]
syslog-ng     R CEE1DF28  5696   295      1           303    60 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
named         S CEC8BFB0  5984   303      1   304     381   295 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
named         S CFEB5F28     0   304    303   307               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0112026>]
  [<c0106c27>]
named         S CEDFBFB0     0   305    304           306       (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
named         S CEE75F88     0   306    304           307   305 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
named         S 7FFFFFFF     0   307    304                 306 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
_plutorun     S 00000000     0   380      1   383     452   381 (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
logger        S CE924000   784   381      1           380   303 (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
_plutorun     S 00000000  1216   382    380   386     383       (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
_plutoload    S CE9E2000     0   383    380                 382 (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
pluto         S CEA73F2C     0   386    382   420               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
_pluto_adns   S 7FFFFFFF     0   420    386                     (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
cupsd         S CE6C3F2C     0   452      1           488   380 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
inetd         S 7FFFFFFF     0   488      1           492   452 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
lpd           S 7FFFFFFF  5748   492      1           500   488 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
nagios        S CE4A5F88     0   500      1           508   492 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
pure-ftpd     S 7FFFFFFF     0   508      1           512   500 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>] [<c01ae976>]
  [<c01263b9>] [<c01265ae>] [<c0152944>] [<c0130dd4>] [<c01af3cc>] [<c0106c27>]
qmail-send    S CE219F2C     0   512      1   521     517   508 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
tcpserver     S 7FFFFFFF  5288   516      1           524   517 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>] [<c01ae976>]
  [<c0111004>] [<c012ace3>] [<c012acfe>] [<c0116a96>] [<c01af3cc>] [<c0106c27>]
splogger      S CE206000     0   517      1           516   512 (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
splogger      S CE202000     4   518    512           519       (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
qmail-lspawn  S 7FFFFFFF     0   519    512           520   518 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
qmail-rspawn  S 7FFFFFFF     0   520    512           521   519 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
qmail-clean   S CE4BE000     0   521    512                 520 (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
nmbd          S CDF6FF2C  4684   524      1           526   516 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
smbd          S 7FFFFFFF  5296   526      1           533   524 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
sshd          S 7FFFFFFF  5748   533      1           555   526 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
usb_perms     S CDBE3F88     0   555      1           559   533 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
atd           S CDACBF88  5748   559      1           562   555 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
cron          S CDAA3F88  6004   562      1           585   559 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
vmnet-bridge  S CD9A4000   448   585      1           852   562 (NOTLB)
Call Trace:    [<c010b83e>] [<c0106c27>]
bash          S 7FFFFFFF  5252   852      1   870     853   585 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
bash          S 7FFFFFFF     0   853      1           854   852 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
getty         S 7FFFFFFF     4   854      1           855   853 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
getty         S 7FFFFFFF    96   855      1           856   854 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
getty         S 7FFFFFFF     0   856      1           857   855 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
getty         S 7FFFFFFF     8   857      1           858   856 (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
svscanboot    S 00000000     0   858      1   861     958   857 (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
svscan        S CD527F88  5252   860    858           861       (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
readproctitle S CD50E000  5492   861    858                 860 (NOTLB)
Call Trace:    [<c01379dc>] [<c0137ab3>] [<c01301e6>] [<c0106c27>]
startx        S 00000000  5280   870    852   881               (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
xinit         S 00000000  5252   881    870   885               (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
XFree86       S CD1F5F2C     0   882    881           885       (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
sh            S 00000000     0   885    881   911           882 (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
ssh-agent     S 7FFFFFFF     0   910    885           911       (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
blackbox      S CC9DBF2C     0   911    885   921           910 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
xterm         S 7FFFFFFF     0   913    911   914     917       (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
bash          S 7FFFFFFF  5504   914    913   925               (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
xterm         S 7FFFFFFF     0   917    911   918     921   913 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
bash          S 00000000  5504   918    917 16933               (NOTLB)
Call Trace:    [<c01784e8>] [<c011767e>] [<c0106c27>]
xterm         S 7FFFFFFF     0   921    911   922           917 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
bash          S 00000000  5504   922    921 14558               (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
gkrellm       S CC1F9F28  4924   925    914 16962               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
xchat         S CB8BFF28     0   958      1   959    2463   858 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
xchat         S CB36BF28     4   959    958   960               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0112026>]
  [<c0106c27>]
xchat         S 7FFFFFFF     4   960    959                     (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
apache        S C9AABF2C  2660  2463      1  6231     816   958 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
apache        S 7FFFFFFF    48  2469   2463          2470       (NOTLB)
Call Trace:    [<c0111c9f>] [<c01cb4af>] [<c01cbba3>] [<c01e3b75>] [<c01adf51>]
  [<c01ae05e>] [<c01301e6>] [<c0106c27>]
apache        S 7FFFFFFF     0  2470   2463          2471  2469 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>] [<c01ae976>]
  [<c014182c>] [<c011d3a7>] [<c01af3cc>] [<c0106c27>]
apache        S 7FFFFFFF     0  2471   2463          2472  2470 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01b5d9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>]
  [<c01ae976>] [<c012b113>] [<c0122922>] [<c0122cb9>] [<c01af3cc>] [<c0106c27>]
apache        S 7FFFFFFF     0  2472   2463          2473  2471 (NOTLB)
Call Trace:    [<c01c5d56>] [<c0111c9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>]
  [<c01ae976>] [<c0111004>] [<c014182c>] [<c011d3a7>] [<c01af3cc>] [<c0106d18>]
  [<c0106c27>]
apache        S 7FFFFFFF     0  2473   2463         30041  2472 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01b5d9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>]
  [<c01ae976>] [<c012b113>] [<c0122922>] [<c0122cb9>] [<c01af3cc>] [<c0106c27>]
apache        S 7FFFFFFF     0 30041   2463          6231  2473 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01cb4af>] [<c01cbba3>] [<c01e3b75>] [<c01adf51>]
  [<c01ae05e>] [<c01301e6>] [<c0106c27>]
run-mozilla.s S 00000000     0   816      1   822    6844  2463 (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
mozilla-bin   S 7FFFFFFF     0   822    816  7205               (NOTLB)
Call Trace:    [<c0111c9f>] [<c013da39>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
mozilla-bin   S CDD85F28  2656   824    822  7223    7205       (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c01184aa>]
  [<c0106c27>]
mozilla-bin   S 7FFFFFFF     0   825    824           826       (NOTLB)
Call Trace:    [<c0111c9f>] [<c013da39>] [<c013da6e>] [<c013dc6d>] [<c01af474>]
  [<c0106c27>]
mozilla-bin   S CB87FFB0  5596   826    824           827   825 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
mozilla-bin   S CB895F88  5540   827    824           828   826 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
mozilla-bin   S CADCDFB0     0   828    824          7222   827 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
apache        S 7FFFFFFF     0  6231   2463               30041 (NOTLB)
Call Trace:    [<c01c5d56>] [<c0111c9f>] [<c01ccb80>] [<c01ccc9e>] [<c01e39bc>]
  [<c01ae976>] [<c0111004>] [<c014182c>] [<c011d3a7>] [<c01af3cc>] [<c0106d18>]
  [<c0106c27>]
mysqld_safe   S 00000000     0  6844      1  6885   15251   816 (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
mysqld        S 7FFFFFFF  1632  6885   6844  6886               (NOTLB)
Call Trace:    [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
mysqld        S C63FFF28   264  6886   6885  6896               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c01176a3>]
  [<c0106c27>]
mysqld        S C61F5FB0   360  6887   6886          6888       (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
mysqld        S C4B4DFB0     0  6888   6886          6896  6887 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
mysqld        S 7FFFFFFF     0  6896   6886                6888 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01eb01e>] [<c01eb1f1>] [<c01adf51>] [<c01ae05e>]
  [<c01301e6>] [<c0106c27>]
java_vm       S 7FFFFFFF     0  7205    822  7206           824 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01eb01e>] [<c01eb1f1>] [<c01adf51>] [<c01ae05e>]
  [<c01301e6>] [<c0106c27>]
java_vm       S C4701F28  2656  7206   7205  7227               (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c01176a3>]
  [<c0106c27>]
java_vm       S C4713F88  2656  7207   7206          7208       (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
java_vm       S C46F9FB0     0  7208   7206          7209  7207 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C4609FB0     0  7209   7206          7211  7208 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C412FF88  2656  7211   7206          7212  7209 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
java_vm       S C413BFB0     0  7212   7206          7213  7211 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C40DFFB0     0  7213   7206          7214  7212 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C40E3FB0  2656  7214   7206          7217  7213 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C16EDF28  2656  7217   7206          7218  7214 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
java_vm       S C51E5FB0     0  7218   7206          7219  7217 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S C6E75F88  6316  7219   7206          7221  7218 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
java_vm       S CB265F88     0  7221   7206          7224  7219 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
mozilla-bin   S 7FFFFFFF     0  7222    824          7223   828 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013da39>] [<c013da6e>] [<c013dc6d>] [<c0106132>]
  [<c0106c27>]
mozilla-bin   S 7FFFFFFF     0  7223    824                7222 (NOTLB)
Call Trace:    [<c0111c9f>] [<c013da39>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
java_vm       S 7FFFFFFF     0  7224   7206          7226  7221 (NOTLB)
Call Trace:    [<c0111c9f>] [<c01eb01e>] [<c01eb1f1>] [<c01adf51>] [<c01ae05e>]
  [<c01301e6>] [<c0106c27>]
java_vm       S C3935FB0     0  7226   7206          7227  7224 (NOTLB)
Call Trace:    [<c0105e07>] [<c0106c27>]
java_vm       S CF0C5F88     0  7227   7206                7226 (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c011b976>] [<c0106c27>]
bash          S 00000000     0 14558    922 16885               (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
raid1d        S CE87C000   832 15251      1                6844 (L-TLB)
Call Trace:    [<d087f29b>] [<c0105578>]
mdadm         D C31B1E84  2656 16885  14558                     (NOTLB)
Call Trace:    [<c01ef265>] [<c0134f1e>] [<d087c728>] [<d087e618>] [<d087f073>]
  [<c0135c80>] [<c013c8b9>] [<c0106c27>]
bash          S 7FFFFFFF     0 16933    918 17111               (NOTLB)
Call Trace:    [<c0111c9f>] [<c017abbd>] [<c0176b38>] [<c01301e6>] [<c0106c27>]
sh            S 00000000     0 16962    925 16963               (NOTLB)
Call Trace:    [<c011767e>] [<c0106c27>]
rxvt          S 7FFFFFFF     0 16963  16962 16964               (NOTLB)
Call Trace:    [<c017b20f>] [<c0111c9f>] [<c013d461>] [<c013d7ea>] [<c0106c27>]
mutt          S C6099F28  5208 16964  16963                     (NOTLB)
Call Trace:    [<c0111cfb>] [<c0111c40>] [<c013da6e>] [<c013dc6d>] [<c0106c27>]
man           T CB6C2200     0 17111  16933 17116               (NOTLB)
Call Trace:    [<c0106a7b>] [<c01176a3>] [<c0106c60>]
sh            T C25916E0    68 17116  17111 17121               (NOTLB)
Call Trace:    [<c0106a7b>] [<c01176a3>] [<c0106c60>]
pager         T CF4006E0     0 17121  17116                     (NOTLB)
Call Trace:    [<c0106a7b>] [<c011d3a7>] [<c0106c60>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  FFC8

>>EIP; 00000604 Before first symbol   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c0133e3c <kupdate+74/100>
Trace; c0105578 <kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000282 Before first symbol   <=====

Trace; c011231d <interruptible_sleep_on+3d/60>
Trace; c015ffa9 <kjournald+139/1c0>
Trace; c015fe60 <commit_timeout+0/c>
Trace; c0105578 <kernel_thread+28/38>
Proc;  mdrecoveryd

>>EIP; cf396000 <_end+f06d757/1050f7b7>   <=====

Trace; d087f29b <[md]md_thread+cf/144>
Trace; c0105578 <kernel_thread+28/38>
Proc;  syslog-ng

>>EIP; cee1df28 <_end+eaf567f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  named

>>EIP; cec8bfb0 <_end+e963707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  named

>>EIP; cfeb5f28 <_end+fb8d67f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0112026 <schedule+2fa/324>
Trace; c0106c27 <system_call+33/38>
Proc;  named

>>EIP; cedfbfb0 <_end+ead3707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  named

>>EIP; cee75f88 <_end+eb4d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  named

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  _plutorun

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  logger

>>EIP; ce924000 <_end+e5fb757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  _plutorun

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  _plutoload

>>EIP; ce9e2000 <_end+e6b9757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  pluto

>>EIP; cea73f2c <_end+e74b683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  _pluto_adns

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  cupsd

>>EIP; ce6c3f2c <_end+e39b683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  inetd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  lpd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  nagios

>>EIP; ce4a5f88 <_end+e17d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  pure-ftpd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c01263b9 <generic_file_write_nolock+521/6d8>
Trace; c01265ae <generic_file_write+3e/54>
Trace; c0152944 <ext3_release_file+14/1c>
Trace; c0130dd4 <fput+bc/e0>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106c27 <system_call+33/38>
Proc;  qmail-send

>>EIP; ce219f2c <_end+def1683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  tcpserver

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c0111004 <do_page_fault+0/480>
Trace; c012ace3 <__free_pages+1b/1c>
Trace; c012acfe <free_pages+1a/1c>
Trace; c0116a96 <release_task+156/16c>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106c27 <system_call+33/38>
Proc;  splogger

>>EIP; ce206000 <_end+dedd757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  splogger

>>EIP; ce202000 <_end+ded9757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  qmail-lspawn

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  qmail-rspawn

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  qmail-clean

>>EIP; ce4be000 <_end+e195757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  nmbd

>>EIP; cdf6ff2c <_end+dc47683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  smbd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  usb_perms

>>EIP; cdbe3f88 <_end+d8bb6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  atd

>>EIP; cdacbf88 <_end+d7a36df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  cron

>>EIP; cdaa3f88 <_end+d77b6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  vmnet-bridge

>>EIP; cd9a4000 <_end+d67b757/1050f7b7>   <=====

Trace; c010b83e <sys_pause+12/18>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  svscanboot

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  svscan

>>EIP; cd527f88 <_end+d1ff6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  readproctitle

>>EIP; cd50e000 <_end+d1e5757/1050f7b7>   <=====

Trace; c01379dc <pipe_wait+7c/a4>
Trace; c0137ab3 <pipe_read+af/1fc>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  startx

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  xinit

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  XFree86

>>EIP; cd1f5f2c <_end+cecd683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  sh

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  ssh-agent

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  blackbox

>>EIP; cc9dbf2c <_end+c6b3683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  xterm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  xterm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c01784e8 <tty_ioctl+274/38c>
Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  xterm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  gkrellm

>>EIP; cc1f9f28 <_end+bed167f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  xchat

>>EIP; cb8bff28 <_end+b59767f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  xchat

>>EIP; cb36bf28 <_end+b04367f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0112026 <schedule+2fa/324>
Trace; c0106c27 <system_call+33/38>
Proc;  xchat

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; c9aabf2c <_end+9783683/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01cb4af <tcp_data_wait+e3/13c>
Trace; c01cbba3 <tcp_recvmsg+487/84c>
Trace; c01e3b75 <inet_recvmsg+3d/54>
Trace; c01adf51 <sock_recvmsg+3d/bc>
Trace; c01ae05e <sock_read+8e/9c>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c014182c <destroy_inode+40/48>
Trace; c011d3a7 <sys_rt_sigaction+9f/144>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01b5d9f <.text.lock.dev+5c/ed>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c012b113 <free_page_and_swap_cache+33/38>
Trace; c0122922 <unmap_fixup+62/138>
Trace; c0122cb9 <do_munmap+22d/23c>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c01c5d56 <ip_queue_xmit+39e/4e8>
Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c0111004 <do_page_fault+0/480>
Trace; c014182c <destroy_inode+40/48>
Trace; c011d3a7 <sys_rt_sigaction+9f/144>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106d18 <error_code+34/3c>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01b5d9f <.text.lock.dev+5c/ed>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c012b113 <free_page_and_swap_cache+33/38>
Trace; c0122922 <unmap_fixup+62/138>
Trace; c0122cb9 <do_munmap+22d/23c>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01cb4af <tcp_data_wait+e3/13c>
Trace; c01cbba3 <tcp_recvmsg+487/84c>
Trace; c01e3b75 <inet_recvmsg+3d/54>
Trace; c01adf51 <sock_recvmsg+3d/bc>
Trace; c01ae05e <sock_read+8e/9c>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  run-mozilla.s

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013da39 <do_poll+85/dc>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; cdd85f28 <_end+da5d67f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c01184aa <do_softirq+5a/a4>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013da39 <do_poll+85/dc>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c01af474 <sys_socketcall+15c/200>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; cb87ffb0 <_end+b557707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; cb895f88 <_end+b56d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; cadcdfb0 <_end+aaa5707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c01c5d56 <ip_queue_xmit+39e/4e8>
Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01ccb80 <wait_for_connect+e8/180>
Trace; c01ccc9e <tcp_accept+86/198>
Trace; c01e39bc <inet_accept+30/130>
Trace; c01ae976 <sys_accept+66/fc>
Trace; c0111004 <do_page_fault+0/480>
Trace; c014182c <destroy_inode+40/48>
Trace; c011d3a7 <sys_rt_sigaction+9f/144>
Trace; c01af3cc <sys_socketcall+b4/200>
Trace; c0106d18 <error_code+34/3c>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld_safe

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld

>>EIP; c63fff28 <_end+60d767f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c01176a3 <sys_wait4+383/390>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld

>>EIP; c61f5fb0 <_end+5ecd707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld

>>EIP; c4b4dfb0 <_end+4825707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  mysqld

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01eb01e <unix_stream_data_wait+ae/e4>
Trace; c01eb1f1 <unix_stream_recvmsg+19d/37c>
Trace; c01adf51 <sock_recvmsg+3d/bc>
Trace; c01ae05e <sock_read+8e/9c>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01eb01e <unix_stream_data_wait+ae/e4>
Trace; c01eb1f1 <unix_stream_recvmsg+19d/37c>
Trace; c01adf51 <sock_recvmsg+3d/bc>
Trace; c01ae05e <sock_read+8e/9c>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c4701f28 <_end+43d967f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c01176a3 <sys_wait4+383/390>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c4713f88 <_end+43eb6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c46f9fb0 <_end+43d1707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c4609fb0 <_end+42e1707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c412ff88 <_end+3e076df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c413bfb0 <_end+3e13707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c40dffb0 <_end+3db7707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c40e3fb0 <_end+3dbb707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c16edf28 <_end+13c567f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c51e5fb0 <_end+4ebd707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c6e75f88 <_end+6b4d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; cb265f88 <_end+af3d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013da39 <do_poll+85/dc>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106132 <sys_sigreturn+b6/e4>
Trace; c0106c27 <system_call+33/38>
Proc;  mozilla-bin

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013da39 <do_poll+85/dc>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c01eb01e <unix_stream_data_wait+ae/e4>
Trace; c01eb1f1 <unix_stream_recvmsg+19d/37c>
Trace; c01adf51 <sock_recvmsg+3d/bc>
Trace; c01ae05e <sock_read+8e/9c>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; c3935fb0 <_end+360d707/1050f7b7>   <=====

Trace; c0105e07 <sys_rt_sigsuspend+e3/100>
Trace; c0106c27 <system_call+33/38>
Proc;  java_vm

>>EIP; cf0c5f88 <_end+ed9d6df/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c011b976 <sys_nanosleep+116/1f0>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  raid1d

>>EIP; ce87c000 <_end+e553757/1050f7b7>   <=====

Trace; d087f29b <[md]md_thread+cf/144>
Trace; c0105578 <kernel_thread+28/38>
Proc;  mdadm

>>EIP; c31b1e84 <_end+2e895db/1050f7b7>   <=====

Trace; c01ef265 <rwsem_down_read_failed+105/128>
Trace; c0134f1e <.text.lock.super+91/e3>
Trace; d087c728 <[md]md_import_device+70/25c>
Trace; d087e618 <[md]hot_add_disk+d8/2b0>
Trace; d087f073 <[md]md_ioctl+6eb/7e4>
Trace; c0135c80 <blkdev_ioctl+28/34>
Trace; c013c8b9 <sys_ioctl+25d/274>
Trace; c0106c27 <system_call+33/38>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c0111c9f <schedule_timeout+17/94>
Trace; c017abbd <read_chan+3b9/700>
Trace; c0176b38 <tty_read+b0/d0>
Trace; c01301e6 <sys_read+96/f0>
Trace; c0106c27 <system_call+33/38>
Proc;  sh

>>EIP; 00000000 Before first symbol

Trace; c011767e <sys_wait4+35e/390>
Trace; c0106c27 <system_call+33/38>
Proc;  rxvt

>>EIP; 7fffffff Before first symbol   <=====

Trace; c017b20f <normal_poll+103/11f>
Trace; c0111c9f <schedule_timeout+17/94>
Trace; c013d461 <do_select+19d/1dc>
Trace; c013d7ea <sys_select+322/464>
Trace; c0106c27 <system_call+33/38>
Proc;  mutt

>>EIP; c6099f28 <_end+5d7167f/1050f7b7>   <=====

Trace; c0111cfb <schedule_timeout+73/94>
Trace; c0111c40 <process_timeout+0/48>
Trace; c013da6e <do_poll+ba/dc>
Trace; c013dc6d <sys_poll+1dd/2f0>
Trace; c0106c27 <system_call+33/38>
Proc;  man

>>EIP; cb6c2200 <_end+b399957/1050f7b7>   <=====

Trace; c0106a7b <do_signal+1c3/24c>
Trace; c01176a3 <sys_wait4+383/390>
Trace; c0106c60 <signal_return+14/18>
Proc;  sh

>>EIP; c25916e0 <_end+2268e37/1050f7b7>   <=====

Trace; c0106a7b <do_signal+1c3/24c>
Trace; c01176a3 <sys_wait4+383/390>
Trace; c0106c60 <signal_return+14/18>
Proc;  pager

>>EIP; cf4006e0 <_end+f0d7e37/1050f7b7>   <=====

Trace; c0106a7b <do_signal+1c3/24c>
Trace; c011d3a7 <sys_rt_sigaction+9f/144>
Trace; c0106c60 <signal_return+14/18>


2 warnings issued.  Results may not be reliable.


Trying to reboot the box, the device cannot be unmounted, and during
runlevel 6, at "sending all processes the TERM signal...", the console
shows the followin message:
md: ioctl lock interrupted, reason -4, cmd -2142762735

SysRq+S cannot sync the device, neither SysRq+U works, and the box is
rebooted via SysRq+B. During startup, the messages from RAID
initialization are show on the console:
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
 [events: 00000003]
 [events: 00000005]
md: autorun ...
md: considering Grupo00/Suplemento ...
md:  adding Grupo00/Suplemento ...
md:  adding Grupo00/Crecimiento ...
md: created md0
md: bind<Grupo00/Crecimiento,1>
md: bind<Grupo00/Suplemento,2>
md: running: <Grupo00/Suplemento><Grupo00/Crecimiento>
md: Grupo00/Suplemento's event counter: 00000005
md: Grupo00/Crecimiento's event counter: 00000003
md: superblock update time inconsistency -- using the most recent one
md: freshest: Grupo00/Suplemento
md: kicking non-fresh Grupo00/Crecimiento from array!
md: unbind<Grupo00/Crecimiento,1>
md: export_rdev(Grupo00/Crecimiento)
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md: raid1 personality registered as nr 3
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device Grupo00/Suplemento operational as mirror 1
raid1: md0, not all disks are operational -- trying to recover array
raid1: raid set md0 active with 1 out of 2 mirrors
md: updating md0 RAID superblock on device
md: Grupo00/Suplemento [events: 00000006]<6>(write) Grupo00/Suplemento's
sb offs
et: 229312
md: recovery thread got woken up ...
md0: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: ... autorun DONE.


The array starts in degraded mode, but with no other apparent problems
so far. Trying to add the drive to the array now works OK, both with and
without heavy I/O to the array, and both with and without VMware binary
modeles loaded.


As previously said, I could not reproduce the bug more times, but if
there is more information needed or would like me to do some tests,
please ask.

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.5.68)
