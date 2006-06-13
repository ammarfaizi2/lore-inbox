Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932856AbWFMEEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWFMEEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWFMEEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:04:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:10131 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932856AbWFMEED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:04:03 -0400
From: Andi Kleen <ak@suse.de>
To: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [BUG] safe_smp_process_id() uses apicid which exceeds NR_CPUs in array
Date: Tue, 13 Jun 2006 06:03:32 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060612223827.33255.qmail@web50103.mail.yahoo.com>
In-Reply-To: <20060612223827.33255.qmail@web50103.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606130603.32958.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I noticed the:   if (x86_cpu_to_apicid[apicid] == apicid)
> above.

You're right - the fast check should either check for >= NR_CPUS 
or just be removed and let it be done by the loop. I came up
with this patch.

Thanks.

-Andi

Fix fast check in safe_smp_processor_id

The APIC ID returned by hard_smp_processor_id can be beyond
NR_CPUS and then overflow the x86_cpu_to_apic[] array.

Add a check for overflow. If it happens then the slow loop below
will catch.

Bug pointed out by Doug Thompson
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/smp.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smp.c
+++ linux/arch/x86_64/kernel/smp.c
@@ -520,13 +520,13 @@ asmlinkage void smp_call_function_interr
 
 int safe_smp_processor_id(void)
 {
-	int apicid, i;
+	unsigned apicid, i;
 
 	if (disable_apic)
 		return 0;
 
 	apicid = hard_smp_processor_id();
-	if (x86_cpu_to_apicid[apicid] == apicid)
+	if (apicid < NR_CPUS && x86_cpu_to_apicid[apicid] == apicid)
 		return apicid;
 
 	for (i = 0; i < NR_CPUS; ++i) {
