Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264818AbUEYJVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264818AbUEYJVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEYJVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:21:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44994 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264818AbUEYJVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:21:42 -0400
Date: Tue, 25 May 2004 12:32:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040525103238.GA4212@elte.hu>
References: <20040524062754.GO1833@holomorphy.com> <20040524063959.5107.qmail@web90007.mail.scd.yahoo.com> <20040524005331.71465614.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524005331.71465614.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> But if you _are_ using poll_idle() and if your CPU is hyperthreaded
> then yes, one "CPU" is going to take a performance hit from the "idle"
> one.

with the patch below we will print a big fat warning. (I did not want to
deny idle=poll altogether - future HT implementations might work fine
with polling idle.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/process.c.orig	
+++ linux/arch/i386/kernel/process.c	
@@ -202,6 +202,10 @@ static int __init idle_setup (char *str)
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
 		pm_idle = poll_idle;
+#ifdef CONFIG_SMP
+		if (smp_num_siblings > 1)
+			printk("WARNING: polling idle and HT enabled, performance may degrade.\n");
+#endif
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
 		pm_idle = default_idle;
