Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSKUUKR>; Thu, 21 Nov 2002 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSKUUKR>; Thu, 21 Nov 2002 15:10:17 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:50133 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262373AbSKUUKQ>; Thu, 21 Nov 2002 15:10:16 -0500
Date: Thu, 21 Nov 2002 12:17:11 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: [RFC] hangcheck-timer module
Message-ID: <20021121201711.GG770@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Attached is a module, hangcheck-timer.  It is used to detect
when the system goes out to lunch for a period of time, such as when a
driver like qla2x00 udelays a bunch.
	The module sets a timer.  When the timer goes off, it then uses
the TSC (warning: portability needed) to determine how much real time
has passed.
	On a normal system, the real elapsed time will be almost
identical to the expected timer duration.  However, if a device decided
to udelay for 60 seconds (or some other circumstance), the module takes
notice.  If the margin of error passes a threshold, the machine is
rebooted.
	The module is currently used in a cluster environment.  After
some time out to lunch, the rest of the cluster will have given up on a
machine.  If the machine suddenly comes back and assumes it is still
"live", bad things can happen.
	We can also see use for this in a debugging sense, for kernel
hangs as well as driver code.  That's why I'm proposing it for general
inclusion.
	Comments?  Thoughts?

Joel

Building:
	The module should happily build against most 2.4 kernels.  The
usual module building compile line:
	gcc  -I /scratch/jlbec/kernel/linux-2.4.20-rc2/include \
		-DMODULE -D__KERNEL__ -DLINUX  -c -o hangcheck-timer.o \
		hangcheck-timer.c

Running:
	Load the module with insmod.  There are two options.
"hangcheck_tick=<seconds>" specifies the timer timeout, and
"hangcheck_margin=<seconds" specifies the margin of error.

Joel

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
