Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313749AbSDIGDK>; Tue, 9 Apr 2002 02:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313755AbSDIGDJ>; Tue, 9 Apr 2002 02:03:09 -0400
Received: from cs.columbia.edu ([128.59.16.20]:31892 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S313749AbSDIGDI>;
	Tue, 9 Apr 2002 02:03:08 -0400
Message-ID: <00bb01be824f$af09b9b0$13123b80@endo>
From: "Dinesh K Subhraveti" <dinesh@cs.columbia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Isn't wait4 amenable to interception?
Date: Fri, 9 Apr 1999 02:10:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to intercept wait4 and having problems with it. Does wait4
differ from other system calls in any peculiar way? The new system call
routine just returns original sys_wait4. After inserting the module, system
works just fine. But rmmod causes a kernel oops with "Bad EIP" message and
shell gets killed. After kernel oops everything seems just fine too. I'd
greatly appreciate any insight on this. Am attaching the code below. Please
reply to dinesh@cs.columbia.edu.

Thanks in advance,
Dinesh

-----------------------------------------------
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/resource.h>
#include <sys/syscall.h>

extern void *sys_call_table[];

static int (*original_sys_wait4) (pid_t, int*, int, struct rusage*);

asmlinkage int my_wait4 (pid_t a, int *b, int c, struct rusage *d)
{
   return original_sys_wait4 (a, b, c, d);
}

int init_module()
{
   original_sys_wait4 = sys_call_table[__NR_wait4];
   sys_call_table[__NR_wait4] = my_wait4;
   return 0;
}

void cleanup_module()
{
   sys_call_table[__NR_wait4] = original_sys_wait4;
}


