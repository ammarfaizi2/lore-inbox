Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311212AbSCVL1f>; Fri, 22 Mar 2002 06:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311961AbSCVL10>; Fri, 22 Mar 2002 06:27:26 -0500
Received: from daimi.au.dk ([130.225.16.1]:24217 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S311212AbSCVL1P>;
	Fri, 22 Mar 2002 06:27:15 -0500
Message-ID: <3C9B150B.7F4E7985@daimi.au.dk>
Date: Fri, 22 Mar 2002 12:27:07 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Recent vm86 bugfixes
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.2.21-pre1 some vm86 bugs have been attempted fixed.
The bug did become smaller, but unfortunately didn't get
completely fixed.

The problem was in the kernels access to the vm86 mode
stack. This would previously lead to an Oops if the
memory was not mapped, or was mapped with insufficient
permitions.

The patch adds the necesarry memory checks and returns
VM86_UNKNOWN on error. But at this point the vm86 IP
register will already have stepped over the offending
instruction, on return the IP register should point to
the offending instruction.

In addition to that there were doubts about the
correctness of the return value. For most emulated
instructions the solution most consistent with ordinary
instructions accessing the stack would be to send a
SIGSEGV to the process. But I guess that would be more
difficult both for the kernel code and userspace code.
I actually don't like the idea of code in virtual 86
mode producing SIGSEGV's, it complicates the handling
in userspace when you never know if the SIGSEGV is
caused in virtual 86 mode or protected mode. If all
these SIGSEGV's from virtual 86 mode could be changed
into a return value from vm86() the SIGSEGV handler
could be avoided which will make debuging of the user
code easier. Bottom line of that is that for all those
cases I like the VM86_UNKNOWN return value, but a new
one like VM86_SIGSEGV would IMHO be better.

For the do_int instruction the situation is slightly
different, I don't think VM86_UNKNOWN is a good idea
here. A better idea would be VM86_INTx + (i << 8)
which can be returned for so many different reasons
already that the userspace code can be expected to
handle it. This also avoids the need to step back IP
which would be difficult in this case, since we
actually don't know the instruction.

I have also spotted another bug in the two
set_vflags functions, in both cases two lines are
missing:
        else
                clear_IF(regs);

Also the patch only seems to have been applied to
2.2.x, the Oops still happens in 2.4.18. I will be
back with a patch for 2.4.18 once I have resolved
the mentioned problems.

Any comments?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
