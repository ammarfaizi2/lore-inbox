Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVCYB0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVCYB0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVCYBZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:25:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:34241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261413AbVCYBVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:21:39 -0500
Date: Thu, 24 Mar 2005 17:21:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
Cc: coywolf@gmail.com, coywolf@sosdg.org, linux-kernel@vger.kernel.org,
       james4765@cwazy.co.uk
Subject: Re: [patch] oom-killer sysrq-f fix
Message-Id: <20050324172127.110e9dd4.akpm@osdl.org>
In-Reply-To: <424363BB.80207@lovecn.org>
References: <20050325003316.GA31352@everest.sosdg.org>
	<20050324164435.4286ac5f.akpm@osdl.org>
	<424363BB.80207@lovecn.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@lovecn.org> wrote:
>
> >>--- 2.6.12-rc1-mm2/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
> >>+++ 2.6.12-rc1-mm2-cy/mm/oom_kill.c	2005-03-25 08:07:19.000000000 +0800
> >>@@ -20,6 +20,7 @@
> >> #include <linux/swap.h>
> >> #include <linux/timex.h>
> >> #include <linux/jiffies.h>
> >>+#include <linux/hardirq.h>
> >> 
> >> /* #define DEBUG */
> >> 
> >>@@ -283,6 +284,9 @@ retry:
> >> 	if (mm)
> >> 		mmput(mm);
> >> 
> >>+	if (in_interrupt())
> >>+		return;
> > 
> > 
> > That'll make the whole feature a no-op, won't it?
> 
> It won't be a no-op. I have tested it. It works well.
> I pressed sysrq-f, loging bash got killed and I had to re-login.

(looks)

OK.  But the patch is still deadlocky because we do task_lock() from
interrupt context.

> > 
> > The thing needs to be moved into process context via schedule_work().  I
> > haven't got around to it yet.
> > 
> 
> I don't think schedule_work() is a good option here.  Since sysrq-f is emergent,
> we just let oom-killer send SIGKILL in interrupt context and return.
> 
> We needn't send SIGKILL in a process context. That'll be slow and [events] may got delayed.

There isn't much choice.  It should work OK - schedule_task doesn't
allocate any memory.

keventd could be off allocating some memory somewhere, in which case it
could take some time to respond, but it isn't worth running another kernel
thread for sysrq-f.
