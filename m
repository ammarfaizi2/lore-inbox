Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUHZJSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUHZJSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUHZJS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:18:26 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:16100 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S268050AbUHZJIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:08:21 -0400
Subject: Re: [PATCH] Oops when loading a stripped module
From: Rusty Russell <rusty@rustcorp.com.au>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200408191750.51863.blaisorblade_spam@yahoo.it>
References: <200408191750.51863.blaisorblade_spam@yahoo.it>
Content-Type: text/plain
Message-Id: <1093511075.29319.2524.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 19:04:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 01:52, BlaisorBlade wrote:
> I've stripped a module and tried to load it (I know it's meaningless, but it 
> was for testing; I wanted to strip debug symbols). And to my surprise, the 

Thanks.

Name: Don't OOPS on stripped modules
Status: Tested on 2.6.9-rc1-bk1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (modified)
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Paulo:
> I've stripped a module and tried to load it (I know it's meaningless, but it 
> was for testing; I wanted to strip debug symbols). And to my surprise, the 
> kernel Oopsed.

Don't want to go overboard with the checks, but this is simple and
reasonable.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9728-linux-2.6.9-rc1-bk1/kernel/module.c .9728-linux-2.6.9-rc1-bk1.updated/kernel/module.c
--- .9728-linux-2.6.9-rc1-bk1/kernel/module.c	2004-08-25 09:54:16.000000000 +1000
+++ .9728-linux-2.6.9-rc1-bk1.updated/kernel/module.c	2004-08-26 18:16:46.000000000 +1000
@@ -1538,9 +1538,6 @@ static struct module *load_module(void _
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 	sechdrs[0].sh_addr = 0;
 
-	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = 0;
-
 	for (i = 1; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type != SHT_NOBITS
 		    && len < sechdrs[i].sh_offset + sechdrs[i].sh_size)
@@ -1572,6 +1569,13 @@ static struct module *load_module(void _
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	if (symindex == 0) {
+		printk(KERN_WARNING "%s: module has no symbols (stripped?)\n",
+		       mod->name);
+		err = -ENOEXEC;
+		goto free_hdr;
+	}
+
 	/* Optional sections */
 	exportindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab");
 	gplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl");

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

