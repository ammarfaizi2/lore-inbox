Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUKEXgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUKEXgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKEXfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:35:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5820 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261255AbUKEXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:33:33 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Date: Fri, 5 Nov 2004 15:32:50 -0800
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20041105200118.GA20321@logos.cnet>
In-Reply-To: <20041105200118.GA20321@logos.cnet>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j2AjBJu8ghF2Nkn"
Message-Id: <200411051532.51150.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_j2AjBJu8ghF2Nkn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> Hi,
>
> As you know the OOM is very problematic in 2.6 right now - so I went
> to investigate it.
>
> Currently the oom killer is invoked from the task reclaim
> code (try_to_free_pages), which IMO is fundamentally broken,
> because its non deterministic - the chance the OOM killer
> will be triggered increases as the number of tasks inside
> reclaiming increases. And kswapd is freeing pages in parallel,
> which is completly ignored by this approach.
>
> In my opinion the correct approach is to trigger the OOM killer
> when kswapd is unable to free pages. Once that is done, the number
> of tasks inside page reclaim is irrelevant.

That makes sense.

> With this in place I can't see spurious OOM kills - just need to guarantee
> that it reliably OOM kills when we are really out of memory.

That's good.  I can test it on a large machine (hopefully next week).

> Comments?

Sounds good, though we may want to do a couple of more things, we shouldn't 
kill root tasks quite as easily and we should avoid zombies since they may be 
large apps in the process of exiting, and killing them would be bad (iirc 
it'll cause a panic).

Thanks,
Jesse

--Boundary-00=_j2AjBJu8ghF2Nkn
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="oom-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oom-fixes.patch"

===== mm/oom_kill.c 1.30 vs edited =====
--- 1.30/mm/oom_kill.c	2004-10-13 21:08:29 -07:00
+++ edited/mm/oom_kill.c	2004-11-05 15:32:36 -08:00
@@ -88,7 +88,7 @@
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
 				p->uid == 0 || p->euid == 0)
-		points /= 4;
+		points /= 10;
 
 	/*
 	 * We don't want to kill a process with direct hardware access.
@@ -120,7 +120,7 @@
 
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
-		if (p->pid) {
+		if (p->pid && !(p->state & TASK_ZOMBIE)) {
 			unsigned long points = badness(p, uptime.tv_sec);
 			if (points > maxpoints) {
 				chosen = p;

--Boundary-00=_j2AjBJu8ghF2Nkn--
