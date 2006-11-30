Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031389AbWK3U3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031389AbWK3U3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031392AbWK3U3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:29:45 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:11233
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031389AbWK3U3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:29:44 -0500
Date: Thu, 30 Nov 2006 12:29:46 -0800 (PST)
Message-Id: <20061130.122946.44938798.davem@davemloft.net>
To: dev@sw.ru
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [SPARC64]: resumable error decoding
From: David Miller <davem@davemloft.net>
In-Reply-To: <45642430.6030009@sw.ru>
References: <45630257.9070308@openvz.org>
	<20061121.161158.63124759.davem@davemloft.net>
	<45642430.6030009@sw.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@sw.ru>
Date: Wed, 22 Nov 2006 13:19:28 +0300

> > I should add proper support for this, this report is a good reminder
> > :-)
> would be nice :@)

I tested the following patch and it worked fine for me on a T2000, let
me know if it works for you too:

commit 035f09edbbc921b9688a65ec58c0f49b822e605c
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Nov 29 21:16:21 2006 -0800

    [SPARC64]: Run ctrl-alt-del action for sun4v powerdown request.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index ec7a601..ad67784 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/sched.h>  /* for jiffies */
+#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/kallsyms.h>
 #include <linux/signal.h>
@@ -1873,6 +1873,16 @@ void sun4v_resum_error(struct pt_regs *r
 
 	put_cpu();
 
+	if (ent->err_type == SUN4V_ERR_TYPE_WARNING_RES) {
+		/* If err_type is 0x4, it's a powerdown request.  Do
+		 * not do the usual resumable error log because that
+		 * makes it look like some abnormal error.
+		 */
+		printk(KERN_INFO "Power down request...\n");
+		kill_cad_pid(SIGINT, 1);
+		return;
+	}
+
 	sun4v_log_error(regs, &local_copy, cpu,
 			KERN_ERR "RESUMABLE ERROR",
 			&sun4v_resum_oflow_cnt);
