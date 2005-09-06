Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVIFR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIFR7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVIFR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:59:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21409 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750749AbVIFR7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:59:18 -0400
Date: Tue, 6 Sep 2005 14:03:26 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: PATCH: fix disassociate_ctty vs. fork race  
Message-ID: <Pine.LNX.4.61.0509061348370.567@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

Race is as follows. Process A forks process B, both being part of the same 
session. Then, A calls disassociate_ctty while B forks C:


A				B
----				----
				fork()
				  copy_signal()
dissasociate_ctty()		....
				  attach_pid(p, PIDTYPE_SID, p->signal->session);



Now, C can have current->signal->tty pointing to a freed tty structure, as 
it hasn't yet been added to the session group (to have its controlling tty 
cleared on the diassociate_ctty() call). 
 
This has shown up as an oops but could be even more serious. I haven't 
tried to create a test case, but a customer has verified that the patch 
below resolves the issue, which was occuring quite frequently. I'll try 
and post the test case if i can.

The patch simply checks for a NULL tty *after* it has been attached to the 
proper session group and clears it as necessary. Alternatively, we could 
simply do the tty assignment after the the process is added to the proper 
session group.

thanks,

-Jason

Signed-off-by: Jason Baron <jbaron@redhat.com>

--- linux-2.6.git/kernel/fork.c.bak	2005-09-06 13:42:14.000000000 -0400
+++ linux-2.6.git/kernel/fork.c	2005-09-06 13:43:47.000000000 -0400
@@ -1115,6 +1115,9 @@ static task_t *copy_process(unsigned lon
 			__get_cpu_var(process_counts)++;
 	}
 
+	if (!current->signal->tty && p->signal->tty)
+		p->signal->tty = NULL;
+
 	nr_threads++;
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);


