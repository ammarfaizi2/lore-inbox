Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137205AbREKS1Q>; Fri, 11 May 2001 14:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137203AbREKS1H>; Fri, 11 May 2001 14:27:07 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:35078 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S137204AbREKS0w>;
	Fri, 11 May 2001 14:26:52 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Backport of 2.4 ptrace flag to 2.2
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 11 May 2001 13:26:50 -0500
Message-ID: <cpxeltvoi6t.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Alan Cox <alan@lxorguk.ukuu.org.uk> writes: 
> > The preferable one for performance is certainly to backport the
> > 2.4 changes 

This patch against stock 2.2.19 is a backport of the task structure
ptrace flag of Linux 2.4.

It is available at
http://www.cs.wisc.edu/~zandy/ptrace

As we reported a couple weeks ago, under Linux 2.2 ptrace can globally
corrupt the FPU on SMPs.  Linus identified the problem as a race
between ptrace and the FPU trap handler over the process flags.  The
ptrace flag introduced in 2.4 eliminates the race.

This port is faithful to the 2.4 design.  Essentially it:

 - Adds a new variable `ptrace' to the task structure;
 - Adds new constants for this variable (PT_PTRACED etc.) and removes
   the corresponding old ones (PF_PTRACED etc.);
 - Replaces every ptrace-context reference to `flags' with a reference
   to `ptrace', and updates the constants used accordingly;
 - Updates ptrace offset constants, loads, and comparisons in assembly
   files.

The patch is complete for all platforms except ARM.  On ARM, I didn't
understand the meaning of the offset constants used in the assembly,
so I didn't try to fix them.  The patch does include the necessary
changes to C files on ARM.

We have applied (cleanly), compiled (cleanly) and tested the patch on
an x86 SMP, one of the same ones on which we saw FPU corruption.  We
have verified that FPU corruption cannot be produced, and that gdb and
strace still function.  We have not tested any other platform.

Please direct any questions or problems with the patch to
Victor Zandy <zandy@cs.wisc.edu>.
