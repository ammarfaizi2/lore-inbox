Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135738AbRDZRbH>; Thu, 26 Apr 2001 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135761AbRDZRa4>; Thu, 26 Apr 2001 13:30:56 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31502 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S135738AbRDZR3Q>; Thu, 26 Apr 2001 13:29:16 -0400
Date: Thu, 26 Apr 2001 19:26:32 +0200
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        trond.myklebust@fys.uio.no, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.19 NFSv3 client breaks fdopen(3)
Message-ID: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	trond.myklebust@fys.uio.no, Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

SHORT:

the current 2.2.19 fs/nfs/dir.c ll. 455ff. nfs_dir_lseek breaks
fdopen(3) which (at least with glibc 2.1.3) cals __llseek with offset==0
and whence==1 (SEEK_CUR), probably to poll the current file position.
Application software affected comprises cvs (tried 1.10.7) and Perl5
(sysopen, see below).

I suggest that SEEK_CUR be allowed for offset == 0 in nfs_dir_llseek,
but I'm asking for help since I'm not into this and cannot do this on my
own. Thanks in advance.



LONG, with hints and logs:

Symptom: software calls __llseek with SEEK_CUR, offset=0; possibly to
obtain file pointer position on fdopen, and gets EINVAL. This seems to
be a deliberate decision from what I see in fs/nfs/dir.c. I traced what
happens to a simply Perl5 script in gdb, see below.

Regretfully, I cannot try either 2.4.3 (fails to detect sda attached to
aic7xxx) nor 2.4.4-pre6 (does not compile for __builtin_expect) nor
2.4.3-ac14 (pcnet32.c:327: pcnet32_pci_tbl causes a section type
conflict) to see. Using gcc 2.95.2 here.

Solaris 7 clients doing the same user-space operations on the same NFS
server (Linux 2.2.19 knfsd) are fine.

Perl script to test:

sysopen(O, "/net/server/usr/net", O_RDONLY) or die "sysopen failed: $!";
/net/server/usr/net is an automounted NFSv2 or NFSv3 directory

C source to trigger problem, with strace:

#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

main() {
        int fd = open("/net/server/usr/net", O_RDONLY);
        /* again, that's a NFS-imported directory, no matter if NFSv2 or
           v3 */
        if(fd) {
                FILE *f = fdopen(fd, "r");
        }
}

strace, omitting brk:
open("/net/server/usr/net", O_RDONLY)   = 3
fcntl(3, F_GETFL)                       = 0 (flags O_RDONLY)
...
fstat64(3, 0xbffff45c)                  = -1 ENOSYS (Function not implemented)
fstat(3, {st_mode=S_IFDIR|S_ISGID|0755, st_size=2048, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x124000
_llseek(3, 0, 0xbffff4a4, SEEK_CUR)     = -1 EINVAL (Invalid argument)
_exit(0)                                = ?

Stack trace, caught when entering _llseek:

#0  0x1cf665 in __llseek (fd=5, offset=0, whence=1)
    at ../sysdeps/unix/sysv/linux/llseek.c:32
#1  0x17d49b in _IO_file_seek () at fileops.c:671
#2  0x17d3a9 in _IO_new_file_seekoff (fp=0x8049618, offset=0, dir=1, mode=3)
    at fileops.c:652
#3  0x17cbc3 in _IO_new_file_attach (fp=0x8049618, fd=5) at fileops.c:268
#4  0x178f7c in _IO_new_fdopen (fd=5, mode=0x80484dc "r") at iofdopen.c:126
#5  0x804845e in main () at test.c:10

-- 
Matthias Andree
