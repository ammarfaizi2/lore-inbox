Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUG1Wap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUG1Wap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUG1W3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:29:45 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266284AbUG1W1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:27:06 -0400
Date: Thu, 29 Jul 2004 00:26:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -mm swsusp: copy_page is harmfull
Message-ID: <20040728222644.GA19380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is my fault from long time ago: copy_page can't be used for
copying task struct, therefore we can't use it in swsusp. Please
apply,

							Pavel

--- clean-mm/kernel/power/swsusp.c	2004-07-28 23:39:49.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-07-28 23:30:33.000000000 +0200
@@ -614,12 +614,8 @@
 					struct page * page;
 					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 					pbe->orig_address = (long) page_address(page);
-					/* Copy page is dangerous: it likes to mess with
-					   preempt count on specific cpus. Wrong preempt 
-					   count is then copied, oops. 
-					*/
-					copy_page((void *)pbe->address, 
-						  (void *)pbe->orig_address);
+					/* copy_page is no usable for copying task structs. */
+					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 					pbe++;
 				}
 			}

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
