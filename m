Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132724AbRC2MYP>; Thu, 29 Mar 2001 07:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRC2MYF>; Thu, 29 Mar 2001 07:24:05 -0500
Received: from ns2.servicenet.com.ar ([200.41.148.12]:30995 "EHLO
	servnet.servicenet.com.ar") by vger.kernel.org with ESMTP
	id <S132724AbRC2MXy>; Thu, 29 Mar 2001 07:23:54 -0500
Message-ID: <A0C675E9DC2CD411A5870040053AEBA0284141@MAINSERVER>
From: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: copy_to_user - (is the best way?)
Date: Thu, 29 Mar 2001 09:25:11 -0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1461.28)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking, the syscalls and drivers in the kernel and always what
I see is something like this:

int func(char *user_buffer) {
	/* A lot of function stuff */
	...

	/* then at the end when  you write user_buffer I see */
	if (copy_to_user(user_buffer, from, n)) 
		return -EFAULT
	return 0;
}	

copy_to_user use access_ok () to check that user_buffer is in the current
proccess address space... The problem is that you always make what you need
to do and then you check that buffer is ok or not! why you don't first check
buffer and then make all what you need to do and at the end you write to the
buffer without checking? let say something like this..

int func(char *user_buffer) {
	if (access_ok(buffer, n)) {
		/* A lot of function stuff */
		...
		__copy_user(to, from, n);
		return 0;
	} 
	return -EFAULT;
	
}

This idea wont work if you don't have n (the size) to be writed to the
user_buffer, but I think will increase performance.. because sometime what I
call /* A lot of function stuff */ is disable interrupts (asm ("cli");) and
isn't so funny (I think) to disable interrupts when you know that it will
return an Error Code at the end... 

an example of what I'm talking about take a look at kernel/info.c

in this implementation of sys_sysinfo() you first do all the things you need
to do (disable interrupts.. etc) but at the end if 'info' is out of the
process address space it return a segmentation fault why don't first check
info with access_ok() and then continue with the syscall or driver or what
else...


Thanks.

Eliel Sardanons



