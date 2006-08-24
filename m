Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWHXMAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWHXMAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWHXMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:00:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32494 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751186AbWHXMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:00:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=W+txN37BBsDdnuxLaxsNkkGSXoSHT+EN3R4Aoe1wb06xq6Mtlcio4/UrKiggrxsngnrexkxaquEM7Fh4KmO9nEGUkYEEWFsifXyi+nzfJzTLm7/5Up15H1LderNLwxBPwGNz7dcguEKPS1opxU4ldmCvjJ0fSzjwHBsuHwplpJY=
Date: Thu, 24 Aug 2006 14:00:01 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Amnon Shiloh <amnons@cs.huji.ac.il>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@osdl.org,
       gregkh@suse.de
Subject: [2.6.18 patch] fix mem_write return value (was: Re: bug report: mem_write)
Message-ID: <20060824140001.GE1543@slug>
References: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 11:25:37AM +0300, Amnon Shiloh wrote:
> Hi,
> 
> Alright, I know that "mem_write" (fs/proc/base.c) is a "security hazard",
> but I need to use it anyway (as super-user only), and find it broken,
> somewhere between Linux-2.6.17 and Linux-2.6.18-rc4.
> 
> The point is that in the beginning of the routine, "copied" is set to 0,
> but it is no good because in lines 805 and 812 it is set to other values.
> Finally, the routine returns as if it copied 12 (=ENOMEM) bytes less than
> it actually did.
True, it looks like the faulty commit is: de7587343bfebc186995ad294e3de0da382eb9bc

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=99f895518368252ba862cc15ce4eb98ebbe1bec6;hp=8578cea7509cbdec25b31d08b48a92fcc3b1a9e3

The attached patch should fix it. Maybe that should go to 2.6.18.
Thanks for the bug report,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- fs/proc/base.c.orig	2006-08-24 13:57:22.000000000 +0200
+++ fs/proc/base.c	2006-08-24 13:57:10.000000000 +0200
@@ -797,7 +797,7 @@
 static ssize_t mem_write(struct file * file, const char * buf,
 			 size_t count, loff_t *ppos)
 {
-	int copied = 0;
+	int copied;
 	char *page;
 	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
 	unsigned long dst = *ppos;
@@ -814,6 +814,7 @@
 	if (!page)
 		goto out;
 
+	copied = 0;
 	while (count > 0) {
 		int this_len, retval;
 
