Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVJUQe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVJUQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVJUQe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:34:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54461 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965025AbVJUQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:34:25 -0400
Date: Fri, 21 Oct 2005 09:33:20 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
cc: Paul Jackson <pj@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Simon.Derr@bull.net,
       akpm@osdl.org, kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <200510211118.10886.raybry@mpdtxmail.amd.com>
Message-ID: <Pine.LNX.4.62.0510210928030.23328@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051021081553.50716b97.pj@sgi.com> <Pine.LNX.4.62.0510210845140.23212@schroedinger.engr.sgi.com>
 <200510211118.10886.raybry@mpdtxmail.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, Ray Bryant wrote:

> That code used to be there.    Basically the check was that if you could 
> legally send a signal to the process, you could migrate its memory.
> Go back and look and my patches for this.
> 
> Why was this dropped, arbitrarily?

Sorry, it was separated out from the sys_migrate patch.

Here is the fix:

Index: linux-2.6.14-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/mm/mempolicy.c	2005-10-20 14:45:45.000000000 -0700
+++ linux-2.6.14-rc4-mm1/mm/mempolicy.c	2005-10-21 09:32:19.000000000 -0700
@@ -784,12 +784,26 @@ asmlinkage long sys_migrate_pages(pid_t 
 	if (!mm)
 		return -EINVAL;
 
+	/*
+	 * Permissions check like for signals.
+	 * See check_kill_permission()
+	 */
+	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
+	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+
 	/* Is the user allowed to access the target nodes? */
-	if (!nodes_subset(new, cpuset_mems_allowed(task)))
-		return -EPERM;
+	if (!nodes_subset(new, cpuset_mems_allowed(task)) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		err= -EPERM;
+		goto out;
+	}
 
 	err = do_migrate_pages(mm, &old, &new, MPOL_MF_MOVE);
-
+out:
 	mmput(mm);
 	return err;
 }
