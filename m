Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWBMHzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWBMHzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWBMHzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:55:51 -0500
Received: from drugphish.ch ([69.55.226.176]:8864 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751159AbWBMHzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:55:51 -0500
Message-ID: <43F03B7F.2030701@drugphish.ch>
Date: Mon, 13 Feb 2006 08:55:43 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] trap int3 problem while porting a user space application
 and small cleanup patch
References: <43EF6B7D.5080607@drugphish.ch> <200602130157.36084.ak@suse.de>
In-Reply-To: <200602130157.36084.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

Thanks for your comments.

>> The issue I'm trying to track down now is why I cannot get it to work on 
>> a x86_64 kernel (Sun Fire V20z with AMD Opteron(tm) Processor 252 on 
>> SLES 9 PL3). I suspect 32/64 bit issues between in my ioctl message 
>> passing between user space and kernel space.
> 
> Quite possible. The mpt ioctls would need a ioctl conversion handler
> to allow a 32bit program to use the 64bit ioctls. Or just use a 64bit
> executable.

It is a 64bit executable:

ratz@cpp9:~/mpt-status-1.1.5-RC3> readelf -h ./mpt-status | grep 64
ELF Header:
   Class:                             ELF64
   Machine:                           Advanced Micro Devices X86-64
   Start of program headers:          64 (bytes into file)
   Size of this header:               64 (bytes)
   Size of section headers:           64 (bytes)
ratz@cpp9:~/mpt-status-1.1.5-RC3> ldd ./mpt-status
         libc.so.6 => /lib64/tls/libc.so.6 (0x0000002a9566d000)
         /lib64/ld-linux-x86-64.so.2 (0x0000002a95556000)

The strace looks ok with regard to the ioctl though:

cpp9:/home/ratz/mpt-status-1.1.5-RC3 # strace ./mpt-status
execve("./mpt-status", ["./mpt-status"], [/* 44 vars */]) = 0
uname({sys="Linux", node="cpp9", ...})  = 0
brk(0)                                  = 0x503000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x2a9556b000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26878, ...}) = 0
mmap(NULL, 26878, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2a9556c000
close(3)                                = 0
open("/lib64/tls/libc.so.6", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\313\1\0"..., 
640) = 640
lseek(3, 624, SEEK_SET)                 = 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 32) 
= 32
fstat(3, {st_mode=S_IFREG|0755, st_size=1424617, ...}) = 0
mmap(NULL, 2254664, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x2a9566d000
madvise(0x2a9566d000, 2254664, MADV_SEQUENTIAL|0x1) = 0
mprotect(0x2a95778000, 1161032, PROT_NONE) = 0
mmap(0x2a95877000, 102400, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10a000) = 0x2a95877000
mmap(0x2a95890000, 14152, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2a95890000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x2a95894000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x2a95895000
arch_prctl(ARCH_SET_FS, 0x2a95894b00)   = 0
munmap(0x2a9556c000, 26878)             = 0
open("/dev/mptctl", O_RDWR)             = 3
brk(0)                                  = 0x503000
brk(0x526000)                           = 0x526000
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x2a9556c000
write(1, "SGE ptr: 0x7fbfffc144\n", 22SGE ptr: 0x7fbfffc144
) = 22
write(1, "conf ptr: 0x7fbfffc124\n", 23conf ptr: 0x7fbfffc124
) = 23
write(1, "dataSgeOffset: 4\n", 17dataSgeOffset: 4
)      = 17
ioctl(3, 0xc0486d14, 0x7fbfffc0e0)      = 0
ioctl(3, 0xc0486d14, 0x7fbfffc0e0)      = 0
write(1, "\nYou seem to have no SCSI disks "..., 139
You seem to have no SCSI disks attached to your HBA or you have
them on a different scsi_id. To get your SCSI id, run:

     mpt-status -p
) = 139
write(1, "\n", 1
)                       = 1
munmap(0x2a9556c000, 4096)              = 0
exit_group(1)                           = ?

My next steps will involve enabling full debug of the mptctl driver to 
find out where it gets stuck and to sprinkle a few printk's to see if 
the struct's got the wrong size or has been packed wrongly. Even the 
SuSE provided mpt-status (including the patches) does not work correctly 
on this machine. So I reckon I try to get my hands on a SLES support 
contract and/or maybe ping LSIL.

 From the looks of the MPI headers one can see that LSIL carefully 
thought about the 64bit case and thus I'm really astonished it does not 
work.

>> Unfortunately when I strace  
>> the kernel spits out tons of following entries:
> 
> Some kernel versions printed that with strace. I think I fixed it in
> mainline, but I can't remember if it was fixed in SLES9 too (apparently not)
> It's fairly harmless, just ignore it. If it really bothers you you can
> turn it off with echo 0 > /proc/sys/debug/exception-trace

Nice.

> Hmm, ok applied.

:) I know, not exactly fixing anything, just creating more work for you.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
