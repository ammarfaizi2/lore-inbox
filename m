Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWEVHzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWEVHzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWEVHzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:55:25 -0400
Received: from mail02.inetu.net ([209.235.219.82]:16659 "EHLO mail02.inetu.net")
	by vger.kernel.org with ESMTP id S932593AbWEVHzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:55:25 -0400
From: "chaitanya Huilgol" <chaitanya@tidaldata.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: cmpxchg hard lockup on AMD64 - ASUS(A8V-MX)
Date: Mon, 22 May 2006 13:29:52 +0530
Message-ID: <007a01c67d75$b627b8e0$40c8720a@Everest>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing a hard lockup when the lock-free lifo 
implementation below is run on a AMD Athlon 64
and ASUS A8V-MX motherboard. GCC version is
gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-47.fc4)

I have run this code on Pentiums without any issue
till now. Also the same code works fine in userland. 
I fail to understand as to why the problem occurs
only in kernel mode. 

Thanks,
Chaitanya 



http://lalists.stanford.edu/lad/2000/Jul/0319.html

#ifdef __SMP__
#define LOCK "lock ; "
#else
#define LOCK ""
#endif

typedef struct cell {
       struct cell* link; /* next cell in the lifo */
       /*...*/ /* any data here */
} cell;

typedef struct lifo {
        volatile cell* top; /* top of the stack */
        volatile unsigned long cnt; /* used to avoid ABA problem */
} lifo;
void init(lifo* lf)
{
        lf->top = 0;
        lf->cnt = 0;
}

void push (lifo * lf, cell * cl)
{
        __asm__ __volatile__ (
                "# LFPUSH \n\t"
                "1:\t"
                "movl %2, (%1) \n"
                LOCK "cmpxchg %1, %0 \n\t"
                "jnz 1b \n\t"
                :
                :"m" (*lf), "r" (cl), "a" (lf->top)
                );
}

cell* pop (lifo * lf)
{
        cell* v=0;
        __asm__ __volatile__ (
                "# LFPOP \n\t"
                "testl %%eax, %%eax \n\t"
                "jz 20f \n"
                "10:\t"
                "movl (%%eax), %%ebx \n\t"
                "movl %%edx, %%ecx \n\t"
                "incl %%ecx \n\t"
                LOCK "cmpxchg8b %1 \n\t"
                "jz 20f \n\t"
                "testl %%eax, %%eax \n\t"
                "jnz 10b \n"
                "20:\t"
                :"=a" (v)
                :"m" (*lf), "a" (lf->top), "d" (lf->cnt)
                :"ecx", "ebx" );
        return v;
}

