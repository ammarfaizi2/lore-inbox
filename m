Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUDEKyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUDEKyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:54:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50954 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261292AbUDEKyO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:54:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: 2.6.5: temporary NFS problem when rpciod is SIGKILLed
Date: Mon, 5 Apr 2004 13:47:15 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200404051347.15504.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond, all,

I am using NFS root. At shutdown, when I kill
all processes with killall5 -9, NFS temporarily
misbehaves. I narrowed it down to rpciod feeling
bad when signalled with SIGKILL.

See relevant info below sig.
--
vda

# killall5 -9;ps -AH e;read junk;ps -AH e
bash: /bin/ps: Input/output error
<--- I press [Enter] here
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:05 /bin/sh /init.vda
    2 ?        SWN    0:00   [ksoftirqd/0]
    3 ?        SW<    0:00   [events/0]
    4 ?        SW<    0:00     [kblockd/0]
    5 ?        SW     0:00     [pdflush]
    6 ?        SW     0:00     [pdflush]
    8 ?        SW<    0:00     [aio/0]
    7 ?        SW     0:00   [kswapd0]
   49 ?        SW     0:00   [rpciod]
   50 ?        SW     0:00   [lockd]
  812 vc/2     S      0:00   -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/usr
 1369 tty2     R      0:00     ps -AH e PWD=/app/shutdown-0.0.5/script GROFF_NO_
 1368 ?        S      0:00   sleep 32000
 
# kill -9 49;ps -AH e;read junk;ps -AH e
bash: /bin/ps: Input/output error
<--- I press [Enter] here
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:05 /bin/sh /init.vda
    2 ?        SWN    0:00   [ksoftirqd/0]
    3 ?        SW<    0:00   [events/0]
    4 ?        SW<    0:00     [kblockd/0]
    5 ?        SW     0:00     [pdflush]
    6 ?        SW     0:00     [pdflush]
    8 ?        SW<    0:00     [aio/0]
    7 ?        SW     0:00   [kswapd0]
   49 ?        SW     0:00   [rpciod]
   50 ?        SW     0:00   [lockd]
  812 vc/2     S      0:00   -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/usr
 1369 tty2     R      0:00     ps -AH e PWD=/app/shutdown-0.0.5/script GROFF_NO_
 1368 ?        S      0:00   sleep 32000
 
# cat /proc/mounts
rootfs / rootfs rw 0 0
172.16.42.75:/.rootfs/.std / nfs ro,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=172.16.42.75 0 0
none /dev devfs rw 0 0
none /proc proc rw 0 0
none /sys sysfs rw 0 0
172.16.42.75:/.share /.share nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,nolock,addr=172.16.42.75 0 0
172.16.42.75:/.1 /.1 nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,nolock,addr=172.16.42.75 0 0
172.16.42.75:/.share /.local nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,nolock,addr=172.16.42.75 0 0
automount(pid684) /.local/mnt/auto autofs rw 0 0
/dev/hda1 /.local/mnt/auto/vfat.hda1 vfat rw,noatime,nodiratime,nosuid,noexec,fmask=0022,dmask=0022,codepage=cp866,iocharset=koi8-r,shortname=win95,quiet,uni_xlate 0 0
none /dev/pts devpts rw 0 0

# lsof -nP
COMMAND    PID USER   FD   TYPE DEVICE     SIZE     NODE NAME
init.vda     1 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
init.vda     1 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
init.vda     1 root  txt    REG   0,12   437844    71410 /bin/bash (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12   832636     8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12    14831    47164 /lib/libtermcap.so.2.0.8 (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12    50088     8252 /app/glibc-2.3/lib/libdl-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12 16153080     8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12   312114     8268 /app/glibc-2.3/lib/libnss_compat-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12  1164667     8265 /app/glibc-2.3/lib/libnsl-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root  mem    REG   0,12   360212     8257 /app/glibc-2.3/lib/libnss_files-2.3.so (172.16.42.75:/.rootfs/.std)
init.vda     1 root    3r   REG   0,12      678    65407 /init.vda (172.16.42.75:/.rootfs/.std)
ksoftirqd    2 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
ksoftirqd    2 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
events/0     3 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
events/0     3 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
kblockd/0    4 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
kblockd/0    4 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
pdflush      5 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
pdflush      5 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
pdflush      6 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
pdflush      6 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
kswapd0      7 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
kswapd0      7 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
aio/0        8 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
aio/0        8 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
rpciod      49 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
rpciod      49 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
lockd       50 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
lockd       50 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
bash       812 root  cwd    DIR   0,12     1024    69388 /app/shutdown-0.0.5/script (172.16.42.75:/.rootfs/.std)
bash       812 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
bash       812 root  txt    REG   0,12   437844    71410 /bin/bash (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,12   832636     8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,12    14831    47164 /lib/libtermcap.so.2.0.8 (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,12    50088     8252 /app/glibc-2.3/lib/libdl-2.3.so (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,12 16153080     8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,12   360212     8257 /app/glibc-2.3/lib/libnss_files-2.3.so (172.16.42.75:/.rootfs/.std)
bash       812 root  mem    REG   0,14    15795   619809 /.share/usr/app/samba-2.2.2/lib/libnss_winbind.so (172.16.42.75:/.share)
bash       812 root  mem    REG   0,12  1207520    93906 /app/gcc-3.2/lib/libgcc_s.so.1 (172.16.42.75:/.rootfs/.std)
bash       812 root    0u   CHR    4,2                22 /dev/vc/2
bash       812 root    1u   CHR    4,2                22 /dev/vc/2
bash       812 root    2u   CHR    4,2                22 /dev/vc/2
bash       812 root  255u   CHR    4,2                22 /dev/vc/2
sleep     1368 root  cwd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
sleep     1368 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
sleep     1368 root  txt    REG   0,12     5200    71631 /bin/sleep (172.16.42.75:/.rootfs/.std)
sleep     1368 root  mem    REG   0,12   832636     8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
sleep     1368 root  mem    REG   0,12    69355     8254 /app/glibc-2.3/lib/libcrypt-2.3.so (172.16.42.75:/.rootfs/.std)
sleep     1368 root  mem    REG   0,12 16153080     8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
lsof      1376 root  cwd    DIR   0,12     1024    69388 /app/shutdown-0.0.5/script (172.16.42.75:/.rootfs/.std)
lsof      1376 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
lsof      1376 root  txt    REG   0,14    87748   572607 /.share/usr/app/lsof-4.57/bin/lsof (172.16.42.75:/.share)
lsof      1376 root  mem    REG   0,12   832636     8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
lsof      1376 root  mem    REG   0,12 16153080     8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
lsof      1376 root    0u   CHR    4,2                22 /dev/vc/2
lsof      1376 root    1w   REG   0,14     1484   309496 /.local/var/KILLbug (172.16.42.75:/.share)
lsof      1376 root    2w   REG   0,14     1484   309496 /.local/var/KILLbug (172.16.42.75:/.share)
lsof      1376 root    3r   DIR    0,3        0        1 /proc
lsof      1376 root    4r   DIR    0,3        0 90177545 /proc/1376/fd
lsof      1376 root    5w  FIFO    0,7              4192 pipe
lsof      1376 root    6r  FIFO    0,7              4193 pipe
lsof      1377 root  cwd    DIR   0,12     1024    69388 /app/shutdown-0.0.5/script (172.16.42.75:/.rootfs/.std)
lsof      1377 root  rtd    DIR   0,12     1024    65282 / (172.16.42.75:/.rootfs/.std)
lsof      1377 root  txt    REG   0,14    87748   572607 /.share/usr/app/lsof-4.57/bin/lsof (172.16.42.75:/.share)
lsof      1377 root  mem    REG   0,12   832636     8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
lsof      1377 root  mem    REG   0,12 16153080     8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
lsof      1377 root    4r  FIFO    0,7              4192 pipe
lsof      1377 root    7w  FIFO    0,7              4193 pipe

