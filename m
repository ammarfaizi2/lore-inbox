Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTJNSdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTJNSdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:33:17 -0400
Received: from nondot.cs.uiuc.edu ([128.174.245.159]:57529 "EHLO nondot.org")
	by vger.kernel.org with ESMTP id S262874AbTJNSc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:32:56 -0400
Date: Tue, 14 Oct 2003 13:49:04 -0500 (CDT)
From: Chris Lattner <sabre@nondot.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
Message-ID: <Pine.LNX.4.44.0310141347530.4033-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Lattner wrote:
> Generated code:
>         .intel_syntax
> ...
> main:
>         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
>         mov %EBP, %ESP                        # Set up EBP
>         sub %ESP, 16004                       # Finally adjust ESP
>         lea %EAX, DWORD PTR [%EBP - 16000]    # Get the address of the array
> ...
>         mov %EAX, 0                           # Setup return value
>         mov %ESP, %EBP                        # restore ESP
>         mov %EBP, DWORD PTR [%ESP - 16004]    # Restore EBP from stack
>         ret

Ok, I found my own "answer": arch/i386/mm/fault.c:

                /*
                 * accessing the stack below %esp is always a bug.
                 * The "+ 32" is there due to some instructions (like
                 * pusha) doing post-decrement on the stack and that
                 * doesn't show up until later..
                 */
                if (address + 32 < regs->esp)
                        goto bad_area;

Why exactly is accessing the stack below %esp always a bug?

-Chris

-- 
http://llvm.cs.uiuc.edu/
http://www.nondot.org/~sabre/Projects/

