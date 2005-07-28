Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVG1XIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVG1XIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVG1XIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:08:35 -0400
Received: from fmr22.intel.com ([143.183.121.14]:36261 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261594AbVG1XId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:08:33 -0400
Message-Id: <200507282308.j6SN8Tg01993@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Thu, 28 Jul 2005 16:08:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWTyUO9l0PnRh7iTzOAjITKfBPpFg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What sort of workload needs SD_WAKE_AFFINE and SD_WAKE_BALANCE?
SD_WAKE_AFFINE are not useful in conjunction with interrupt binding.
In fact, it creates more harm than usefulness, causing detrimental
process migration and destroy process cache affinity etc.  Also
SD_WAKE_BALANCE is giving us performance grief with our industry
standard OLTP workload.

To demonstrate the problem, we turned off these two flags in the cpu
sd domain and measured a stunning 2.15% performance gain!  And deleting
all the code in the try_to_wake_up() pertain to load balancing gives us
another 0.2% gain.

The wake up patch should be made simple, just put the waking task on
the previously ran cpu runqueue.  Simple and elegant.

I'm proposing we either delete these two flags or make them run time
configurable.

- Ken



--- linux-2.6.12/include/linux/topology.h.orig	2005-07-28 15:54:05.007399685 -0700
+++ linux-2.6.12/include/linux/topology.h	2005-07-28 15:54:39.292555515 -0700
@@ -118,9 +118,7 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
-				| SD_WAKE_IDLE		\
-				| SD_WAKE_BALANCE,	\
+				| SD_WAKE_IDLE,		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\

