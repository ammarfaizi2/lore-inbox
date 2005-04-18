Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVDRTio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVDRTio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVDRTio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:38:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30706 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262180AbVDRTil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:38:41 -0400
Date: Mon, 18 Apr 2005 14:38:33 -0500
To: paulus@samba.org, anton@samba.org
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: PATCH [PPC64]: dead processes never reaped
Message-ID: <20050418193833.GW15596@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

The patch below appears to fix a problem where a number of dead processes
linger on the system.  On a highly loaded system, dozens of processes 
were found stuck in do_exit(), calling thier very last schedule(), and
then being lost forever.  

Processes that are PF_DEAD are cleaned up *after* the context switch, 
in a routine called finish_task_switch(task_t *prev). The "prev" gets 
the  value returned by _switch() in entry.S, but this value comes from 
  
__switch_to (struct task_struct *prev, 
            struct task_struct *new) 
{ 
   old_thread = &current->thread; ///XXX shouldn't this be prev, not current? 
   last = _switch(old_thread, new_thread); 
   return last; 
} 
 
The way I see it, "prev" and "current" are almost always going to be  
pointing at the same thing; however, if a "need resched" happens,  
or there's a pre-emept or some-such, then prev and current won't be  
the same; in which case, finish_task_switch() will end up cleaning  
up the old current, instead of prev.  This will result in dead processes 
hanging around, which will never be scheduled again, and will never  
get a chance to have put_task_struct() called on them.  

This patch fixes this.

Signed-off-by: Linas Vepstas <linas@linas.org>


--- arch/ppc64/kernel/process.c.orig	2005-04-18 14:26:42.000000000 -0500
+++ arch/ppc64/kernel/process.c	2005-04-18 14:27:54.000000000 -0500
@@ -204,7 +204,7 @@ struct task_struct *__switch_to(struct t
 	flush_tlb_pending();
 
 	new_thread = &new->thread;
-	old_thread = &current->thread;
+	old_thread = &prev->thread;
 
 	local_irq_save(flags);
 	last = _switch(old_thread, new_thread);
