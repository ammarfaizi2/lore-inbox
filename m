Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312348AbSCYTbU>; Mon, 25 Mar 2002 14:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312353AbSCYTbK>; Mon, 25 Mar 2002 14:31:10 -0500
Received: from lakemtao02.cox.net ([68.1.17.243]:8367 "EHLO lakemtao02.cox.net")
	by vger.kernel.org with ESMTP id <S312348AbSCYTbB>;
	Mon, 25 Mar 2002 14:31:01 -0500
Message-ID: <3C9F7993.7050205@sandia.gov>
Date: Mon, 25 Mar 2002 11:25:07 -0800
From: Kevin Pedretti <ktpedre@sandia.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernelnewbies@nl.linux.org
CC: ktpedre@sandia.gov, linux-kernel@vger.kernel.org
Subject: do_exit() and lock_kernel() semantics
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

