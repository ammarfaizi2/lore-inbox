Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUFXPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUFXPT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUFXPT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:19:57 -0400
Received: from holomorphy.com ([207.189.100.168]:20874 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265492AbUFXPTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:19:45 -0400
Date: Thu, 24 Jun 2004 08:19:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624151941.GB21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624141637.GA20702@logos.cnet> <20040624151833.GA21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624151833.GA21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:18:33AM -0700, William Lee Irwin III wrote:
> Hmm. 2.4 appears to still be lacking some of the fixes (unrelated to
> the nr_swap_pages check causing deadlocks) for functional issues.

Hmm, looks like I forgot the jiffies wrap fix when I sent oom_lock, too.


-- wli

out_of_memory() attempts to determine whether one jiffies-valued
variable refers to a point in time preceding another jiffies-valued
variable, but does not do so in a jiffies wrap -safe fashion. The
following patch corrects this by using the expansion of the 2.6
macro time_after() to check this condition.

Index: linux-2.4/mm/oom_kill.c
===================================================================
--- linux-2.4.orig/mm/oom_kill.c	2004-06-23 19:41:08.000000000 -0700
+++ linux-2.4/mm/oom_kill.c	2004-06-23 19:50:59.000000000 -0700
@@ -283,7 +283,7 @@
 	spin_lock(&oom_lock);
 
 reset:
-	if (first < now)
+	if ((long)first - (long)now < 0)
 		first = now;
 	count = 0;
 
