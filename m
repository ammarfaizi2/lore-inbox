Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUESRXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUESRXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbUESRXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:23:20 -0400
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:14242 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264461AbUESRXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:23:15 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@ds14.agh.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] (1) broken stack? | (2) broken kbuild-out-of-tree?
Date: Wed, 19 May 2004 19:16:48 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Aa5qAa3ZuHG0dO+"
Message-Id: <200405191916.48687.pluto@ds14.agh.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Aa5qAa3ZuHG0dO+
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

i'm a part of the pld-linux (www.pld-linux.org) team,
and i have two problems with 2.6.6 kernel.

1).
kernel + gcc340[-fstack-protector]=20

patches:
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/Attic/kernel-ssp.patch?rev=
=3D1.1.2.2
http://www.trl.ibm.com/projects/security/ssp/
netfilter/iptables snap from 2004/05/18.

testcase:
[root]-[~] # strace -o iptables.log iptables -L
Kernel panic: propolice detects c0521f25 at function <NULL>.

without -fstack-protector `iptables -L` works fine.
is this a hidden kernel/netfilter bug or a gcc bug?
any ideas?

info:
[root]-[~] # uname -a
Linux vmx 2.6.6-grsec #4 (...) i686 Celeron_(Coppermine) unknown PLD Linux


2).
with the 2.6.[4,5] kernel i use a simple loop (in the .spec files) to build
external kernel modules (based on the different configs (eg. -smp, -uni))...

[ eg. nvidia driver ]

cd usr/src/nv/
cp Makefile.kbuild Makefile
for cfg in %{?with_dist_kernel:%{?with_smp:smp} up} \
           %{!?with_dist_kernel:nondist}; do
    if [ ! -r "%{_kernelsrcdir}/config-$cfg" ]; then
        exit 1
    fi
    %{__make} -C %{_kernelsrcdir} mrproper \
=A0 =A0     SUBDIRS=3D$PWD O=3D$PWD V=3D1 \
=A0 =A0     RCS_FIND_IGNORE=3D"-name built -prune o" \
    rm -rf include
    install -d include/{linux,config}
    ln -sf %{_kernelsrcdir}/config-$cfg .config
    ln -sf %{_kernelsrcdir}/include/linux/autoconf-$cfg.h \
           include/linux/autoconf.h
    touch include/config/MARKER
    %{__make} -C %{_kernelsrcdir} modules \
        SUBDIRS=3D$PWD O=3D$PWD V=3D1
    mv nvidia.ko built/nvidia-$cfg.ko
done

loop works with 2.6.[4,5], but it doesn't work
(after s/make mrproper/make clean/) with 2.6.6.

under the 2.6.6:
=2D it doesn't build required scripts outside the kernel's tree.
  (i must add `make basic_scripts)
=2D it doesn't build modpost.
=2D it doesn't build proper modules.
  (for -smp and -uni config it produces modules which have the same md5
   and eg. nvidia's driver freezes my x11(x.org)
   IMO it(kernel's makefile) ignores linked .config).

who and why change kernel's makefile in the 2.6.6 ?

=2D-=20
If you think of MS-DOS as mono, and Windows as stereo,
  then Linux is Dolby Digital and all the music is free...

unofficial PLD(nptl): http://pld-nptl.ds14.agh.edu.pl/

--Boundary-00=_Aa5qAa3ZuHG0dO+
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="iptables.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="iptables.log"

execve("/usr/sbin/iptables", ["iptables", "-L"], [/* 20 vars */]) = 0
uname({sys="Linux", node="vmx", ...})   = 0
brk(0)                                  = 0x805675c
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001c000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60461, ...}) = 0
mmap2(NULL, 60461, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\36\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10004, ...}) = 0
mmap2(NULL, 12936, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002c000
mmap2(0x4002f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2) = 0x4002f000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0<\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=81420, ...}) = 0
mmap2(NULL, 88736, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40030000
mmap2(0x40043000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x13) = 0x40043000
mmap2(0x40044000, 6816, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40044000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1398488, ...}) = 0
mmap2(NULL, 1408588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40046000
mmap2(0x40193000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x14c) = 0x40193000
mmap2(0x4019c000, 7756, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4019c000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4019e000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4019e4f0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x4001d000, 60461)               = 0
socket(PF_INET, SOCK_RAW, IPPROTO_RAW)  = 3
getsockopt(3, SOL_IP, 0x40 /* IP_??? */
--Boundary-00=_Aa5qAa3ZuHG0dO+--
