Return-Path: <linux-kernel-owner+w=401wt.eu-S965014AbXALTZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbXALTZP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbXALTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:25:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42932 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965014AbXALTZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:25:13 -0500
Date: Fri, 12 Jan 2007 11:25:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: Paul Jackson <pj@sgi.com>, sander@humilis.net,
       linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
In-Reply-To: <20070112032820.9c995718.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112105224.GA12813@favonius>
 <20070112032820.9c995718.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Paul Jackson wrote:

> I'll leave the honors to Christoph (added to CC), since this is his patch.

Ok. Here it is

mems_allowed only exists if CONFIG_CPUSETS is set. So put an #ifdef around
it. Also move the masking of the nodes behind the error check (looks 
better) and add a comment.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/mm/mempolicy.c	2007-01-12 13:20:17.000000000 -0600
+++ linux-2.6.20-rc4-mm1/mm/mempolicy.c	2007-01-12 13:21:30.220968608 -0600
@@ -882,9 +882,12 @@ asmlinkage long sys_mbind(unsigned long 
 	int err;
 
 	err = get_nodes(&nodes, nmask, maxnode);
-	nodes_and(nodes, nodes, current->mems_allowed);
 	if (err)
 		return err;
+#ifdef CONFIG_CPUSETS
+	/* Restrict the nodes to the allowed nodes in the cpuset */
+	nodes_and(nodes, nodes, current->mems_allowed);
+#endif
 	return do_mbind(start, len, mode, &nodes, flags);
 }
 
