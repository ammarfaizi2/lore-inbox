Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbULDOlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbULDOlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 09:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbULDOlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 09:41:08 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:11136 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262548AbULDOkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 09:40:52 -0500
Date: Sat, 4 Dec 2004 15:40:02 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041204144002.GA15404@vana.vc.cvut.cz>
References: <1102004520.8707.10.camel@localhost> <20041203061520.GG31767@wotan.suse.de> <1102115789.8707.122.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102115789.8707.122.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 03:16:29PM -0800, Jeremy Fitzhardinge wrote:
> On Fri, 2004-12-03 at 07:15 +0100, Andi Kleen wrote:
> > int 0x80 from 64bit will call 32bit syscalls.
> 
> Hm, that's not what I found.  If I run int 0x80 with [re]ax=1, I get
> exit with a 32-bit process and write with a 64-bit one.

Seems to work for me.  See second example below.  If it won't work, you
can always use reverse procedure to one I used in syscall.c - only
problem is that you'll have to allocate some memory below 4GB to
hold code & stack during 32bit syscall.
 
> >  But some things
> > will not work properly, e.g. signals because they test the 32bit
> > flag in the task_struct. So you would still get 64bit signal frames.
> 
> OK, I can deal with that, since signals are never directly delivered to
> the client.
> 
> > There are some other such tests, but they probably wont affect you.
> > 
> > There were some plans at one point to allow to toggle the flag 
> > using personality or prctl, but so far it hasn't been implemented.
> > There is also no way to do 64bit calls from a 32bit executable.
> 
> What about my idea of using distinct ranges of syscall numbers to
> disambiguate them?

What about this?  This does 64bit syscalls from 32bit executable.

Developed/tested on 2.6.10-rc2-mm2.  You may want to replace $0x33 with 
some other value on 2.4.x kernels, but otherwise it should work fine for 
you.  And well, you may want to do some additional coding so you can 
actually pass & retrieve 64bit values to/from syscalls.

When it works correctly, program should print something and exit with code
111.  If it sigsegvs or exits with 222, something went wrong.
							Petr

vana:~/64bit-test# more syscall.c
#include <stdio.h>
#include <string.h>

#define TOLM                            \
                "pushl %%cs\n"          \
                "pushl $91f\n"          \
                "ljmpl $0x33,$90f\n"    \
                ".code64\n"             \
                "90:\n"
#define FROMLM                          \
                "lretl\n"               \
                ".code32\n"             \
                "91:\n"

unsigned long x8664syscall1(unsigned long op, unsigned long value) {
        unsigned long result;

        asm volatile(
                TOLM
                "mov %1,%1\n"   /* Opteron does not need this, but em64t maybe needs */
                "mov %2,%2\n"
                "syscall\n"
                FROMLM
                : "=a"(result) : "0"(op), "D"(value));
        return result;
}

unsigned long x8664syscall3(unsigned long op, unsigned long v1, unsigned long v2, unsigned long v3) {
        unsigned long result;

        asm volatile(
                TOLM
                "mov %1,%1\n"
                "mov %2,%2\n"
                "mov %3,%3\n"
                "mov %4,%4\n"
                "syscall\n"
                FROMLM
                : "=a"(result) : "0"(op), "D"(v1), "S"(v2), "d"(v3));
        return result;
}

int main(int argc, char* argv[]) {
        printf("Write?\n");
        x8664syscall3(1 /* x86-64 __NR_write */, 1 /* stdout */, (unsigned long)"64-bit rules!\n", 14);
        printf("And now exit(111)\n");
        x8664syscall1(60 /* x86-64 __NR_exit */, 111);
        printf("Exit did not exit...\n");
        return 222;
}
vana:~/64bit-test# gcc -W -Wall -O2 -o syscall syscall.c
syscall.c: In function `main':
syscall.c:43: warning: unused parameter `argc'
syscall.c:43: warning: unused parameter `argv'
vana:~/64bit-test# ./syscall
Write?
64-bit rules!
And now exit(111)
vana:~/64bit-test# echo $?
111
vana:~/64bit-test# file syscall
syscall: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for GNU/Linux 2.2.0, dynamically linked (uses shared libs), not stripped



vana:~/64bit-test# more syscall64.c
#include <stdio.h>
#include <string.h>

unsigned long ia32syscall1(unsigned long op, unsigned long value) {
        unsigned long result;

        asm volatile(
                "int $0x80\n"
                : "=a"(result) : "0"(op), "b"(value));
        return result;
}

unsigned long ia32syscall3(unsigned long op, unsigned long v1, unsigned long v2, unsigned long v3) {
        unsigned long result;

        asm volatile(
                "int $0x80\n"
                : "=a"(result) : "0"(op), "b"(v1), "c"(v2), "d"(v3));
        return result;
}

int main(int argc, char* argv[]) {
        printf("Write?\n");
        ia32syscall3(4 /* 386 __NR_write */, 1 /* stdout */, (unsigned long)"32-bit rules!\n", 14);
        printf("And now exit(111)\n");
        ia32syscall1(1 /* 386 __NR_exit */, 111);
        printf("Exit did not exit...\n");
        return 222;
}
vana:~/64bit-test# x86_64-linux-gcc -W -Wall -O2 -o syscall64 syscall64.c
syscall64.c: In function `main':
syscall64.c:22: warning: unused parameter `argc'
syscall64.c:22: warning: unused parameter `argv'
vana:~/64bit-test# ./syscall64
Write?
32-bit rules!
And now exit(111)
vana:~/64bit-test# echo $?
111
vana:~/64bit-test# file ./syscall64
./syscall64: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), not stripped
vana:~/64bit-test#

