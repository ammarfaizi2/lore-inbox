Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTDWJrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTDWJrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:47:46 -0400
Received: from holomorphy.com ([66.224.33.161]:44960 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263338AbTDWJro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:47:44 -0400
Date: Wed, 23 Apr 2003 02:59:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rml@tech9.net
Subject: Re: 2.5.68-mm2
Message-ID: <20030423095926.GJ8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rml@tech9.net
References: <20030423012046.0535e4fd.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423012046.0535e4fd.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 01:20:46AM -0700, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.68/2.5.68-mm2.gz
>    Will appear sometime at:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm2/
> . Zillions of new fixes.
> . I got tired of the objrmap code going BUG under stress, so it is now in
>   disgrace in the experimental/ directory.

rml and I coordinated to put together a small patch (combining both
our own) for properly locking the static variables in out_of_memory().
There's not any evidence things are going wrong here now, but it at
least addresses the visible lack of locking in out_of_memory().

Applies cleanly to 2.5.68-mm2.


-- wli


diff -urpN mm1-2.5.68-1/mm/oom_kill.c mm1-2.5.68-1A/mm/oom_kill.c
--- mm1-2.5.68-1/mm/oom_kill.c	2003-04-20 00:24:46.000000000 -0700
+++ mm1-2.5.68-1A/mm/oom_kill.c	2003-04-22 21:43:40.000000000 -0700
@@ -208,6 +208,11 @@ static void oom_kill(void)
  */
 void out_of_memory(void)
 {
+	/*
+	 * oom_lock protects out_of_memory()'s static variables.
+	 * It's a global lock; this is not performance-critical.
+	 */
+	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
@@ -217,6 +222,7 @@ void out_of_memory(void)
 	if (nr_swap_pages > 0)
 		return;
 
+	spin_lock(&oom_lock);
 	now = jiffies;
 	since = now - last;
 	last = now;
@@ -235,14 +241,14 @@ void out_of_memory(void)
 	 */
 	since = now - first;
 	if (since < HZ)
-		return;
+		goto out_unlock;
 
 	/*
 	 * If we have gotten only a few failures,
 	 * we're not really oom. 
 	 */
 	if (++count < 10)
-		return;
+		goto out_unlock;
 
 	/*
 	 * If we just killed a process, wait a while
@@ -251,15 +257,27 @@ void out_of_memory(void)
 	 */
 	since = now - lastkill;
 	if (since < HZ*5)
-		return;
+		goto out_unlock;
 
 	/*
 	 * Ok, really out of memory. Kill something.
 	 */
 	lastkill = now;
+
+	/* oom_kill() sleeps */
+	spin_unlock(&oom_lock);
 	oom_kill();
+	spin_lock(&oom_lock);
 
 reset:
-	first = now;
+	/*
+	 * We dropped the lock above, so check to be sure the variable
+	 * first only ever increases to prevent false OOM's.
+	 */
+	if (time_after(now, first))
+		first = now;
 	count = 0;
+
+out_unlock:
+	spin_unlock(&oom_lock);
 }
