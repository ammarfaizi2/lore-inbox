Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275260AbTHSAah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275261AbTHSAah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:30:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:3009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275260AbTHSAa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:30:29 -0400
Date: Mon, 18 Aug 2003 17:15:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: rddunlap@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-Id: <20030818171545.5aa630a0.akpm@osdl.org>
In-Reply-To: <20030819001316.GF22433@redhat.com>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
	<20030815173246.GB9681@redhat.com>
	<20030815123053.2f81ec0a.rddunlap@osdl.org>
	<20030816070652.GG325@waste.org>
	<20030818140729.2e3b02f2.rddunlap@osdl.org>
	<20030819001316.GF22433@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> How spooky. now I got one too, (minus the noise).
> 
> Call Trace:
>  [<c0120022>] __might_sleep+0x5b/0x5f

It would be useful to know whether this was triggered by in_atomic() or by
irqs_disabled().  We're suspecting the latter.


diff -puN kernel/sched.c~might_sleep-diags kernel/sched.c
--- 25/kernel/sched.c~might_sleep-diags	Mon Aug 18 14:09:41 2003
+++ 25-akpm/kernel/sched.c	Mon Aug 18 14:11:55 2003
@@ -2795,13 +2795,19 @@ void __might_sleep(char *file, int line)
 {
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
+	char *msg = NULL;
 
-	if (in_atomic() || irqs_disabled()) {
+	if (in_atomic())
+		msg = "in atomic section";
+	else if (irqs_disabled())
+		msg = "with interrupts disabled";
+
+	if (msg) {
 		if (time_before(jiffies, prev_jiffy + HZ))
 			return;
 		prev_jiffy = jiffies;
-		printk(KERN_ERR "Debug: sleeping function called from invalid"
-				" context at %s:%d\n", file, line);
+		printk(KERN_ERR "Debug: sleeping function "
+				"called %s at %s:%d\n", msg, file, line);
 		dump_stack();
 	}
 #endif

_

