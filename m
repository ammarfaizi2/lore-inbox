Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVDCElw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVDCElw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDCElw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:41:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32177 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261479AbVDCElt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:41:49 -0500
Date: Sat, 2 Apr 2005 20:42:05 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: paulus@au1.ibm.com, antonb@au1.ibm.com, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] add rcu_read_lock in ItLpQueue_process()
Message-ID: <20050403044204.GB1330@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I believe that the synchronize_kernel() needs a matching
rcu_read_lock() and rcu_read_unlock() pair as shown below,
along with an rcu_dereference().  Without these, I believe
that the following sequence of events could occur:

o	CPU 0 in ItLpQueue_process() tests the lpEventHandler
	element, and finds it non-NULL, proceeding into the
	"then" clause.

o	CPU 1 in HvLpEvent_unregisterHandler() sets the element
	to NULL.

o	CPU 0 picks up the lpEventHandler once more, and does
	a function call through the now-NULL pointer.

That said, there might be some higher-level locking that I missed
that prevents this...

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-rc1/arch/ppc64/kernel/ItLpQueue.c linux-2.6.12-rc1-ppcfix/arch/ppc64/kernel/ItLpQueue.c
--- linux-2.6.12-rc1/arch/ppc64/kernel/ItLpQueue.c	Tue Mar  1 23:37:48 2005
+++ linux-2.6.12-rc1-ppcfix/arch/ppc64/kernel/ItLpQueue.c	Sat Apr  2 20:36:16 2005
@@ -107,6 +107,7 @@ unsigned ItLpQueue_process( struct ItLpQ
 {
 	unsigned numIntsProcessed = 0;
 	struct HvLpEvent * nextLpEvent;
+	LpEventHandler func;
 
 	/* If we have recursed, just return */
 	if ( !set_inUse( lpQueue ) )
@@ -140,9 +141,12 @@ unsigned ItLpQueue_process( struct ItLpQ
   			 */
 			if ( nextLpEvent->xType < HvLpEvent_Type_NumTypes )
 				lpQueue->xLpIntCountByType[nextLpEvent->xType]++;
-			if ( nextLpEvent->xType < HvLpEvent_Type_NumTypes &&
-			     lpEventHandler[nextLpEvent->xType] ) 
-				lpEventHandler[nextLpEvent->xType](nextLpEvent, regs);
+			if ( nextLpEvent->xType < HvLpEvent_Type_NumTypes )
+				rcu_read_lock();
+				func = rcu_dereference(lpEventHandler[nextLpEvent->xType]);
+				if (func)
+					func(nextLpEvent, regs);
+				rcu_read_unlock();
 			else
 				printk(KERN_INFO "Unexpected Lp Event type=%d\n", nextLpEvent->xType );
 			
