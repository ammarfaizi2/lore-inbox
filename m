Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSHAUNf>; Thu, 1 Aug 2002 16:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSHAUNf>; Thu, 1 Aug 2002 16:13:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46023 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316957AbSHAUNe>; Thu, 1 Aug 2002 16:13:34 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208012016.g71KGwK27981@devserv.devel.redhat.com>
Subject: Accelerating user mode linux
To: linux-kernel@vger.kernel.org
Date: Thu, 1 Aug 2002 16:16:58 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Proposal for a sigaltmm()

There is a problem with performance when running virtualised environments
(notably user mode linux). The performance of the mprotect calls needed to 
handle syscalls and protect the UML kernel from its user space are large and
the alternatives like a seperate process and ptrace are not pretty either

The cunning plan goes like this

Add
	current->alt_mm
	A per task flag for 'supervisory' mode


Tasks start with current->alt_mm NULL and the flag set to supervisory
On exec/exit tear down alt_mm as well as mm

Signal delivery checks if alt_mm != NULL && supervisory is clear
if so it sets supervisory and switches mm/alt_mm, flush the tlb and 
continue handling the signal in the new space

We add
	sys_switchmm(address);

This switches to the altmm (creating one if it doesnt exist as a copy of
the current mm), flushes the tlb and jumps to the address given.

Any opinions, spanners to throw in the works ?

Alan
