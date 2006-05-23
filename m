Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWEWLBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWEWLBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWEWLBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 07:01:46 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14258 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932170AbWEWLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 07:01:45 -0400
Date: Tue, 23 May 2006 20:03:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com, ktokunag@redhat.com,
       ashok.raj@intel.com, akpm@osdl.org
Subject: [RFC][PATCH] node hotplug [3/3] register_node fix
Message-Id: <20060523200315.4d08e4ab.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

create symblic link from newly-added-node to its cpus.

Ideally, node should be onlined before cpu-hot-add. But it cannot be
always achieved (at node-hot-add.)

This patch registers cpus to its node when the node is registered.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 drivers/base/node.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.17-rc4-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/base/node.c	2006-05-23 19:21:26.000000000 +0900
+++ linux-2.6.17-rc4-mm3/drivers/base/node.c	2006-05-23 19:27:27.000000000 +0900
@@ -227,6 +227,7 @@
 int register_one_node(int nid)
 {
 	int error = 0;
+	int cpu;
 
 	if (node_online(nid)) {
 		int p_node = parent_node(nid);
@@ -236,6 +237,12 @@
 			parent = &node_devices[p_node];
 
 		error = register_node(&node_devices[nid], nid, parent);
+
+		/* link cpu under this node */
+		for_each_present_cpu(cpu) {
+			if (cpu_to_node(cpu) == nid)
+				register_cpu_under_node(cpu, nid);
+		}
 	}
 
 	return error;

