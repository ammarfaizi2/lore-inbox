Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTHFSFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTHFSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:05:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:26090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270835AbTHFSFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:05:20 -0400
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: Mark Haverkamp <markh@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1060190104.10732.52.camel@cog.beaverton.ibm.com>
References: <200308061052.18550.Mathias.Froehlich@web.de>
	 <1060190104.10732.52.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1060193108.12048.4.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 06 Aug 2003 11:05:08 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 10:15, john stultz wrote:
> On Wed, 2003-08-06 at 01:52, Mathias Fröhlich wrote:
> > Hi,
> > 
> > You should not remove the barrier past mtrr change. If you do that, it is 
> > possible that cpu's run with inconsistent mtrrs. This can have bad 
> > sideeffects since at least the cache snooping protocol used by intel uses 
> > assumptions about the cachability of memory regions. Those information about 
> > the cachability is also taken from the mtrrs as far as I remember.
> > This intel cpu developer manual, which documented the early PII and PPro 
> > chips, recommended this algorithm. Since actual intel cpus use the same old 
> > cpu to chipset bus protocol, this old documentation most propably still 
> > applies.
> 
> Hmm. I should dig up that doc. Its a little hazy in my mind, but I think
> I understand your description. I'm glad you caught this, as I can't
> imagine the subtle bugs that might have popped up. 
> 
> Well, let me look at it again and see if I can come up with a proper
> fix. 
> 
> Thanks for the knowledgeable feedback and sanity checking!
> -john


I added an extra sync up from the caller after the last gate change so
it is the last one to touch the automatic data.

Mark.


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

