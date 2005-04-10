Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVDJNcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDJNcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDJNcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:32:15 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:60086 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261498AbVDJNb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:31:59 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: 2.6.12-rc2-mm2
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
References: <20050408030835.4941cd98.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 15:31:55 +0200
Message-Id: <1113139915.723.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Largeish x86_64 update

Hi Pavel

I'm playing a bit with suspend on smp, we need something like this:
As the cpu-mask is set to only this cpu _smp_processor_id() is safe.

Index: linux-2.6.11/kernel/power/smp.c
===================================================================
--- linux-2.6.11.orig/kernel/power/smp.c	2005-04-10 09:43:13.000000000 +0200
+++ linux-2.6.11/kernel/power/smp.c	2005-04-10 15:23:36.000000000 +0200
@@ -46,13 +46,13 @@
 
 void disable_nonboot_cpus(void)
 {
-	printk("Freezing CPUs (at %d)", smp_processor_id());
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(0));
+	printk("Freezing CPUs (at %d)", _smp_processor_id());
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(HZ);
 	printk("...");
-	BUG_ON(smp_processor_id() != 0);
+	BUG_ON(_smp_processor_id() != 0);
 
 	/* FIXME: for this to work, all the CPUs must be running
 	 * "idle" thread (or we deadlock). Is that guaranteed? */


