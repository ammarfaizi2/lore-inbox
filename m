Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVAVJzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVAVJzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 04:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVAVJzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 04:55:51 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:35015 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262686AbVAVJz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 04:55:26 -0500
Date: Sat, 22 Jan 2005 10:54:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050122095432.GA2366@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050122025019.GC27060@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122025019.GC27060@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following patch speeds up the restoring of swsusp images on x86-64
> > and makes the assembly code more readable (tested and works on AMD64).  It's
> > against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Thanks. I applied it with some small changes to not hardcode any 
> C fields. 
> 
> BTW Pavel, while reading the code I noticed some dubious things
> in the code:
> 
> - The TLB flush doesn't flush global pages (turn of PGE and turn it
> on again). Since that handles kernel pages which are marked global
> this is surely wrong. 
> 
> - Also is it really needed to flush the TLB after each page and wouldn't
> INVLPG be better here? Or do you want to flush other pages than the
> just copied one there too? INVLPG would also take care of the global
> pages at least on x86-64 (iirc there are some bugs in this regard on some
> older i386 cpus) 
> 
> - There is a comment that says the code shouldn't use stack, but 
> it definitely uses the stack for some things. Either the comment
> or the code is wrong. Which is?

This should address it... I attempted to put answers into the
comments, because probably everyone is interested in those....
									Pavel

--- clean/arch/x86_64/kernel/suspend_asm.S	2004-10-19 14:16:28.000000000 +0200
+++ linux/arch/x86_64/kernel/suspend_asm.S	2005-01-22 10:51:28.000000000 +0100
@@ -1,10 +1,16 @@
-/* Originally gcc generated, modified by hand
+/* Copyright 2004,2005 Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>, Rafael J. Wysocki <rjw@sisk.pl>
  *
- * This may not use any stack, nor any variable that is not "NoSave":
+ * Distribute under GPLv2.
+ * 
+ * swsusp_arch_resume may not use any stack, nor any variable that is
+ * not "NoSave" during copying pages:
  *
  * Its rewriting one kernel image with another. What is stack in "old"
  * image could very well be data page in "new" image, and overwriting
  * your own stack under you is bad idea.
+ *
+ * TLB flush is purely and debugging attempt to make it fail fast if we
+ * do something wrong. TLB is properly flushed in swsusp_restore.
  */
 	
 	.text



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
