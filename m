Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTD3T6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTD3T6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:58:25 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:10817 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262351AbTD3T6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:58:23 -0400
Date: Wed, 30 Apr 2003 16:08:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: desc v0.61 found a 2.5 kernel bug
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304301610_MC3-1-36BC-C42@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

>>   I want to write a TSS-based debug exception handler that just does
>> an iret when it gets invoked.  For now it looks easier to just keep
>> CR3 up-to-date on every switch.
>
> It seems cr3 is in the same cache line as esp0 for a 32 byte cache line, 
> so it's not that big a deal, but I'd still try to avoid this.

 There's no easy way of fixing this up in the handler, so that's the plan
for now.  It also puts more info in the TSS dump right away.

.> Currently %fs and %gs are lazily cleaned up when switching processes
.> using the standard fixup mechanism, %ds and %es are cleaned up if
.> necessary when popping them off the stack in the return to user
.> mode path (the one which ends up in iret). There is no way to recover
.> from bad user %cs/%ss, the process simply exits in the iret fixup.

 Looks like the only clean way is to follow the TSS back link and manually
validate the segment registers before returning:

  invalid FS,GS -> 0
     "    DS,ES -> __USER_DS
          CS,SS -> panic?

 Bad things can happen if a debug fault happens in certain places... for now
the solution is to only support int3 breakpoints and avoid those places.

 Given the above, I hope to be able to put int3 instructions in either
kernel or user code and get snapshots of CPU state in the kernel TSS.
------
 Chuck
