Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTISTvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTISTv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:51:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:51082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbTISTuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:50:02 -0400
Date: Fri, 19 Sep 2003 12:49:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       chas@cmf.nrl.navy.mil, torvalds@osdl.org, mitch@sfgoth.com
Subject: Re: [PATCH 2/13] use cpu_relax() in busy loop
Message-ID: <20030919124954.D27079@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <1063956829.5394.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063956829.5394.1.camel@laptop.fenrus.com>; from arjanv@redhat.com on Fri, Sep 19, 2003 at 09:33:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> ehmmm how about making this use mdelay instead ?
> (not to speak of maybe making it sleep, but that's a less obvious
> transformation)

I didn't want to change to sleep semantics of the call w/out better
review of spinlocks held/irq disabled, etc.  But, after feedback from
Mitch, looks like these were only called during module init/exit.  This
look ok?

thanks,
-chris

[PATCH 2/13] use schedule_timeout() instead of busy loop

Replace fore200e_spin() busy loops with schedule_timeout().

===== fore200e.c 1.19 vs edited =====
--- 1.19/drivers/atm/fore200e.c	Tue Sep  2 11:07:59 2003
+++ edited/fore200e.c	Fri Sep 19 12:24:15 2003
@@ -229,7 +229,8 @@
     u32 hb1, hb2;
 
     hb1 = fore200e->bus->read(&fore200e->cp_queues->heartbeat);
-    fore200e_spin(10);
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout(10 * HZ/1000);
     hb2 = fore200e->bus->read(&fore200e->cp_queues->heartbeat);
     
     if (hb2 <= hb1) {
@@ -244,14 +245,6 @@
 #endif 
 
 
-static void
-fore200e_spin(int msecs)
-{
-    unsigned long timeout = jiffies + MSECS(msecs);
-    while (time_before(jiffies, timeout));
-}
-
-
 static int
 fore200e_poll(struct fore200e* fore200e, volatile u32* addr, u32 val, int msecs)
 {
@@ -551,7 +544,8 @@
 fore200e_pca_reset(struct fore200e* fore200e)
 {
     writel(PCA200E_HCR_RESET, fore200e->regs.pca.hcr);
-    fore200e_spin(10);
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout(10 * HZ/1000);
     writel(0, fore200e->regs.pca.hcr);
 }
 
@@ -831,7 +825,8 @@
 fore200e_sba_reset(struct fore200e* fore200e)
 {
     fore200e->bus->write(SBA200E_HCR_RESET, fore200e->regs.sba.hcr);
-    fore200e_spin(10);
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout(10 * HZ/1000);
     fore200e->bus->write(0, fore200e->regs.sba.hcr);
 }
 
