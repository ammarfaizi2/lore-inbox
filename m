Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310789AbSCZHyL>; Tue, 26 Mar 2002 02:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312477AbSCZHyB>; Tue, 26 Mar 2002 02:54:01 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:27818 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S312462AbSCZHxr>; Tue, 26 Mar 2002 02:53:47 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: "Kevin Pedretti" <ktpedre@sandia.gov>, <kernelnewbies@nl.linux.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: do_exit() and lock_kernel() semantics
Date: Mon, 25 Mar 2002 23:53:33 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBMEAMCMAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3C9F7993.7050205@sandia.gov>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. your driver must have a way to syncup with intr routine accesssing this
buffer. The way we do this is by synching access to this buffer and making
sure your file close cleans up this, so intr routine does not touch this
buffer if process is exited. (assuming you provide access via file handles,
and handle the cleanup as file close)

2. you cannot do the user virtual to kernel address during an intr call. You
must do this and cache the list of page numbers. (then convert the page
number to kva before doing the copy). You must also be aware that if the
buffer crosses page boundaries (i.e true virtual addr spanning pages, you
might need to do this copy multiple times.) since there is no function in
linux kernel to obtain a kva for a uva.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Kevin Pedretti
Sent: Monday, March 25, 2002 11:25 AM
To: kernelnewbies@nl.linux.org
Cc: ktpedre@sandia.gov; linux-kernel@vger.kernel.org
Subject: do_exit() and lock_kernel() semantics


Hello,
    do_exit() does a lock_kernel() before it destroys the dying
processes mm context (sets task_struct->mm to NULL in 2.4 and &init_mm
in 2.2).  Does lock_kernel() somehow disable interrupts?  It doesn't
look like it does.


Is there anyway from an interrupt context to check if a process is still
alive (not exiting) and prevent it from exiting until the ISR is over?
 I guess if lock_kernel disables interrupts globally and waits for
inprogress interrupts to complete, then this isn't a problem.


More detail:
The reason I ask is that I'm working on/modifying a set of modules that
accesses user space from interrupt context.  I know this is not a good
thing to do generally, but for performance reasons the original author
wanted to copy directly into a mlocked user space buffer from a network
receive interrupt.  Since the buffer is mlocked, it is always guaranteed
to be there and no page faults will happen (right??? I'm new at this).
 Thus, for each receive we have to convert the virt address of the
user-land receive buffer to a physical address (in the kernel region)
before doing the memcpy (copy_to_user doesn't work from interrupt
context).   This all seems to work fine in practice.  However, it seems
to me that there is a race that can happen if a process is in the middle
of dying and a receive interrupt happens.  task->mm can be set to
NULL/init_mm out from under me while doing a receive (e.g. on another cpu).


Thanks for any help.

Kevin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

