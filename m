Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVJ1Ctk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVJ1Ctk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVJ1Ctk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:49:40 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:8970 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965071AbVJ1Ctj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:49:39 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org
Subject: Re: [patch 1/1] export cpu_online_map
Cc: rajesh.shah@intel.com, mingo@elte.hu, pj@sgi.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EVKIg-0003tm-00@gondolin.me.apana.org.au>
Date: Fri, 28 Oct 2005 12:49:02 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> 
> - Why isn't set_cpus_allowed() just a no-op on UP?  Or some trivial thing
>  which tests for cpu #0?

It's still needed to weed out bogus masks that have CPU 0 turned off.

You're right that it doesn't need to check cpu_online_map though.
Here is a patch to make it check for CPU 0 instead.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -895,7 +895,7 @@ extern int set_cpus_allowed(task_t *p, c
 #else
 static inline int set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
-	if (!cpus_intersects(new_mask, cpu_online_map))
+	if (!cpu_isset(0, new_mask))
 		return -EINVAL;
 	return 0;
 }
