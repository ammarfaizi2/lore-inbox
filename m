Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVJDWRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVJDWRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVJDWRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:17:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:3253 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965011AbVJDWRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:17:09 -0400
Subject: Re: clock skew on B/W G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc <marvin24@gmx.de>
Cc: Rune Torgersen <runet@innovsys.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200510040814.07188.marvin24@gmx.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
	 <200510040814.07188.marvin24@gmx.de>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 08:14:54 +1000
Message-Id: <1128464094.6417.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 08:14 +0200, Marc wrote:
> Hi,
> 
> given that this option causes problems on non i386 systems, may I propose to 
> mark CONFIG_HZ as broken on these architectures and/or use a default value of 
> 1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

The problem is indeed in via_calibrate_decr(). This routine works on
HZ/100 so it will not do any good with HZ not beeing a multiple of 100.

Can you test this patch ?

Index: linux-work/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-09-22 14:06:18.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_time.c	2005-10-05 08:14:17.000000000 +1000
@@ -195,7 +195,7 @@
 		;
 	dend = get_dec();
 
-	tb_ticks_per_jiffy = (dstart - dend) / (6 * (HZ/100));
+	tb_ticks_per_jiffy = (dstart - dend) / ((6 * HZ)/100);
 	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
 
 	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",


