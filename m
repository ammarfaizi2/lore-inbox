Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSBCIWq>; Sun, 3 Feb 2002 03:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286521AbSBCIWg>; Sun, 3 Feb 2002 03:22:36 -0500
Received: from fes.whowhere.com ([209.185.123.154]:5590 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S286462AbSBCIWS>;
	Sun, 3 Feb 2002 03:22:18 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 03 Feb 2002 13:52:08 +0530
From: "Alpha Beta" <abbashake007@lycos.com>
Message-ID: <BNBIFONAELMBOAAA@mailcity.com>
Mime-Version: 1.0
Content-Language: en
Reply-To: abbashake007@lycos.com
X-Sent-Mail: off
X-Mailer: MailCity Service
Subject: Qn: kernel_thread() and init
X-Priority: 3
X-Sender-Ip: 203.197.98.3
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the code of 
int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
in arch/i386/kernel/process.c

as can be seen in the code here, a system call is made by trigerring the 0x80 interrupt.
this function kernel_thread() is used to launch the init process during booting by
start_kernel()	//in init/main.c
But at that time, the process 0 which calls kernel_thread is executing in Kernel mode, so why should some process in kernel mode make a system call??


ANOTHER BIG DOUBT IS THAT process 0 executes in Kernel mode, it then creates the init process ( process 1)- this process according to BACH ends up running in User mode while process 0 runs in kernel mode.
so why should then we have a kernel thread invoked for init when it is to run in User mode ??




int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
{
	long retval, d0;

	__asm__ __volatile__(
		"movl %%esp,%%esi\n\t"
		"int $0x80\n\t"		/* Linux/i386 system call */
		"cmpl %%esp,%%esi\n\t"	/* child or parent? */
		"je 1f\n\t"		/* parent - jump */
		/* Load the argument into eax, and push it.  That way, it does
		 * not matter whether the called function is compiled with
		 * -mregparm or not.  */
		"movl %4,%%eax\n\t"
		"pushl %%eax\n\t"		
		"call *%5\n\t"		/* call fn */
		"movl %3,%0\n\t"	/* exit */
		"int $0x80\n"
		"1:\t"
		:"=&a" (retval), "=&S" (d0)
		:"0" (__NR_clone), "i" (__NR_exit),
		 "r" (arg), "r" (fn),
		 "b" (flags | CLONE_VM)
		: "memory");
	return retval;
}



