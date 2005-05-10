Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVEJFXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVEJFXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 01:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEJFXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 01:23:30 -0400
Received: from web40909.mail.yahoo.com ([66.218.78.206]:20861 "HELO
	web40909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261561AbVEJFXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 01:23:12 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=qXM3je53V2+tVUtwOAQTAcuogg38KXbLii14sLB736XDJR+VlDXVzvYZcjQm1R8jZ+4TksEvvPP65+Oxi4pDguj+N6fVRoYC8IrjeT3qFho+WaRt/DVYEfwZgKo8jduSxvZX6tQXwHp1beaHDvULLfoFOktzz7FW7dJliZdbW+0=  ;
Message-ID: <20050510052311.93996.qmail@web40909.mail.yahoo.com>
Date: Mon, 9 May 2005 22:23:11 -0700 (PDT)
From: jensen galan <jrgalan@yahoo.com>
Subject: Adding a system call to kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am trying to add a system call to a 2.4 kernel. 
It's a simple system call which merely prints the
value of xtime.  The kernel recompiles OK, and my
user-space program (p5_a.c) actually works using the
added system call when I use syscall() and do not
generate a stub. (The 2 versions of my user-space
programs are included below).  However, when I try to
generate a stub in my user-space program using
_syscall2(), I receive the following compilation
error:

# gcc -Wall -D__KERNEL__ -I
/lib/modules/2.4.28-gentoo-r5/build/include -o p5_b
p5_b.c
/tmp/cc5nBrjZ.o(.text+0x23): In function
'pedagogictime':
: undefined reference to 'errno'
collect2: ld returned 1 exit status

Here is what I did:

I first modified
/usr/src/linux-2.4.28-gentoo-r5/arch/i386/kernel/time.c
to add my system call, which is the following:

asmlinkage int sys_pedagogictime(int flag, struct
timeval *thetime)
{
  int write_failed;
  struct timeval kernel_tv;

  cli(); // blocks interrupts
  kernel_tv.tv_sec = xtime.tv_sec;  //read xtime
  kernel_tv.tv_usec = xtime.tv_usec;
  sti(); // unblock interrupts

  write_failed = copy_to_user(thetime, &kernel_tv,
sizeof(struct timeval));
  if (write_failed) {
    printk("WRITE FAILED: could not write the time
into user space\n");
    return -1;
  }

  /* Print the time if flag is true */
  if (flag) {
    printk("pedagogictime results: %ld.%.6ld\n",
kernel_tv.tv_sec, 
                                                
kernel_tv.tv_usec);
  }

  return 0;

}

I then modified
/usr/src/linux-2.4.28-gentoo-r5/arch/i386/kernel/entry.S
to add my system call table entry:

.long SYMBOL_NAME(sys_pedagogictime)    /* 259 */

I also added the following line in
/usr/src/linux-2.4.28-gentoo-r5/include/asm/unistd.h
to generate a system call stub:

#define __NR_pedagogictime      259

Finally, I cd /usr/src/linux-2.4.28-gentoo-r5 and edit
the Makefile so that "EXTRAVERSION = -gentoo-r5-new",
and recompiled my custom kernel with the following
commands:

make mrproper
make menuconfig
make dep
make bzImage
make modules
make modules-install
make install

Here are the 2 versions of my user-space programs:

/* p5_a.c */
#include <stdio.h>
#include <sys/time.h>

int main(int argc, char **argv)
{
  struct timeval tv;

  /* use syscall to call pedagogictime - entry 259 */
  syscall(259, 1, &tv);

  /* print the results to stdout */
  printf("Pedagocictime: %ld.%.6ld\n", tv.tv_sec,
tv.tv_usec);

  return 0; 
}

/* p5_b.c */
#include <stdio.h>
#include <linux/unistd.h>
#include <sys/time.h>

_syscall2(int, pedagogictime, int, flag, struct
*timeval, thetime);

int main(int argc, char **argv)
{
  struct timeval tv;

  pedagogictime(1, &tv);
  printf("Pedagogictime: %ld.%.6ld\n", tv.tc_sec,
tv.tv_usec);

  return 0;
}

I apologize for being so verbose, but I think it's all
relevant.

Also, now I have 2 kernels, and when I boot from the
original, I get the following error at boot:

Bringing eth0 up via DHCP... [!!]
ERROR: Problem starting needed services.
"netmount" was not started.

The original kernel I compiled with genkernel.  The
new kernel used the method described above.  Here is
my grub.conf:

default 0
timeout 30
splashimage=(hd0,0)/grub/splash.xpm.gz

title=Gentoo Linux 2.4.28-r5
root (hd0,0)
kernel /kernel-2.4.28-gentoo-r5 root=/dev/ram0
init=/linuxrc 
ramdisk=8192 real_root=/dev/hda3
initrd /initrd-2.4.28-gentoo-r5

title=Gentoo Linux 2.4.28-r5-new
root (hd0,0)
kernel /vmlinuz-2.4.28-gentoo-r5-new root=/dev/hda3

Thank you for any help you can provide.  I am new at
kernel programming, but am having a great time!

Jensen



		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
