Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUFIWzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUFIWzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUFIWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:55:44 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46038 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266178AbUFIWz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:55:27 -0400
Date: Wed, 9 Jun 2004 15:55:10 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-Id: <20040609155510.3ad48776.pj@sgi.com>
In-Reply-To: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or ... pushing the point further ... one _could_ remove the old_mask as
well.  However I think this makes the code less clear, even if it does
save a stack copy of a cpumask_t.  So I'm of mixed feelings on this
patch, edging slightly toward negative.  Same utter lack of testing as
the previous patch.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc3-mm1/drivers/perfctr/virtual.c
===================================================================
--- 2.6.7-rc3-mm1.orig/drivers/perfctr/virtual.c	2004-06-09 15:38:32.000000000 -0700
+++ 2.6.7-rc3-mm1/drivers/perfctr/virtual.c	2004-06-09 15:53:06.000000000 -0700
@@ -403,14 +403,14 @@
 		return -EFAULT;
 
 	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
-		cpumask_t old_mask, new_mask;
+		cpumask_t new_mask;
 
-		old_mask = tsk->cpus_allowed;
-		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);
+		cpus_andnot(new_mask, tsk->cpus_allowed,
+						perfctr_cpus_forbidden_mask);
 
 		if (cpus_empty(new_mask))
 			return -EINVAL;
-		if (!cpus_equal(new_mask, old_mask))
+		if (!cpus_equal(tsk->cpus_allowed, new_mask))
 			set_cpus_allowed(tsk, new_mask);
 	}
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
