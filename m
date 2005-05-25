Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVEYXUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVEYXUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVEYXUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:20:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45032 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261607AbVEYXUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:20:06 -0400
Date: Wed, 25 May 2005 16:19:55 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: [PATCH] drop note_interrupt() for per-CPU for proper scaling
Message-ID: <4295081B.MailKJ51120GH@jackhammer.engr.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: hawkes@sgi.com (John Hawkes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "unhandled interrupts" catcher, note_interrupt(), increments a global
desc->irq_count and grossly damages scaling of very large systems, e.g.,
>192p ia64 Altix, because of this highly contented cacheline, especially
for timer interrupts.  384p is severely crippled, and 512p is unuseable.

All calls to note_interrupt() can be disabled by booting with "noirqdebug",
but this disables the useful interrupt checking for all interrupts.

I propose eliminating note_interrupt() for all per-CPU interrupts.
This was the behavior of linux-2.6.10 and earlier, but in 2.6.11 a
code restructuring added a call to note_interrupt() for per-CPU interrupts.
Besides, note_interrupt() is a bit racy for concurrent CPU calls anyway,
as the desc->irq_count++ increment isn't atomic (which, if done, would make
scaling even worse).

Signed-off-by: John Hawkes <hawkes@sgi.com>
---

Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c	2005-03-01 23:38:37.000000000 -0800
+++ linux/kernel/irq/handle.c	2005-05-18 11:02:18.000000000 -0700
@@ -118,8 +118,6 @@
 		 */
 		desc->handler->ack(irq);
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
 		desc->handler->end(irq);
 		return 1;
 	}
