Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLRWY2>; Mon, 18 Dec 2000 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130369AbQLRWYT>; Mon, 18 Dec 2000 17:24:19 -0500
Received: from [151.38.19.212] ([151.38.19.212]:31135 "HELO beetle.codewiz.org")
	by vger.kernel.org with SMTP id <S129772AbQLRWYF>;
	Mon, 18 Dec 2000 17:24:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bernardo Innocenti <bernie@codewiz.org>
Reply-To: bernie@codewiz.org
Organization: CodeWiz
To: LKML <linux-kernel@vger.kernel.org>
Subject: PROBLEM: mounting affs over loop hangs in syscall (x86 only?)
Date: Mon, 18 Dec 2000 22:53:19 +0100
X-Mailer: KMail [version 1.2]
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Hans-Joachim Widmaier <hjw@zvw.de>,
        "Erik I.Bolsø" <eriki@himolde.no>
MIME-Version: 1.0
Message-Id: <00121822531900.23280@beetle>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
mounting affs over loop hangs in syscall (x86 only?)

[2.] Full description of the problem/report:
Mounting a valid Amiga Fast File System hard disk image used
to work fine even on x86 (endianity discords with m68k) back
in 2.2.x.

On 2.4.0-test11 (and possibily previous versions as well), this
command hangs forever:

 mount -t affs -o loop work.img /mnt

The mount process hangs in uninterruptable syscall:

 # ps ax | grep mount
 3904 pts/4    DL     0:00 mount -t affs -o loop work.img /mnt

Reading directly from /proc/3904/stat:

3904 (mount) D 1398 3904 1398 34820 3904 256 16 0 119 0 0 5 0 \
0 9 0 0 0 43136018 1396736 341 4294967295 134512640 134568236 \
3221223064 3221222424 1074833310 524294 2147220207 0 0 \
3222489067 0 0 17 0

After this, other program can still do open("work.img" ,"r"), but
UAE hanged like mount when accessing the file (perhaps it tried
an mmap() on it?):

 # ps ax | grep uae
 8048 pts/1    D      0:00 ./uae


I recall trying to mount an affs image some months ago (2.3.xx) and
having the very same problem, so it's not a recently introduced bug.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, filesystems, amiga, affs, loop, mount, partition

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test12 (root@beetle) (gcc version 2.96 20000731 \
(Red Hat Linux 7.0)) #2 Wed Dec 13 00:24:27 CET 2000


[5.] Output of Oops.. message
No OOPSes are printed, no useful debug messages appear in
dmesg output.

[6.] A small shell script or example program which triggers the
     problem (if possible)

 Get an Amiga Fast File System image. If you don't have one handy,
you can create a file of a few MBs and use UAE to format it.
Amiga floppy disk images (.adf files) might trigger the problem
too (untested).

 Then use this command to mount it:

 mount -t affs -o loop my_amiga_hd.img /mnt


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
mount: mount-2.10r

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 700.050
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.92

[7.3.] Module information (from /proc/modules):
affs                   31472   1
loop                    7840   2
emu10k1                43456   1
soundcore               3824   4 [emu10k1]
r128                  147920   1
vmnet                  18240   3
vmmon                  18480   0
ipt_REJECT              2080   6 (autoclean)
iptable_filter          1824   0 (autoclean) (unused)
ip_nat_ftp              3184   0 (unused)
ip_conntrack_ftp        2016   0 (unused)
iptable_nat            12864   1 [ip_nat_ftp]
ip_conntrack           12800   2 [ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              10304   5 [ipt_REJECT iptable_filter iptable_nat]
8139too                15392   1
agpgart                13328   3
af_packet              11200   2 (autoclean)
ppp_async               6352   1
ppp_generic            12928   3 [ppp_async]
slhc                    5040   0 [ppp_generic]
autofs4                 9824   2
ne2k-pci                4672   1 (autoclean)
8390                    6080   0 (autoclean) [ne2k-pci]
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                   11408   1 (autoclean)
fat                    31264   0 (autoclean) [vfat]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
not relevant

[7.5.] PCI information ('lspci -vvv' as root)
not relevant

[7.6.] SCSI information (from /proc/scsi/scsi)
not relevant

[7.7.] Other information that might be relevant to the problem
no mount points are added to /proc/mounts before the syscall
hangs.


NOTE: when replying to this message, please also Cc: to me,
as I'm not subscribed to this mailing list.

ALSO NOTE: I'm willing to cooperate with whoever wants to
fix this bug. I'll give all the assistance I can, including
running debug versions of kernel modules, providing the
FFS images that trigger the problem and giving shell access
to my system for deeper inspection.

-- 
  // Bernardo Innocenti
\X/  http://www.codewiz.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
