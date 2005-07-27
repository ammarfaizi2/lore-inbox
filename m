Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVG0Bka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVG0Bka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVG0Bka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:40:30 -0400
Received: from science.horizon.com ([192.35.100.1]:21806 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262229AbVG0Bk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:40:28 -0400
Date: 26 Jul 2005 21:40:27 -0400
Message-ID: <20050727014027.25283.qmail@science.horizon.com>
From: linux@horizon.com
To: 76306.1226@compuserve.com
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since fxsave leaves the FPU state intact, there ought to be a better way
> to do this but it gets tricky.  Maybe using the TSC to put a timestamp
> in every thread save area?
> 
>   when saving FPU state:
>         put cpu# and timestamp in thread state info
>         also store timestamp in per-cpu data
> 
>   on task switch:
>         compare cpu# and timestamps for next task
>         if equal, clear TS and set TS_USEDFPU
> 
>   when state becomes invalid for some reason:
>         zero cpu's timestamp
> 
> But the extra overhead might be too much in many cases.

Simpler:
- Thread has "CPU that I last used FPU on" pointer.  Never NULL.
- Each CPU has "thread whose FPU state I hold" pointer.  May be NULL.

When *loading* FPU state:
- Set up both pointers.

On task switch:
- If the pointers point to each other, then clear TS and skip restore.
  ("Preloaded")

When state becomes invalid (kernel MMX use, or whatever)
- Set CPU's pointer to NULL.

On thread creation:
- If current CPU's thread pointer points to the newly allocated thread,
  clear it to NULL.
- Set thread's CPU pointer to current CPU.

The UP case just omits the per-thread CPU pointer.  (Well, stores
it in zero bits.)

An alternative SMP thread-creation case would be to have a NULL value for
the thread-to-CPU pointer and initialize the thread's CPU pointer to that,
but that then complicates the UP case.
