Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275361AbTHGOjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275354AbTHGOiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:38:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:8371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275353AbTHGOiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:38:15 -0400
Subject: [PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <1060192965.10732.58.camel@cog.beaverton.ibm.com>
References: <200308061052.18550.Mathias.Froehlich@web.de>
	 <1060190104.10732.52.camel@cog.beaverton.ibm.com>
	 <1060193108.12048.4.camel@markh1.pdx.osdl.net>
	 <1060192965.10732.58.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1060267092.24115.8.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 07 Aug 2003 07:38:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 11:02, john stultz wrote:
> On Wed, 2003-08-06 at 11:05, Mark Haverkamp wrote:
> > On Wed, 2003-08-06 at 10:15, john stultz wrote:
> > > 
> > > Well, let me look at it again and see if I can come up with a proper
> > > fix. 
> > I added an extra sync up from the caller after the last gate change so
> > it is the last one to touch the automatic data.
> 
> Ah, you beat me to it! 
> 
> I'm actually testing the very same change (comments differ a touch, but
> that's ok).
> 
> Looks good. If everyone is happy I'd say resubmit it to Andrew.
> 
> thanks
> -john

I'd like to submit this patch for inclusion.  It adds an extra sync up
in set_mtrr and ipi_handler to make sure that set_mtrr is the last to
touch the automatic set_mtrr_data.


===== arch/i386/kernel/cpu/mtrr/main.c 1.29 vs edited =====
--- 1.29/arch/i386/kernel/cpu/mtrr/main.c	Tue Jul 15 10:08:48 2003
+++ edited/arch/i386/kernel/cpu/mtrr/main.c	Wed Aug  6 10:46:00 2003
@@ -169,6 +169,7 @@
 		cpu_relax();
 		barrier();
 	}
+	atomic_dec(&data->count);
 	local_irq_restore(flags);
 }
 
@@ -256,8 +257,18 @@
 		cpu_relax();
 		barrier();
 	}
-	local_irq_restore(flags);
+	atomic_set(&data.count, num_booting_cpus() - 1);
 	atomic_set(&data.gate,0);
+
+	/* 
+	 * Wait here for everyone to have seen the gate change
+	 * So we're the last ones to touch 'data'
+	 */
+	while(atomic_read(&data.count)) {
+		cpu_relax();
+		barrier();
+	}
+	local_irq_restore(flags);
 }
 
 /**


-- 
Mark Haverkamp <markh@osdl.org>

