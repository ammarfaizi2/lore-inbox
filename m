Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTIUOkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTIUOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:40:10 -0400
Received: from mail-6.tiscali.it ([195.130.225.152]:51315 "EHLO
	mail-6.tiscali.it") by vger.kernel.org with ESMTP id S261885AbTIUOkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:40:06 -0400
Date: Sun, 21 Sep 2003 16:39:34 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix Athlon MCA
Message-ID: <20030921143934.GA1867@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
on boot I'm seeing a lot of messages like this:

MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: d47fa0000000bfee

This messages go away if I revert cset 1.1119.9.1. AFAIK you were trying
to decrease the logging level. After reading IA32 Architecture Software 
Developers Manual, vol3 - chapter 14.5 "Machine-Check Initialization" I 
think that the right way to do it is this:

--- linux-2.6/arch/i386/kernel/cpu/mcheck/k7.c~	Sat Aug  9 06:37:27 2003
+++ linux-2.6/arch/i386/kernel/cpu/mcheck/k7.c	Sun Sep 21 00:36:39 2003
@@ -81,8 +81,9 @@
 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	nr_mce_banks = l & 0xff;
 
-	for (i=1; i<nr_mce_banks; i++) {
-		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+	for (i=0; i<nr_mce_banks; i++) {
+		if (i)
+			wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
 	}
 

We really want to clean all MC*_STATUS. I'm currently running linux 2.6.0-t5
+ this patch and I don't see the MCE messages on boot anymore. 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."
