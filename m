Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVKARmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVKARmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVKARmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:42:02 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34217 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751039AbVKARmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:42:00 -0500
Date: Tue, 1 Nov 2005 09:39:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 5/5] Swap Migration V5: sys_migrate_pages interface
In-Reply-To: <20051031212742.3e43c829.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511010939070.16224@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
 <20051101031305.12488.1224.sendpatchset@schroedinger.engr.sgi.com>
 <20051031212742.3e43c829.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> > +	 * Permissions check like for signals.
> > +	 * See check_kill_permission()
> Obscure.  Can you please explain the thinking behind putting this check in
> here?  Preferably via a comment...
> 

Index: linux-2.6.14-rc5-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/mempolicy.c	2005-11-01 09:32:46.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/mempolicy.c	2005-11-01 09:38:46.000000000 -0800
@@ -790,8 +790,15 @@ asmlinkage long sys_migrate_pages(pid_t 
 		return -EINVAL;
 
 	/*
-	 * Permissions check like for signals.
-	 * See check_kill_permission()
+	 * We only allow a process to move the pages of another
+	 * if the process issuing sys_migrate has the right to send a kill
+	 * signal to the process to be moved. Moving another processes
+	 * memory may impact the performance of that process. If the
+	 * process issuing sys_migrate_pages has the right to kill the
+	 * target process then obviously that process has the right to
+	 * impact the performance of the target process.
+	 *
+	 * The permission check was taken from  check_kill_permission()
 	 */
 	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
 	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
