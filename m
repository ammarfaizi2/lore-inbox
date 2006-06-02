Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWFBIif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWFBIif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWFBIif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:38:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:49744 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751332AbWFBIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:38:34 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45892062:sNHT16019388"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "'Chris Mason'" <mason@suse.com>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 01:38:34 -0700
Message-ID: <000301c6861f$efc4d440$0b4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGGZ6xDnfZeslYTWiDnrlLZQQNOQABfhsQ
In-Reply-To: <447FEE6C.7000408@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Friday, June 02, 2006 12:53 AM
> Con Kolivas wrote:
> 
> >>Nice to acknowledge Chris's idea for 
> >>trylocks in your changelog when you submit a final patch.
> > 
> > 
> > I absolutely would and I would ask for him to sign off on it as well, once we 
> > agreed on a final form.
> 
> This is a small micro-optimisation / cleanup we can do after
> smtnice gets converted to use trylocks. Might result in a little
> less cacheline footprint in some cases.


Just to pile up more micro-optimization: kernel can break out of the
for_each_domain loop when it hits first SD_SHARE_CPUPOWER.

- Ken


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./kernel/sched.c.orig	2006-06-01 23:14:47.000000000 -0700
+++ ./kernel/sched.c	2006-06-01 23:18:07.000000000 -0700
@@ -2780,8 +2780,10 @@ static int dependent_sleeper(int this_cp
 	int ret = 0, i;
 
 	for_each_domain(this_cpu, tmp)
-		if (tmp->flags & SD_SHARE_CPUPOWER)
+		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
+			break;
+		}
 
 	if (!sd)
 		return 0;

