Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWFSBV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFSBV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWFSBV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:21:57 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:44982 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751148AbWFSBV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:21:56 -0400
Message-ID: <4495FC32.9060509@bigpond.net.au>
Date: Mon, 19 Jun 2006 11:21:54 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Srivatsa <vatsa@in.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/4] sched: Add CPU rate soft caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618082648.6061.62247.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060618082648.6061.62247.sendpatchset@heathwren.pw.nest>
Content-Type: multipart/mixed;
 boundary="------------050507060502070108030602"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Jun 2006 01:21:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507060502070108030602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As pointed out by Con Kolivas there is an error in the mutex count part 
of this code and an opportunity to increase efficiency with use of the 
likely() macro.  The attached patch addresses these issues.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050507060502070108030602
Content-Type: text/plain;
 name="fix-mutex-count"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mutex-count"

---
 kernel/mutex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: MM-2.6.17-rc6-mm2/kernel/mutex.c
===================================================================
--- MM-2.6.17-rc6-mm2.orig/kernel/mutex.c	2006-06-19 09:57:03.000000000 +1000
+++ MM-2.6.17-rc6-mm2/kernel/mutex.c	2006-06-19 09:57:55.000000000 +1000
@@ -319,7 +319,7 @@ int fastcall __sched mutex_lock_interrup
 	ret = __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_slowpath);
 
-	if (!ret)
+	if (likely(!ret))
 		inc_mutex_count();
 
 	return ret;
@@ -380,7 +380,7 @@ int fastcall __sched mutex_trylock(struc
 	int ret = __mutex_fastpath_trylock(&lock->count,
 					__mutex_trylock_slowpath);
 
-	if (!ret)
+	if (likely(ret))
 		inc_mutex_count();
 
 	return ret;

--------------050507060502070108030602--
