Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVEJLfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVEJLfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVEJLfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:35:42 -0400
Received: from alog0374.analogic.com ([208.224.222.150]:61084 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261612AbVEJLfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:35:12 -0400
Date: Tue, 10 May 2005 07:35:05 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: jensen galan <jrgalan@yahoo.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adding a system call to kernel
In-Reply-To: <20050510052311.93996.qmail@web40909.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0505100729170.9839@chaos.analogic.com>
References: <20050510052311.93996.qmail@web40909.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mixing up kernel and user-space headers will give you these
kinds of problems. Use only user-space headers for your
user-space program and be sure to include <errno.h> which
has the macros necessary to resolve your "errno" issue.
Also use only kernel headers in your kernel module. The
kernel doesn't have an 'errno'. It returns negative
error-codes which are negated and put into a user-space
errno, in the user-space side of the system call.

On Tue, 10 May 2005, jensen galan wrote:

> Greetings,
>
> I am trying to add a system call to a 2.4 kernel.
> It's a simple system call which merely prints the
> value of xtime.  The kernel recompiles OK, and my
> user-space program (p5_a.c) actually works using the
> added system call when I use syscall() and do not
> generate a stub. (The 2 versions of my user-space
> programs are included below).  However, when I try to
> generate a stub in my user-space program using
> _syscall2(), I receive the following compilation
> error:
>
> # gcc -Wall -D__KERNEL__ -I
> /lib/modules/2.4.28-gentoo-r5/build/include -o p5_b
> p5_b.c
> /tmp/cc5nBrjZ.o(.text+0x23): In function
> 'pedagogictime':
> : undefined reference to 'errno'
> collect2: ld returned 1 exit status
>
> Here is what I did:
>
> I first modified
> /usr/src/linux-2.4.28-gentoo-r5/arch/i386/kernel/time.c
> to add my system call, which is the following:
>
> asmlinkage int sys_pedagogictime(int flag, struct
> timeval *thetime)
> {
>  int write_failed;
>  struct timeval kernel_tv;
>
>  cli(); // blocks interrupts
>  kernel_tv.tv_sec = xtime.tv_sec;  //read xtime
>  kernel_tv.tv_usec = xtime.tv_usec;
>  sti(); // unblock interrupts
>
>  write_failed = copy_to_user(thetime, &kernel_tv,
> sizeof(struct timeval));
>  if (write_failed) {
>    printk("WRITE FAILED: could not write the time
> into user space\n");
>    return -1;
>  }
>
>  /* Print the time if flag is true */
>  if (flag) {
>    printk("pedagogictime results: %ld.%.6ld\n",
> kernel_tv.tv_sec,
>
> kernel_tv.tv_usec);
>  }
>
>  return 0;
>
> }
>
> I then modified
> /usr/src/linux-2.4.28-gentoo-r5/arch/i386/kernel/entry.S
> to add my system call table entry:
>
> .long SYMBOL_NAME(sys_pedagogictime)    /* 259 */
>
> I also added the following line in
> /usr/src/linux-2.4.28-gentoo-r5/include/asm/unistd.h
> to generate a system call stub:
>
> #define __NR_pedagogictime      259
>
> Finally, I cd /usr/src/linux-2.4.28-gentoo-r5 and edit
> the Makefile so that "EXTRAVERSION = -gentoo-r5-new",
> and recompiled my custom kernel with the following
> commands:
>
> make mrproper
> make menuconfig
> make dep
> make bzImage
> make modules
> make modules-install
> make install
>
> Here are the 2 versions of my user-space programs:
>
> /* p5_a.c */
> #include <stdio.h>
> #include <sys/time.h>
>
> int main(int argc, char **argv)
> {
>  struct timeval tv;
>
>  /* use syscall to call pedagogictime - entry 259 */
>  syscall(259, 1, &tv);
>
>  /* print the results to stdout */
>  printf("Pedagocictime: %ld.%.6ld\n", tv.tv_sec,
> tv.tv_usec);
>
>  return 0;
> }
>
> /* p5_b.c */
> #include <stdio.h>
> #include <linux/unistd.h>
> #include <sys/time.h>
>
> _syscall2(int, pedagogictime, int, flag, struct
> *timeval, thetime);
>
> int main(int argc, char **argv)
> {
>  struct timeval tv;
>
>  pedagogictime(1, &tv);
>  printf("Pedagogictime: %ld.%.6ld\n", tv.tc_sec,
> tv.tv_usec);
>
>  return 0;
> }
>
> I apologize for being so verbose, but I think it's all
> relevant.
>
> Also, now I have 2 kernels, and when I boot from the
> original, I get the following error at boot:
>
> Bringing eth0 up via DHCP... [!!]
> ERROR: Problem starting needed services.
> "netmount" was not started.
>
> The original kernel I compiled with genkernel.  The
> new kernel used the method described above.  Here is
> my grub.conf:
>
> default 0
> timeout 30
> splashimage=(hd0,0)/grub/splash.xpm.gz
>
> title=Gentoo Linux 2.4.28-r5
> root (hd0,0)
> kernel /kernel-2.4.28-gentoo-r5 root=/dev/ram0
> init=/linuxrc
> ramdisk=8192 real_root=/dev/hda3
> initrd /initrd-2.4.28-gentoo-r5
>
> title=Gentoo Linux 2.4.28-r5-new
> root (hd0,0)
> kernel /vmlinuz-2.4.28-gentoo-r5-new root=/dev/hda3
>
> Thank you for any help you can provide.  I am new at
> kernel programming, but am having a great time!
>
> Jensen
>
>
>
>
> __________________________________
> Yahoo! Mail Mobile
> Take Yahoo! Mail with you! Check email on your mobile phone.
> http://mobile.yahoo.com/learn/mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
