Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268653AbUHLSUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268653AbUHLSUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268654AbUHLSUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:20:13 -0400
Received: from holomorphy.com ([207.189.100.168]:32141 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268653AbUHLSSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:18:54 -0400
Date: Thu, 12 Aug 2004 11:18:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.27 released
Message-ID: <20040812181851.GP11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo@hera.kernel.org>,
	linux-kernel@vger.kernel.org
References: <200408072328.i77NSRNi031514@hera.kernel.org> <20040812181712.GO11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812181712.GO11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 11:17:12AM -0700, William Lee Irwin III wrote:
> This patch by nature corrects two apparent bugs which are really one
> bug. p->mm can become NULL while traversing the tasklist. The two
> effects are first that kernel threads appear to be killed. The second
> is that the OOM killing process fails to actually shoot down all threads
> of the chosen process, and so fails to reclaim the memory it intended to.
> oom_kill_task() consists primarily of the expansion of the 2.6 inline
> function get_task_mm().

Incremental atop the mm reference patch:

out_of_memory() attempts to determine whether one jiffies-valued
variable refers to a point in time preceding another jiffies-valued
variable, but does not do so in a jiffies wrap -safe fashion. The
following patch corrects this by using the expansion of the 2.6
macro time_after() to check this condition.

Index: linux-2.4/mm/oom_kill.c
===================================================================
--- linux-2.4.orig/mm/oom_kill.c	2004-06-23 19:41:08.000000000 -0700
+++ linux-2.4/mm/oom_kill.c	2004-06-23 19:50:59.000000000 -0700
@@ -289,7 +289,7 @@
 	spin_lock(&oom_lock);
 
 reset:
-	if (first < now)
+	if ((long)first - (long)now < 0)
 		first = now;
 	count = 0;
 
