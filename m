Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVD2MJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVD2MJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 08:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVD2MJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 08:09:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:39371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbVD2MJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 08:09:13 -0400
Date: Fri, 29 Apr 2005 05:08:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Message-Id: <20050429050833.6b3d805b.akpm@osdl.org>
In-Reply-To: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt> wrote:
>
> We've made some changes on our ftp server, and since that it's been crashing 
>  frequently (everyday) with a kernel panic. 
> 
>  We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM on top 
>  of that. All filesystems are reiserfs. The other change we made to the server 
>  was changing from a patched 2.6.10-ac12 kernel into a newer 2.6.11.7.
> 
>  Not being able to see the whole stacktrace on screen, we've started a 
>  netconsole to investigate. Started the server and loaded it pretty bad with 
>  rsyncs and such... until it crashed after just 20 minutes.
> 
>  The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"

Strange.  It'd be interesting to try disabling CONFIG_4KSTACKS.  Also,
please add this to get a bit more info.

diff -puN kernel/sched.c~a kernel/sched.c
--- 25/kernel/sched.c~a	2005-04-29 05:05:24.792004408 -0700
+++ 25-akpm/kernel/sched.c	2005-04-29 05:06:36.015176840 -0700
@@ -2631,7 +2631,12 @@ void fastcall add_preempt_count(int val)
 	/*
 	 * Underflow?
 	 */
-	BUG_ON(((int)preempt_count() < 0));
+	if ((int)preempt_count() < 0) {
+		printk("preempt_count=%d\n", preempt_count());
+		BUG();
+	}
+	if ((int)preempt_count() > 1000)
+		printk("preempt_count=%d\n", preempt_count());
 	preempt_count() += val;
 	/*
 	 * Spinlock count overflowing soon?
_

