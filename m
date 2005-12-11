Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVLKMSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVLKMSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVLKMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:18:13 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:36307 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751352AbVLKMSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:18:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Sun, 11 Dec 2005 13:16:46 +0100
User-Agent: KMail/1.9
Cc: adi@hexapodia.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20051205081935.GI22168@hexapodia.org> <200512110007.35346.rjw@sisk.pl> <20051210153306.02377935.akpm@osdl.org>
In-Reply-To: <20051210153306.02377935.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111316.47153.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 11 December 2005 00:33, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> >  Would that be ok if I made drop_pagecache() nonstatic and called it directly
> >  from swsusp?
> 
> Sure, I'll updates the patch for that.

Thanks a lot.
 
> It changed a bit..  You'll need to run sys_sync() then drop_pagecache()
> then drop_slab().

I think it won't hurt if we do this unconditionally in swsusp_shrink_memory().
Pavel, what do you think?

The appended patch illustrates the way in which I think we can use this.
I've tested it a little, but if someone feels like trying it, please do.

Greetings,
Rafael


 kernel/power/swsusp.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-10 23:51:00.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-11 12:45:57.000000000 +0100
@@ -641,6 +641,9 @@ int swsusp_shrink_memory(void)
 	char *p = "-\\|/";
 
 	printk("Shrinking memory...  ");
+	sys_sync();
+	drop_pagecache();
+	drop_slab();
 	do {
 		size = 2 * count_highmem_pages();
 		size += size / 50 + count_data_pages();
