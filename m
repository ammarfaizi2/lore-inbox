Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTKDQhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKDQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:37:07 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:41346
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262333AbTKDQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:37:03 -0500
Date: Tue, 4 Nov 2003 11:36:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] Dont use cpu_has_pse for WP test branch
In-Reply-To: <Pine.LNX.4.44.0311040809470.20373-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0311041130040.20595@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311040809470.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003, Linus Torvalds wrote:

> Why?
> 
> The reason we test the PSE bit is not that we think it's a good indicator 
> of "new enough".  It's because if the PSE bit is set, we will use 4MB 
> pages, and the code below that actually _tests_ whether WP works or not 
> won't work.

Agreed, i also retracted the patch due to the reasons behind cpu_has_pse 
not working was because of CONFIG_DEBUG_PAGEALLOC.

> In fact, these days we could remove the test entirely: the only reason it 
> exists is because traditionally we didn't have the "fixmap" helpers, so we 
> used the page in lowest kernel memory for testing (which did not exist if 
> we had PSE, since with PSE the kernel wouldn't use individual pages to map 
> itself).

Wasn't the test unconditional in 2.4? How about the following then?

Index: linux-2.6.0-test9-mm1/arch/i386/mm/init.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm1/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.0-test9-mm1/arch/i386/mm/init.c	30 Oct 2003 11:22:42 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm1/arch/i386/mm/init.c	4 Nov 2003 16:34:45 -0000
@@ -390,12 +390,6 @@ void __init paging_init(void)
 
 void __init test_wp_bit(void)
 {
-	if (cpu_has_pse) {
-		/* Ok, all PSE-capable CPUs are definitely handling the WP bit right. */
-		boot_cpu_data.wp_works_ok = 1;
-		return;
-	}
-
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 
 	/* Any page-aligned address will do, the test is non-destructive */
