Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbTDDWui (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbTDDWui (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:50:38 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:38365 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261390AbTDDWug (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:50:36 -0500
Date: Sat, 5 Apr 2003 01:00:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: New Software Suspend Patch for testing.
Message-ID: <20030404230047.GA154@elf.ucw.cz>
References: <1049454721.2418.33.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049454721.2418.33.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The changes from the last version are not huge; perhaps most significant
> is that the dynamically allocated bitmaps (in place of pageflags) are
> implemented. This won't mean anything to most people, but Andrew
> Morton,

@@ -536,6 +519,9 @@
 	struct page *page;
 	int i;
 	int cold;
+#if CONFIG_SOFTWARE_SUSPEND
+	static unsigned int loopcount;
+#endif	
 
 	if (wait)
 		might_sleep();
@@ -589,7 +575,23 @@
 
 	/* here we're in the low on memory slow path */
 
+#if CONFIG_SOFTWARE_SUSPEND
+	loopcount=0;
+#endif
 rebalance:
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if(gfp_mask & __GFP_FAST) {
+/* when using memeat, we ask for all pages that are really free.
+   5 calls to reschedule should be sufficient to recall all of them since
+   when a page can be found, it is after only one reschedule.
+   Actually I consider this as a bug of alloc_pages, since allocating a
+   page should not hang in an endless loop when it is clear that no
+   memory is available (cbd) */	  
+		loopcount++;
+		if(loopcount > 5)
+			return NULL;
+	}
+#endif
 	if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; zones[i] != NULL; i++) {

Again this is *really really* ugly. Why do you need it? 2.5. has
special function for freeing memory.

							Pavel
-- 
When do you have heart between your knees?
