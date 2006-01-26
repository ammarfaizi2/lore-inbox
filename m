Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWAZGXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWAZGXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 01:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAZGXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 01:23:43 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:53164 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932084AbWAZGXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 01:23:42 -0500
Date: Thu, 26 Jan 2006 01:19:35 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Test program demonstrating sys_clone() is broken on i386
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601260123_MC3-1-B6C2-1154@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program demonstrates sys_clone() is broken on i386 when
using vsyscall to enter the kernel.

Stock 2.6.15:

        $ gcc -o test_clone2.ex test_clone2.c ; ./test_clone2.ex
        SIGSEGV accessing 0x00000000 from EIP 0x00000000
        cloned; ret = 772

After applying kernel patch:

        $ gcc -o test_clone2.ex test_clone2.c ; ./test_clone2.ex
        cloned; ret = 0
        cloned; ret = 676

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

#ifdef INT80
#  define SYSCALL_STR "int $0x80\n\t"
#else
#  define SYSCALL_STR "call 0xffffe400\n\t"
#endif

#define CLONE	120
#define FLAGS	0

unsigned long child_stack[4096] __attribute__((__aligned__(4096)));
unsigned long *child_stack_ptr = &child_stack[2047];
struct sigaction sa;
int ret;

static void handler(int nr, siginfo_t *si, void *vuc)
{
	struct ucontext *uc = (struct ucontext *)vuc;
	struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;

	printf("SIGSEGV accessing 0x%08x from EIP 0x%08x\n",
	       (unsigned long)si->si_addr, sc->eip);

	sa.sa_handler = SIG_DFL;
	sa.sa_flags = 0;
	sigaction(SIGSEGV, &sa, NULL);
}

int main(int argc, char * const argv[])
{
	sa.sa_sigaction = handler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGSEGV, &sa, NULL);

	asm volatile(
		SYSCALL_STR
		: "=a"(ret)
		: "a"(CLONE), "b"(FLAGS), "c"(child_stack_ptr)
		: "memory"
	);

	printf("cloned; ret = %d\n", ret);
	_exit(0);
}
-- 
Chuck
Currently reading: _The Atrocity Archives_ by Charles Stross
