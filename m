Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUFIWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUFIWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUFIWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:48:56 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41149 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266143AbUFIWsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:48:41 -0400
Date: Wed, 9 Jun 2004 15:47:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-Id: <20040609154750.241df741.pj@sgi.com>
In-Reply-To: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Clean up perfctr/virtual by using the new cpus_andnot() operation

Neat.

Do you still need "tmp" ?  Perhaps you could further add the
following patch (untested, unbuilt, ...).

This saves copies and stack space for one cpumask (that's
512 bits on my SN2 systems).

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc3-mm1/drivers/perfctr/virtual.c
===================================================================
--- 2.6.7-rc3-mm1.orig/drivers/perfctr/virtual.c	2004-06-09 15:34:34.000000000 -0700
+++ 2.6.7-rc3-mm1/drivers/perfctr/virtual.c	2004-06-09 15:38:32.000000000 -0700
@@ -403,11 +403,10 @@
 		return -EFAULT;
 
 	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
-		cpumask_t tmp, old_mask, new_mask;
+		cpumask_t old_mask, new_mask;
 
-		tmp = perfctr_cpus_forbidden_mask;
 		old_mask = tsk->cpus_allowed;
-		cpus_andnot(new_mask, old_mask, tmp);
+		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);
 
 		if (cpus_empty(new_mask))
 			return -EINVAL;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
