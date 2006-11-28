Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758755AbWK1Sw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755AbWK1Sw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758756AbWK1Sw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:52:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758755AbWK1Sw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:52:27 -0500
Date: Tue, 28 Nov 2006 10:52:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix earlyprintk=...,keep regression
In-Reply-To: <20061128081405.GA9031@elte.hu>
Message-ID: <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
References: <20061128081405.GA9031@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2006, Ingo Molnar wrote:
> 
> the following cleanup patch:
> 
>  commit 2c8c0e6b8d7700a990da8d24eff767f9ca223b96
>  Author: Andi Kleen <ak@suse.de>
>  Date:   Tue Sep 26 10:52:32 2006 +0200
> 
>      [PATCH] Convert x86-64 to early param
> 
>      Instead of hackish manual parsing
> 
> broke the earlyprintk=...,keep feature. This patch restores that 
> functionality. Tested on x86_64. Must-have for v2.6.19, no risk.

Hmm.

> -	if (!strcmp(buf,"keep"))
> +	if (strstr(buf, "keep"))
>  		keep_early = 1;
>  
>  	if (!strncmp(buf, "serial", 6)) {

This is pretty ugly. The whole reason for the bug in the first place was 
that "keep" was tested differently from all the other cases, and now you 
just perpetuate that.

All the other strings are tested with "!strncmp(..)", so I think this one 
should too. No?

Something like the appended (where I made the patch a bit bigger by just 
making it visually look the same too and adding the "} else if .." thing.

Or is there some reason you really _want_ "keep" to be different? If so, 
it should probably be commented on.

		Linus
---
diff --git a/arch/x86_64/kernel/early_printk.c b/arch/x86_64/kernel/early_printk.c
index e22ecd5..51e6912 100644
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -224,10 +224,9 @@ static int __init setup_early_printk(char *buf)
 		return 0;
 	early_console_initialized = 1;
 
-	if (!strcmp(buf,"keep"))
+	if (!strncmp(buf,"keep", 4)) {
 		keep_early = 1;
-
-	if (!strncmp(buf, "serial", 6)) {
+	} else if (!strncmp(buf, "serial", 6)) {
 		early_serial_init(buf + 6);
 		early_console = &early_serial_console;
 	} else if (!strncmp(buf, "ttyS", 4)) {
