Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVDCADW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDCADW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 19:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDCADW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 19:03:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:53156 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261388AbVDCADO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 19:03:14 -0500
Date: Sun, 3 Apr 2005 02:05:31 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Yum Rayan <yum.rayan@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c - fix warning and reduce stack usage -
 reintroduction of mistakenly dropped patch 
In-Reply-To: <Pine.LNX.4.62.0504030139090.2525@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0504030202230.2525@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504030139090.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005, Jesper Juhl wrote:

> 
> Hi Andrew,
> 
> Reading your 2.6.12-rc1-mm4 announce text I see
> 
> ...
> -figure-out-who-is-inserting-bogus-modules-warning-fix.patch
> 
>  Folded into figure-out-who-is-inserting-bogus-modules.patch
> ...
> figure-out-who-is-inserting-bogus-modules.patch
>   Figure out who is inserting bogus modules
> ...
> 
> However, it seems you did *not* roll 
> figure-out-who-is-inserting-bogus-modules-warning-fix.patch into 
> figure-out-who-is-inserting-bogus-modules.patch but instead just dropped 
> the patch.
> 
> It also turns out I had a small boundary error (off-by-one) in my original 
> patch which Yum Rayan spotted and fixed in a patch he wrote that also 
> reduces the stack usage of the function (by dynamically allocating the 
> needed mem for 'args' instead of using a static 512 byte array - see the 
> LKML thread with subject "[PATCH] Reduce stack usage in module.c"), so 
> below you'll find an updated patch that reintroduce 
> figure-out-who-is-inserting-bogus-modules-warning-fix.patch on top of 
> 2.6.12-rc1-mm4 and includes Yum Rayan's fix for the off-by-one and also 
> adopts his use of kmalloc() instead of large static array.
> 
> Yum Rayan's patch does more than what I've included below, I've only 
> included his changes to the who_is_doing_it() function, if you want the 
> rest of his changes then please see the original thread for his full 
> patch.
> 
> Here's the updated figure-out-who-is-inserting-bogus-modules-warning-fix.patch
> 
In case you prefer the static array, so the function will never fail due 
to OOM, then here's an alternative version of my original patch /with/ the 
static array but /without/ the off-by-one error  :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm4-orig/kernel/module.c	2005-03-31 21:20:07.000000000 +0200
+++ linux-2.6.12-rc1-mm4/kernel/module.c	2005-04-03 02:04:39.000000000 +0200
@@ -1400,9 +1400,12 @@ static void who_is_doing_it(void)
 {
 	/* Print out all the args. */
 	char args[512];
-	unsigned int i, len = current->mm->arg_end - current->mm->arg_start;
+	unsigned long i, len = current->mm->arg_end - current->mm->arg_start;
 
-	copy_from_user(args, (void *)current->mm->arg_start, len);
+	if (len > 511)
+		len = 511;
+
+	len -= copy_from_user(args, (void *)current->mm->arg_start, len);
 
 	for (i = 0; i < len; i++) {
 		if (args[i] == '\0')


