Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbULJQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbULJQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULJQdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:33:24 -0500
Received: from holomorphy.com ([207.189.100.168]:56721 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261285AbULJQdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:33:20 -0500
Date: Fri, 10 Dec 2004 08:32:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, andrea@suse.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210163247.GM2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201104820.1.patchmail@tglx>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> The oom killer has currently some strange effects when triggered.
> It gets invoked multiple times and the selection of the task to kill
> does not take processes into account which fork a lot of child processes.
> The patch solves this by
> - Preventing reentrancy
> - Checking for memory threshold before selection and kill.
> - Taking child processes into account when selecting the process to kill

It appears the net functional change here is the reentrancy prevention;
the choice of tasks is policy. The functional change may be accomplished
with the following:


Index: linux-2.6.9/mm/oom_kill.c
===================================================================
--- linux-2.6.9.orig/mm/oom_kill.c	2004-10-18 14:54:30.000000000 -0700
+++ linux-2.6.9/mm/oom_kill.c	2004-12-10 08:21:31.000000000 -0800
@@ -237,7 +237,8 @@
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
-	spin_lock(&oom_lock);
+	if (!spin_trylock(&oom_lock))
+		return;
 	now = jiffies;
 	since = now - last;
 	last = now;
@@ -282,9 +283,7 @@
 	show_free_areas();
 
 	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
 	oom_kill();
-	spin_lock(&oom_lock);
 
 reset:
 	/*
