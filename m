Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270200AbUJTN4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbUJTN4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270126AbUJTNzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:55:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28944 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S270200AbUJTNwQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:52:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stas Sergeev <stsp@aknet.ru>
Subject: X does not start. vm86old returns ENOSYS??
Date: Wed, 20 Oct 2004 16:53:33 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas, all,

I have put my hard drive, which holds working desktop
Linux system, into another box.
Linux starts w/o problem, but X does not.

Video is an i845. Madrake 9 install on the same box
starts X just fine.

I booted into 'my' Linux again, mounted partition
with working Mandrake, chrooted into it, tried to start X.
The same result, does not work.

I tracked problem down to this:

XFree86.0.log:

(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) I810(0): initializing int10
(II) I810(0): Primary V_BIOS segment is: 0xc000
(EE) I810(0): unknown reason for exception
(II) I810(0): EAX=0x00004f00, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
(II) I810(0): ESP=0x00000ffa, EBP=0x00000000, ESI=0x00000000, EDI=0x00002000
(II) I810(0): CS=0x0f96, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000, GS=0x0000
(II) I810(0): EIP=0x00010000, EFLAGS=0x00033282
(II) stack at 0x00001ffa:
 00 06 00 00 00 32
(II) I810(0): code at 0x0000f960:
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
(EE) I810(0): cannot continue

strace.out:

write(0, "Primary V_BIOS segment is: 0xc00"..., 34) = 34
open("/dev/mem", O_RDWR)                = 8
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 8, 0) = 0x4024a000
close(8)                                = 0
open("/dev/cpu/mtrr", O_WRONLY)         = -1 ENOENT (No such file or directory)
open("/proc/mtrr", O_WRONLY)            = 8
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = 0
ioctl(8, MTRRIOC_GET_ENTRY, 0xbffffb10) = -1 EINVAL (Invalid argument)
munmap(0x4024a000, 4096)                = 0
rt_sigprocmask(SIG_BLOCK, [IO], [], 8)  = 0
vm86old(0x850e1b0)                      = -1 ENOSYS (Function not implemented)

	ENOSYS ???!

write(0, "(EE) ", 5)                    = 5
write(2, "I810(0): ", 9)                = 9
write(0, "I810(0): ", 9)                = 9
write(2, "unknown reason for exception\n", 29) = 29
write(0, "unknown reason for exception\n", 29) = 29

I wrote a test prog:

#define __NR_vm86old            113
#define _syscall1(type,name,type1,arg1) \
type name(type1 arg1) \
{ \
long __res; \
__asm__ volatile ("int $0x80" \
        : "=a" (__res) \
        : "0" (__NR_##name),"b" ((long)(arg1))); \
}
_syscall1(int,vm86old,void*,ptr);
int main() {
    vm86old(0);
    return 0;
}

compiled (with dietlibc) and straced it:

execve("./a.out", ["./a.out"], [/* 16 vars */]) = 0
vm86old(0)                              = -1 EFAULT (Bad address)
_exit(0)                                = ?

How can vm86old from X return ENOSYS??
I have no more ideas how to proceed from here.
--
vda
