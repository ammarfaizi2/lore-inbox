Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWDFCzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWDFCzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDFCzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:55:35 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:32942 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751345AbWDFCzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:55:35 -0400
Date: Wed, 5 Apr 2006 21:56:36 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Daniel Phillips <phillips@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Message-ID: <20060406015636.GE6924@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org> <20060325010524.GA8117@ccure.user-mode-linux.org> <44343E86.30301@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44343E86.30301@google.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 03:02:46PM -0700, Daniel Phillips wrote:
> > page = alloc_page(GFP_ATOMIC);
> 
> A slightly different objection than Andrew's: this will rapidly eat up
> all the pages available for, e.g., receiving network packets, probably
> not what you want.  How about flags=0?  This will dip a little way into
> reserves but not as far as interrupts or realtime tasks, and will not
> attempt any reclaim.  (Maybe we should have a GFP define for that.)

Yeah, it's a bit non-obvious what 0 means in the twisty little maze of
GFP_ flags.

However, I do want to push the system into reclaim later.  It looks
like the only difference between 0 and GFP_ATOMIC is the use of
emergency pools, which I don't really want to exercise anyway.

> > INIT_LIST_HEAD(&unplugged->list);
> > list_add(&unplugged->list, &unplugged_pages);
> 
> You don't need to initialize the list element you are adding.

This look OK to you?

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-04-03 18:05:29.000000000 -0400
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-04-05 22:54:17.000000000 -0400
@@ -87,7 +87,11 @@ static irqreturn_t mconsole_interrupt(in
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
 		else {
-			new = kmalloc(sizeof(*new), GFP_ATOMIC);
+			/* 0 means don't wait (like GFP_ATOMIC) and
+			 * don't dip into emergency pools (unlike
+			 * GFP_ATOMIC).
+			 */
+			new = kmalloc(sizeof(*new), 0);
 			if(new == NULL)
 				mconsole_reply(&req, "Out of memory", 1, 0);
 			else {
@@ -415,7 +419,6 @@ static int mem_config(char *str)
 
 			unplugged = page_address(page);
 			if(unplug_index == UNPLUGGED_PER_PAGE){
-				INIT_LIST_HEAD(&unplugged->list);
 				list_add(&unplugged->list, &unplugged_pages);
 				unplug_index = 0;
 			}
@@ -655,7 +658,6 @@ static void with_console(struct mc_reque
 	struct mconsole_entry entry;
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&entry.list);
 	entry.request = *req;
 	list_add(&entry.list, &clients);
 	spin_lock_irqsave(&console_lock, flags);

				Jeff
