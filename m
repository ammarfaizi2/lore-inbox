Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUA1CrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUA1CrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:47:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265801AbUA1CrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:47:07 -0500
Date: Tue, 27 Jan 2004 18:42:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
Message-Id: <20040127184228.3a0b8a86.akpm@osdl.org>
In-Reply-To: <40171B5B.4020601@oracle.com>
References: <40171B5B.4020601@oracle.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
>
> Already reported, but I'll do so once again, since it looks like
>   in a short while I won't be able to boot official kernels in my
>   current config...
> 
> Original report here:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0442.html

Divide by zero.  Looks like ACPI is now passing bad values into the
frequency change notifier.

Does this make the oops go away?

diff -puN drivers/cpufreq/cpufreq.c~cpufreq-workaround drivers/cpufreq/cpufreq.c
--- 25/drivers/cpufreq/cpufreq.c~cpufreq-workaround	2004-01-27 18:36:05.000000000 -0800
+++ 25-akpm/drivers/cpufreq/cpufreq.c	2004-01-27 18:36:42.000000000 -0800
@@ -928,6 +928,11 @@ void cpufreq_notify_transition(struct cp
 		return;   /* Only valid if we're in the resume process where
 			   * everyone knows what CPU frequency we are at */
 
+	if (freqs->new == 0) {
+		printk("%s: avoiding div-by-zero\n", __FUNCTION__);
+		return;
+	}
+
 	down_read(&cpufreq_notifier_rwsem);
 	switch (state) {
 	case CPUFREQ_PRECHANGE:

_

