Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136066AbREJNCr>; Thu, 10 May 2001 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136308AbREJM7m>; Thu, 10 May 2001 08:59:42 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47751 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136069AbREJM70>;
	Thu, 10 May 2001 08:59:26 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105100612.CAA16504@smarty.smart.net>
Subject: Re: inserting a Forth-like language into the Linux kernel
To: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2001 02:12:34 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

read() of a tty from the kernel does behave as per the tty settings.
I now have a kernel thread with stdin, out and err, FD's 0, 1 and 2,
open and reading lines of typed input. The "interpreter" adds 0x30 
(ASCII 0) to the return value from read and prints it, which means 
it occurs at the beginning of the next line. Here's what's sitting 
on my tty1 screen right now...
.................................................................
1
1
1
1aaoeutasoeu aoeu oaeusntaoesutoaeut oeuoaeuo uoaeuoaeu
heeee
6e
2
1
1
1
1eeeeee
7ee
3
1onetu euaoeuaoeuoa eu aoeu ao eu ao eu aoeu  aoeu ao eu aoe u aoe u
te e e e e
;e e e e
9e e e e
9e e e
7ee
3
...................................................................

This should simplify hanging an interpreter off this simple little top 
loop. That is, userland H3sm was using cooked mode, so this is nice. 
This is the top loop code, which is x86 assembly and H3sm 
subroutines...

.................................................................
abort_H3sm:
        call buffer

top_loop_of_H3sm:
                                # stick a sleep in here.
                                # Do not melt the CPU, do not slow down
                                #       the test cycle.
        call timespec
        call pdup
        call pplusc
        call pplusc
        call nanosleep
        call twopdrop
        call drop

        HANDOFF

        call zero               # FD
        call read
        call literal
        .byte 4
        .int  0x30
        call plus
        call emit
ELL(                                                    top_loop_of_H3sm)
...................................................................

emit is similar to Forth EMIT. It is a one-byte write().
buffer and timespec put addresses on
the H3sm pointer stack. nanosleep and read are H3sm stack-passing
wrappers for the syscalls. HANDOFF is a macro for a stack-push-wrapped
schedule(). It's a macro because I suspect I'm going to have to sprinkle
it judiciously around H3sm. The nanosleep keeps my load average normal.

Rick Hohensee
www.clienux.com
