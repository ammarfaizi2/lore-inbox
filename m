Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTAWJKV>; Thu, 23 Jan 2003 04:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTAWJKV>; Thu, 23 Jan 2003 04:10:21 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:41151 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S265058AbTAWJKU>; Thu, 23 Jan 2003 04:10:20 -0500
Message-ID: <00e201c2c2c0$838954c0$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>
References: <E18bd5l-000Duj-00@f16.mail.ru>
Subject: Strong kernel lock with linux-2.5.59 : futex in Huge Pages
Date: Thu, 23 Jan 2003 10:19:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I found a way to lock a linux-2.5.59 in all cases, in using futexes landing
in a HugeTLB page.

You need to be root to be able to obtain HugePages (or CAP_IPC_LOCK
capability)

I suspect that the kernel/futex.c:__pin_page(unsigned long addr) or
mm/memory.c:follow_page() are not HugeTLB page aware.

How you can reproduce it. (dont do it of course, unless you really want to
debug the thing)

# grep TLB .config
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLBFS=y

# mount -t hugetlbfs none /huge
# echo 10 > /proc/sys/vm/nr_hugepages
# ./prog
Before futex() call
*********** HANG *********

# cat prog.c

#include <sys/mman.h>
#include <asm/unistd.h>
#include <errno.h>
#ifndef __NR_futex
#define __NR_futex 240
#endif
_syscall4(int, futex, unsigned long, uaddr, int, op, int, val, struct
timespec *,utime)
res = futex((unsigned long)ptr, /*FUTEX_WAIT*/0, 3, 0) ;

main(int argc, char *argv[])
{
int res ;
int fd = open("/huge/futex_bug", O_RDWR | O_CREAT, 0644) ;
char *ptr ;
if (fd == -1) { perror("/huge/futex_bug") ; exit(1);}
ptr = mmap(0x30000000, 4*1024*1024, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd,
0) ;
if (ptr == -1) { perror("mmap") ; exit(1);}
*(int *)ptr = 2 ; /* init the futex with value 2 */
printf("Before futex() call\n") ;
res = futex((unsigned long)ptr, /*FUTEX_WAIT*/0, 3, 0) ;
printf("futex->%d errno=%d\n", res, errno) ;
}

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 801.570
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1585.15


Thanks

Eric Dumazet

