Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264467AbRFLOAM>; Tue, 12 Jun 2001 10:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRFLOAD>; Tue, 12 Jun 2001 10:00:03 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:48092 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264467AbRFLN7r>; Tue, 12 Jun 2001 09:59:47 -0400
Date: Tue, 12 Jun 2001 14:59:12 +0100 (BST)
From: Jeremy Sanders <jss@ast.cam.ac.uk>
To: <linux-kernel@vger.kernel.org>
cc: <rsync-bugs@samba.org>
Subject: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting numerous rsync (v2.4.6) problems under Linux 2.4.2 (RedHat
7.1) or stock 2.4.4 on several machines. rsync often hangs copying files
from NFS or local disks to local disks. Strangely the problem is fixed by
stracing one of the three rsync threads!

I've encountered the problem just rsyncing the linux 2.4.4 kernel source
tree to a new (blank) directory.

rsync -raxv /data/jss/sysadmin/linux-2.4.4/linux .

The problem is repeatable with this source tree (which includes binaries)
on several machines (one PII machine and an Athlon). The problem also
exists copying the stock Linux 2.4.5 source tree (download it to reproduce
the problem). It hangs on linux/scripts/ver_linux in that case.

For example:

xpc6:~> rsync -raxv /data/jss/sysadmin/linux-2.4.4/linux /tmp/kernel/
[....]
linux/scripts/tkparse.c
linux/scripts/tkparse.h
linux/scripts/ver_linux
linux/vmlinux
[hangs here, for at least several hours]

(switch to another window)
xpc6:~> ps auxw|grep rsync
jss       3165 10.9  1.7  3144 2272 pts/0    S    14:20   0:19 rsync -raxv
/data/jss/sysadmin/linux-2.4.4/linux .
jss       3166  1.1  1.7  3128 2216 pts/0    S    14:20   0:02 rsync -raxv
/data/jss/sysadmin/linux-2.4.4/linux .
jss       3167 10.4  1.7  3136 2236 pts/0    S    14:20   0:18 rsync -raxv
/data/jss/sysadmin/linux-2.4.4/linux .

xpc6:~> su
[blah]
[root@xpc6 jss]# strace -p 3165
select(0, NULL, NULL, NULL, {0, 10000}) = 0 (Timeout)
gettimeofday({992352238, 401281}, NULL) = 0
wait4(3166, 0xbfffdd80, WNOHANG, NULL)  = 0
gettimeofday({992352238, 401846}, NULL) = 0
gettimeofday({992352238, 402088}, NULL) = 0
select(0, NULL, NULL, NULL, {0, 20000}) = 0 (Timeout)
gettimeofday({992352238, 420838}, NULL) = 0
select(0, NULL, NULL, NULL, {0, 2000})  = 0 (Timeout)
gettimeofday({992352238, 431066}, NULL) = 0
wait4(3166, 0xbfffdd80, WNOHANG, NULL)  = 0
gettimeofday({992352238, 431568}, NULL) = 0
gettimeofday({992352238, 431809}, NULL) = 0
select(0, NULL, NULL, NULL, {0, 20000}) = 0 (Timeout)
[lots more of these]

[root@xpc6 jss]# strace -p 3166
  [program starts working again]
select(2, NULL, [1], NULL, {17, 860000}) = 1 (out [1], left {17, 830000})
write(1, "\27\0\0\tlinux/arch/ia64/sn/io/\n", 27) = 27
select(6, [3 5], NULL, NULL, {60, 0})   = 1 (in [5], left {60, 0})
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
read(5, "\30\0\0\t", 4)                 = 4
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
read(5, "linux/arch/ia64/sn/sn1/\n", 24) = 24
select(2, NULL, [1], NULL, {60, 0})     = 1 (out [1], left {60, 0})
write(1, "\30\0\0\tlinux/arch/ia64/sn/sn1/\n", 28) = 28
select(6, [3 5], NULL, NULL, {60, 0})   = 1 (in [5], left {60, 0})
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
read(5, "\32\0\0\t", 4)                 = 4
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
read(5, "linux/arch/ia64/sn/tools/\n", 26) = 26
select(2, NULL, [1], NULL, {60, 0})     = 1 (out [1], left {60, 0})
write(1, "\32\0\0\tlinux/arch/ia64/sn/tools/\n", 30) = 30
select(6, [3 5], NULL, NULL, {60, 0})   = 1 (in [5], left {60, 0})
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
read(5, "\27\0\0\t", 4)                 = 4
select(6, [5], NULL, NULL, {60, 0})     = 1 (in [5], left {60, 0})
[lots more]
[program finishes]

Has anyone else encountered this problem? Is it a kernel problem or an
rsync problem?

Please CC answers to me, as I'm not on linux-kernel.

Jeremy

-- 
Jeremy Sanders <jss@ast.cam.ac.uk>  http://www-xray.ast.cam.ac.uk/~jss/
Pembroke College, Cambridge. UK   Institute of Astronomy, Cambridge. UK



