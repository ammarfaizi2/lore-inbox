Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUHZRYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUHZRYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUHZRUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:20:52 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:59558 "EHLO
	mwinf0208.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269235AbUHZQ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:58:09 -0400
Date: Thu, 26 Aug 2004 19:02:14 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Zarakin <zarakin@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
Message-ID: <20040826170214.GA580@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net> <20040825160107.GA562@zaniah> <005401c48b1b$fae38890$6401a8c0@novustelecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401c48b1b$fae38890$6401a8c0@novustelecom.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 at 20:22 +0000, Zarakin wrote:

> > try this patch please.
 
> It worked, my machine boots now fine with nmi_watchdog=2.
> 
> I can also confirm that oprofile is broken due to the missing
> MSR_P4_IQ_ESCR0/1:
> http://marc.theaimsgroup.com/?l=oprofile-list&m=109323108114060&w=2
> 

gahh, I missed this mail...

try this patch for oprofile I'll appreciate a lot if you can test with
an UP and a SMP with HT enabled kernel. I tested the patch only with
model = 2 P4 with an HT kernel. I don't see any other user of these
two msr in oprofile nor in kernel.

regards, phe.

--- linux-2.5/arch/i386/oprofile/op_model_p4.c.old	2004-08-25 20:00:56.000000000 +0200
+++ linux-2.5/arch/i386/oprofile/op_model_p4.c	2004-08-25 21:46:14.000000000 +0200
@@ -419,9 +419,28 @@
 		msrs->controls[i].addr = addr;
 	}
 	
-	/* 43 ESCR registers in three discontiguous group */
+	/* 43 ESCR registers in three or four discontiguous group */
 	for (addr = MSR_P4_BSU_ESCR0 + stag;
-	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) { 
+	     addr < MSR_P4_IQ_ESCR0; ++i, addr += addr_increment()) {
+		msrs->controls[i].addr = addr;
+	}
+
+	/* no IQ_ESCR0/1 on some models, we save a seconde time BSU_ESCR0/1
+	 * to avoid special case in nmi_{save|restore}_registers() */
+	if (boot_cpu_data.x86_model >= 0x3) {
+		for (addr = MSR_P4_BSU_ESCR0 + stag;
+		     addr <= MSR_P4_BSU_ESCR1; ++i, addr += addr_increment()) {
+			msrs->controls[i].addr = addr;
+		}
+	} else {
+		for (addr = MSR_P4_IQ_ESCR0 + stag;
+		     addr <= MSR_P4_IQ_ESCR1; ++i, addr += addr_increment()) {
+			msrs->controls[i].addr = addr;
+		}
+	}
+
+	for (addr = MSR_P4_RAT_ESCR0 + stag;
+	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += addr_increment()) {
 		msrs->controls[i].addr = addr;
 	}
 	


