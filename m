Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292327AbSBBRQy>; Sat, 2 Feb 2002 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292328AbSBBRQp>; Sat, 2 Feb 2002 12:16:45 -0500
Received: from fes2.whowhere.com ([209.185.123.102]:9006 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S292327AbSBBRQZ>;
	Sat, 2 Feb 2002 12:16:25 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 02 Feb 2002 22:46:20 +0530
From: "Alpha Beta" <abbashake007@lycos.com>
Message-ID: <MCOPFDJKMGLLEBAA@mailcity.com>
Mime-Version: 1.0
Cc: abbashake007@yahoo.com
X-Sent-Mail: off
Reply-To: abbashake007@lycos.com
X-Expiredinmiddle: true
X-Mailer: MailCity Service
X-Priority: 3
Subject: Qn: kernel_thread()
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




