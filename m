Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752152AbWCCCcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbWCCCcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWCCCcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:32:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752149AbWCCCcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:32:04 -0500
Date: Thu, 2 Mar 2006 18:30:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net, hch@lst.de
Subject: Re: [PATCH 1/15] EDAC: switch to kthread_ API
Message-Id: <20060302183035.6a15a1fc.akpm@osdl.org>
In-Reply-To: <200603021747.47515.dsp@llnl.gov>
References: <200603021747.47515.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
>   		schedule_timeout((HZ * poll_msec) / 1000);
>   		try_to_freeze();
>  +		__set_current_state(TASK_RUNNING);

schedule() and schedule_timeout*() always return in state TASK_RUNNING, so
I'll take that out of there.

We might as well use schedule_timeout_interruptible(), too.  As a bonus, we
get to delete that spelling mistake ;)


--- devel/drivers/edac/edac_mc.c~edac-switch-to-kthread_-api-tidy	2006-03-02 18:27:56.000000000 -0800
+++ devel-akpm/drivers/edac/edac_mc.c	2006-03-02 18:27:56.000000000 -0800
@@ -2042,13 +2042,9 @@ static int edac_kernel_thread(void *arg)
 	while (!kthread_should_stop()) {
 		do_edac_check();
 
-		/* ensure we are interruptable */
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		/* goto sleep for the interval */
-		schedule_timeout((HZ * poll_msec) / 1000);
+		schedule_timeout_interruptible((HZ * poll_msec) / 1000);
 		try_to_freeze();
-		__set_current_state(TASK_RUNNING);
 	}
 
 	return 0;
_

