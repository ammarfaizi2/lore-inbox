Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVAYVbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVAYVbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVAYV3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:29:42 -0500
Received: from alog0154.analogic.com ([208.224.220.169]:29824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262152AbVAYV1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:27:07 -0500
Date: Tue, 25 Jan 2005 16:26:42 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Robert Szeleney <skyos@liwest.at>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Register saving and signal handling
In-Reply-To: <41F6A90B.4020005@liwest.at>
Message-ID: <Pine.LNX.4.61.0501251608310.8986@chaos.analogic.com>
References: <41F6A90B.4020005@liwest.at>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-696708615-1106688402=:8986"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-696708615-1106688402=:8986
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Tue, 25 Jan 2005, Robert Szeleney wrote:

> Hi!
>
> This is my first time posting to the Linux kernel mailing-list, and I hope 
> someone can help me or at least explain following to me.
>
> When a task gets interrupted by a signal, the do_signal() function is called. 
> Now, when the signal is not handled by the task and the interrupted function 
> returned -EINTR, the syscall gets restarted by modifying the user mode EIP to 
> point to the int 0x80 again.
>
> When the task leaves the do_signal function, it will pop the saved registers 
> and return to the user mode and immediately do the syscall again.
>
> But now to the actual question:
>
> Let's make a new "test" system call function. Let's call it: sys_test
>
> asmlinkage int sys_test(int para1, int para2)
> {
>   para1++;
>   para2++;
>
>   kill( current->pid, SIGCHLD);
>   return -EINTR;
> }
>
> When compiling this function, GCC increments para1 and para2 by one. para1 
> and para2 are stored on the kernel stack. The system call entry assembler 
> function pushed the registers containing this values from the usermode on the 
> stack.
> But GCC actually modified the values on the stack here, the "live" data. 
> (which will be poped later again, right before returning to user mode)
>
> After returning from this function, the system call wrapper checks for a 
> signal and calls do_signal. The do_signal call will restart the system call 
> by modifying the user mode EIP. Then, the system call wrapper will pop the 
> saved registers from the stack. But here I see this problem. The already 
> modified values for para1 and para2 will be popped. When the system call is 
> then start again, para1 and para2 don't have to original value.
>
> One can say, why are you modifying para1 and para2 then?  Yes, this is 
> correct, but after compiling a few more test sources, I got following 
> problem:
>
> asmlinkage int sys_test(int iSize)
> {
>    printk("Size is: %d\n", iSize * sizeof(any_structure));
> }
>
> When compiling this, GCC produces following assembler:
>
> ....
> sall    $4, 8(%ebp)
> ....
>

But this is correct. The caller should pass a COPY of the parameter.
The called procedure can do anything it wants to this copy. Check
to see what asmlinkage is #defined to be ou your system. It should
be __attribute__((regparam(0))). If it got changed, all bets are
off with any interface code. Everything needs to match.

> which actually modifies the content of the stack holding the iSize again. It 
> is very difficult to keep track of such implicit stack argument 
> modifications.
> Thus, when a signal is waiting and the syscall is restarted, iSize contains a 
> different value already.
>
> So, does anyone else have such a problem? Is there any compiler flag missing? 
> Is this possible at all?
>
> Thank you very much!
> Robert!
>
> Btw,  please CC to mf204005@liwest.at  too.

Yes.

For instance:

void funct(int param)
{
     param++;
}
int main()
{
     int foo = 0;
     printf("%d\n", foo);
}

That code should pass a COPY of foo to funct(). Procedure
funct() should be able to do anything it wants with it
and, since it's a copy, main() should still print 0.
However, there is some kernel code that passes the
actual value, not a copy.

linux-2.6.9/arch/i386/kernel/semaphore.c is an example.
This has some hand-tweaked assembly that violates the
de-facto 'C' standard. There may be other such kernel
code. I submitted a patch, but it was rejected. Just
for kicks, I attached the patch so you can see what
problem(s) may still exist.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-696708615-1106688402=:8986
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="semaphore.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501251626420.8986@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="semaphore.patch"

LS0tIGxpbnV4LTIuNi45L2FyY2gvaTM4Ni9rZXJuZWwvc2VtYXBob3JlLmMu
b3JpZwkyMDA0LTEwLTI5IDEzOjAwOjE3Ljk2MTU3OTM2OCAtMDQwMA0KKysr
IGxpbnV4LTIuNi45L2FyY2gvaTM4Ni9rZXJuZWwvc2VtYXBob3JlLmMJMjAw
NC0xMC0yOSAxMzowMzozNS4wNDY2MTc4ODggLTA0MDANCkBAIC0xOTgsOSAr
MTk4LDExIEBADQogI2VuZGlmDQogCSJwdXNobCAlZWF4XG5cdCINCiAJInB1
c2hsICVlZHhcblx0Ig0KLQkicHVzaGwgJWVjeFxuXHQiDQorCSJwdXNobCAl
ZWN4XG5cdCIJCS8vIFJlZ2lzdGVyIHRvIHNhdmUNCisJInB1c2hsICVlY3hc
blx0IgkJLy8gUGFzc2VkIHBhcmFtZXRlcg0KIAkiY2FsbCBfX2Rvd25cblx0
Ig0KLQkicG9wbCAlZWN4XG5cdCINCisJImxlYWwgMHgwNCglZXNwKSwgJWVz
cFx0XG4iCS8vIEJ5cGFzcyBjb3JydXB0ZWQgcGFyYW1ldGVyDQorCSJwb3Bs
ICVlY3hcblx0IgkJCS8vIFJlc3RvcmUgb3JpZ2luYWwNCiAJInBvcGwgJWVk
eFxuXHQiDQogCSJwb3BsICVlYXhcblx0Ig0KICNpZiBkZWZpbmVkKENPTkZJ
R19GUkFNRV9QT0lOVEVSKQ0KQEAgLTIyMCw5ICsyMjIsMTEgQEANCiAJIm1v
dmwgICVlc3AsJWVicFxuXHQiDQogI2VuZGlmDQogCSJwdXNobCAlZWR4XG5c
dCINCi0JInB1c2hsICVlY3hcblx0Ig0KKwkicHVzaGwgJWVjeFxuXHQiCQkv
LyBTYXZlIHJlZ2lzdGVyDQorCSJwdXNobCAlZWN4XG5cdCIJCS8vIFBhc3Nl
ZCBwYXJhbWV0ZXINCiAJImNhbGwgX19kb3duX2ludGVycnVwdGlibGVcblx0
Ig0KLQkicG9wbCAlZWN4XG5cdCINCisJImxlYWwgMHgwNCglZXNwKSwgJWVz
cFxuXHQiCS8vIEJ5cGFzcyBjb3JydXB0ZWQgcGFyYW1ldGVyDQorCSJwb3Bs
ICVlY3hcblx0IgkJCS8vIFJlc3RvcmUgcmVnaXN0ZXINCiAJInBvcGwgJWVk
eFxuXHQiDQogI2lmIGRlZmluZWQoQ09ORklHX0ZSQU1FX1BPSU5URVIpDQog
CSJtb3ZsICVlYnAsJWVzcFxuXHQiDQpAQCAtMjQxLDkgKzI0NSwxMSBAQA0K
IAkibW92bCAgJWVzcCwlZWJwXG5cdCINCiAjZW5kaWYNCiAJInB1c2hsICVl
ZHhcblx0Ig0KLQkicHVzaGwgJWVjeFxuXHQiDQorCSJwdXNobCAlZWN4XG5c
dCIJCS8vIFNhdmUgcmVnaXN0ZXINCisJInB1c2hsICVlY3hcblx0IgkJLy8g
UGFzc2VkIHBhcmFtZXRlcg0KIAkiY2FsbCBfX2Rvd25fdHJ5bG9ja1xuXHQi
DQotCSJwb3BsICVlY3hcblx0Ig0KKwkibGVhbCAweDA0KCVlc3ApLCAlZXNw
XG5cdCIJLy8gQnlwYXNzIGNvcnJ1cHRlZCBwYXJhbWV0ZXINCisJInBvcGwg
JWVjeFxuXHQiCQkJLy8gUmVzdG9yZSByZWdpc3Rlcg0KIAkicG9wbCAlZWR4
XG5cdCINCiAjaWYgZGVmaW5lZChDT05GSUdfRlJBTUVfUE9JTlRFUikNCiAJ
Im1vdmwgJWVicCwlZXNwXG5cdCINCkBAIC0yNTksOSArMjY1LDExIEBADQog
Il9fdXBfd2FrZXVwOlxuXHQiDQogCSJwdXNobCAlZWF4XG5cdCINCiAJInB1
c2hsICVlZHhcblx0Ig0KLQkicHVzaGwgJWVjeFxuXHQiDQorCSJwdXNobCAl
ZWN4XG5cdCIJCS8vIFNhdmUgcmVnaXN0ZXINCisJInB1c2hsICVlY3hcblx0
IgkJLy8gUGFzc2VkIHBhcmFtZXRlcg0KIAkiY2FsbCBfX3VwXG5cdCINCi0J
InBvcGwgJWVjeFxuXHQiDQorCSJsZWFsIDB4MDQoJWVzcCksICVlc3Bcblx0
IgkvLyBCeXBhc3MgY29ycnVwdGVkIHBhcmFtZXRlcg0KKwkicG9wbCAlZWN4
XG5cdCIJCQkvLyBSZXN0b3JlIHJlZ2lzdGVyDQogCSJwb3BsICVlZHhcblx0
Ig0KIAkicG9wbCAlZWF4XG5cdCINCiAJInJldCINCg==

--1879706418-696708615-1106688402=:8986--
