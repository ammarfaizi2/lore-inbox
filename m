Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWARVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWARVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWARVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:41:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964942AbWARVlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:41:55 -0500
Date: Wed, 18 Jan 2006 13:40:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org, mingo@elte.hu,
       arjan@infradead.org
Subject: Re: 2.6.16-rc1-mm1
Message-Id: <20060118134054.6c0db90a.akpm@osdl.org>
In-Reply-To: <20060118190926.GB316@redhat.com>
References: <20060118005053.118f1abc.akpm@osdl.org>
	<43CE2210.60509@reub.net>
	<20060118032716.7f0d9b6a.akpm@osdl.org>
	<20060118190926.GB316@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> With the patch above we'll mutex_unlock twice.

I was just testing you.

>  Is that allowed ? It sounds wrong to me.

It worked!


From: Andrew Morton <akpm@osdl.org>

Make the cpufreq code play nicely with the mutex debugging code: don't free a
held mutex.

Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/cpufreq/cpufreq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN drivers/cpufreq/cpufreq.c~cpufreq-mutex-locking-fix drivers/cpufreq/cpufreq.c
--- devel/drivers/cpufreq/cpufreq.c~cpufreq-mutex-locking-fix	2006-01-18 13:37:09.000000000 -0800
+++ devel-akpm/drivers/cpufreq/cpufreq.c	2006-01-18 13:38:20.000000000 -0800
@@ -612,6 +612,7 @@ static int cpufreq_add_dev (struct sys_d
 	ret = cpufreq_driver->init(policy);
 	if (ret) {
 		dprintk("initialization failed\n");
+		mutex_unlock(&policy->lock);
 		goto err_out;
 	}
 
@@ -623,9 +624,10 @@ static int cpufreq_add_dev (struct sys_d
 	strlcpy(policy->kobj.name, "cpufreq", KOBJ_NAME_LEN);
 
 	ret = kobject_register(&policy->kobj);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&policy->lock);
 		goto err_out_driver_exit;
-
+	}
 	/* set up files for this cpu device */
 	drv_attr = cpufreq_driver->attr;
 	while ((drv_attr) && (*drv_attr)) {
_

