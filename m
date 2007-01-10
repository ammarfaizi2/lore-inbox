Return-Path: <linux-kernel-owner+w=401wt.eu-S932708AbXAJEPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbXAJEPO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 23:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbXAJEPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 23:15:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57582 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932708AbXAJEPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 23:15:12 -0500
Date: Tue, 9 Jan 2007 20:15:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: mbind: Restrict nodes to the currently allowed cpuset
Message-ID: <Pine.LNX.4.64.0701092012340.18021@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently one can specify an arbitrary node mask to mbind that includes nodes
not allowed. If that is done with an interleave policy then we will go around
all the nodes. Those outside of the currently allowed cpuset will be redirected
to the border nodes. Interleave will then create imbalances at the borders
of the cpuset.

This patch restricts the nodes to the currently allowed cpuset.

The RFC for this patch was discussed at
http://marc.theaimsgroup.com/?t=116793842100004&r=1&w=2

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.19-mm1.orig/mm/mempolicy.c	2006-12-11 19:00:38.224610647 -0800
+++ linux-2.6.19-mm1/mm/mempolicy.c	2006-12-13 11:13:10.175294067 -0800
@@ -882,6 +882,7 @@ asmlinkage long sys_mbind(unsigned long 
 	int err;
 
 	err = get_nodes(&nodes, nmask, maxnode);
+	nodes_and(nodes, nodes, current->mems_allowed);
 	if (err)
 		return err;
 	return do_mbind(start, len, mode, &nodes, flags);
