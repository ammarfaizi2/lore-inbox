Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVCYAwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVCYAwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCYAui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:50:38 -0500
Received: from everest.2mbit.com ([24.123.221.2]:38347 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261322AbVCYAdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:33:18 -0500
Date: Thu, 24 Mar 2005 19:33:16 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: linux-kernel@vger.kernel.org
Cc: james4765@cwazy.co.uk, akpm@osdl.org
Subject: [patch] oom-killer sysrq-f fix
Message-ID: <20050325003316.GA31352@everest.sosdg.org>
Reply-To: coywolf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

akpm, I saw you noticed it,
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0424.html

Jim Nelson, this patch is to your post: 2.6.11-rc2-mm2 - kernel panic with SysRq-f 

Recent make-sysrq-f-call-oom_kill.patch calls oom-killer in interrupt context,
thus results into panic. This patch fixes out_of_memory() to avoid schedule
when in interrupt context.

	Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>

diff -pruN 2.6.12-rc1-mm2/mm/oom_kill.c 2.6.12-rc1-mm2-cy/mm/oom_kill.c
--- 2.6.12-rc1-mm2/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
+++ 2.6.12-rc1-mm2-cy/mm/oom_kill.c	2005-03-25 08:07:19.000000000 +0800
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/hardirq.h>
 
 /* #define DEBUG */
 
@@ -283,6 +284,9 @@ retry:
 	if (mm)
 		mmput(mm);
 
+	if (in_interrupt())
+		return;
+
 	/*
 	 * Give "p" a good chance of killing itself before we
 	 * retry to allocate memory.
