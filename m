Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVA2Qra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVA2Qra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVA2Qra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:47:30 -0500
Received: from fsmlabs.com ([168.103.115.128]:15798 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261405AbVA2QrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:47:22 -0500
Date: Sat, 29 Jan 2005 09:47:42 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Levon <levon@movementarian.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OProfile: Fix oops on undetected CPU type
In-Reply-To: <20050129140423.GA71581@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.61.0501290941180.10009@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com>
 <20050129140423.GA71581@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005, John Levon wrote:

> On Fri, Jan 28, 2005 at 12:06:19PM -0700, Zwane Mwaikambo wrote:
> 
> > ===== drivers/oprofile/oprofile_files.c 1.7 vs edited =====
> > --- 1.7/drivers/oprofile/oprofile_files.c	2005-01-04 19:48:23 -07:00
> > +++ edited/drivers/oprofile/oprofile_files.c	2005-01-28 11:36:25 -07:00
> > @@ -63,7 +63,9 @@ static struct file_operations pointer_si
> >  
> >  static ssize_t cpu_type_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
> >  {
> > -	return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
> > +	if (oprofile_ops.cpu_type)
> > +		return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
> > +	return -EIO;
> 
> This is wrong: you need to investigate why .cpu_type isn't set: in
> particular, it should have fallen back to timer mode.
> oprofile_arch_init() should have returned -ENODEV, and that should have
> set timer mode.
> 
> Unfortunately bkcvs seems out of date so I can't even look at this
> myself.

Yes you are right, i checked bk and there was a lot of shuffling about due 
to the timer override. But it looks like we're depending on the timer 
variable being set. We could always just run timer_init if cpu_type is not 
set.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

===== drivers/oprofile/oprof.c 1.11 vs edited =====
--- 1.11/drivers/oprofile/oprof.c	2005-01-04 19:48:23 -07:00
+++ edited/drivers/oprofile/oprof.c	2005-01-29 09:38:24 -07:00
@@ -157,7 +157,7 @@ static int __init oprofile_init(void)
 
 	oprofile_arch_init(&oprofile_ops);
 
-	if (timer) {
+	if (timer || !oprofile_ops.cpu_type) {
 		printk(KERN_INFO "oprofile: using timer interrupt.\n");
 		oprofile_timer_init(&oprofile_ops);
 	}
