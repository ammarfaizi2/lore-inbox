Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754306AbWKVPCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbWKVPCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbWKVPCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:02:14 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:36810 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1754306AbWKVPCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:02:13 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [RCU] adds a prefetch() in rcu_do_batch()
Date: Wed, 22 Nov 2006 16:02:29 +0100
User-Agent: KMail/1.9.5
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <20061121224613.548207f9.akpm@osdl.org>
In-Reply-To: <20061121224613.548207f9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FaGZF/iA3Ha+VaX"
Message-Id: <200611221602.29597.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_FaGZF/iA3Ha+VaX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On some workloads, (for example when lot of close() syscalls are done), RCU 
qlen can be quite large, and RCU heads are no longer in cpu cache when 
rcu_do_batch() is called.

This patches adds a prefetch() in rcu_do_batch() to give CPU a hint to bring 
back cache lines containing 'struct rcu_head's.

Most list manipulations macros include prefetch(), but not open coded ones (at 
least with current C compilers :) )

I got a nice speedup on a trivial benchmark  (3.48 us per iteration instead of 
3.95 us on a 1.6 GHz Pentium-M)
while (1) { pipe(p); close(fd[0]); close(fd[1]);}

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_FaGZF/iA3Ha+VaX
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rcu.prefetch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="rcu.prefetch.patch"

--- linux-2.6.19-rc6/kernel/rcupdate.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-ed/kernel/rcupdate.c	2006-11-22 15:12:09.000000000 +0100
@@ -235,12 +235,14 @@ static void rcu_do_batch(struct rcu_data
 
 	list = rdp->donelist;
 	while (list) {
-		next = rdp->donelist = list->next;
+		next = list->next;
+		prefetch(next);
 		list->func(list);
 		list = next;
 		if (++count >= rdp->blimit)
 			break;
 	}
+	rdp->donelist = list;
 
 	local_irq_disable();
 	rdp->qlen -= count;

--Boundary-00=_FaGZF/iA3Ha+VaX--
