Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWGLT6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWGLT6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWGLT6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:58:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8903 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932127AbWGLT6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:58:22 -0400
Date: Thu, 13 Jul 2006 01:28:21 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       mingo@elte.hu
Subject: Re: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Message-ID: <20060712195821.GB1743@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <5B0042046ADE774687F32BF3652F5BB9021C9190@kher9eaa.ww007.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B0042046ADE774687F32BF3652F5BB9021C9190@kher9eaa.ww007.siemens.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 01:35:50PM +0200, Duetsch, Thomas  LDE1 wrote:
> Hi,
> 
> I'm currently working on a custom kernel based on Ingo's -rt patch
> (2.6.16-rt29).
> 
> While rebooting my machine, I came across a kernel null pointer
> dereference in this code segment in fs/sysfs/dir.c, function
> sysfs_readdir():
> 
> 		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> 			struct sysfs_dirent *next;
> 			const char * name;
> 			int len;
> 
> 			next = list_entry(p, struct sysfs_dirent,
> 					   s_sibling);
> 			if (!next->s_element)
> 				continue;
> 
> 			name = sysfs_get_name(next);
> 			len = strlen(name);
> 			if (next->s_dentry)
> PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
> 			else
> 				ino = iunique(sysfs_sb, 2);
> 
> Checking the mailing list, I came across this thread:
> "What protection does sysfs_readdir have with SMP/Preemption?"
> http://lkml.org/lkml/2005/11/22/293
> Which handels the exact same problem (And I'm working on the kernel
> Steve was working back then).
> Reading through your suggestions and solutions, I was wondering, what
> would happen if a sysfs file would be deleted instead of created, while
> a sysfs_readdir were in progress.
> Looking through the code, I don't see, where the parents inode mutex is
> taken, to prevent a race condition.
> 
parent's inode mutex is taken in vfs_readdir() in case of sysfs_readdir() call
and in sysfs_hash_and_remove() in case of delete path.

> Unfortunately, I can't reproduce the behaviour, nor do I know, which
> file was accessed, when this happens.
> 
> Like Steve said back then, this might well be a problem in our code, but
> 
> since we didn't change the sysfs, maybe it's a vanilla problem as well.
> 

I thought at that time the issue was due to bug in error path which got
fixed by Steve's patch.

Thanks
Maneesh
