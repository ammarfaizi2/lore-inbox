Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVGFXq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVGFXq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVGFUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:07:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60870 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261807AbVGFSj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:39:29 -0400
Date: Wed, 6 Jul 2005 20:38:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706183836.GA31269@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061814.23656.s0348365@sms.ed.ac.uk> <20050706172716.GA28755@elte.hu> <200507061923.37746.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061923.37746.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Interesting. They're both exactly 10001 jiffies apart.
>
> BUG: soft lockup detected on CPU#0! -283805--293806

yes, that's the 10 second softlockup timeout.

does the patch below help? We initialized the timestamps to 0, but with 
jiffies starting out negative, that means a ~5 minutes gap until we 
first reach a value of 0. That would explain the messages. The only 
thing it doesnt explain, why did this only trigger on your box?

	Ingo

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
@@ -16,9 +16,9 @@
 
 static DEFINE_RAW_SPINLOCK(print_lock);
 
-static DEFINE_PER_CPU(unsigned long, timeout) = 0;
-static DEFINE_PER_CPU(unsigned long, timestamp) = 0;
-static DEFINE_PER_CPU(unsigned long, print_timestamp) = 0;
+static DEFINE_PER_CPU(unsigned long, timeout) = INITIAL_JIFFIES;
+static DEFINE_PER_CPU(unsigned long, timestamp) = INITIAL_JIFFIES;
+static DEFINE_PER_CPU(unsigned long, print_timestamp) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
 
 static int did_panic = 0;
