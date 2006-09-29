Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWI2PI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWI2PI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWI2PI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 11:08:58 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:7896 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751183AbWI2PIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 11:08:55 -0400
Date: Fri, 29 Sep 2006 10:10:54 -0500
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: openipmi-developer@lists.sourceforge.net
Subject: [PATCH] Don't start kipmid if the IPMI driver can use interrupts
Message-ID: <20060929151053.GA17272@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the driver has interrupts available to it, there is really no
reason to have a kernel daemon push the IPMI state machine.

Note that I have experienced machines where the interrupts do
not work correctly.  This was a long time ago and hopefully
things are better now.  If some machines still have broken
interrupts, a blacklist will need to be added.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.18/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_si_intf.c
@@ -916,7 +916,11 @@ static int smi_start_processing(void    
 	new_smi->last_timeout_jiffies = jiffies;
 	mod_timer(&new_smi->si_timer, jiffies + SI_TIMEOUT_JIFFIES);
 
- 	if (new_smi->si_type != SI_BT) {
+	/*
+	 * The BT interface is efficient enough to not need a thread,
+	 * and there is no need for a thread if we have interrupts.
+	 */
+ 	if ((new_smi->si_type != SI_BT) && (!new_smi->irq)) {
 		new_smi->thread = kthread_run(ipmi_thread, new_smi,
 					      "kipmi%d", new_smi->intf_num);
 		if (IS_ERR(new_smi->thread)) {
