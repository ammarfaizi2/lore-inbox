Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVCRSxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVCRSxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVCRSxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:53:54 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:17283 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261771AbVCRSxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:53:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] SUSPEND_PD_PAGES-fix
Date: Fri, 18 Mar 2005 19:56:43 +0100
User-Agent: KMail/1.7.1
Cc: coywolf@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050316202800.GA22750@everest.sosdg.org> <20050318113957.GC32253@elf.ucw.cz> <200503181434.59214.rjw@sisk.pl>
In-Reply-To: <200503181434.59214.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503181956.46089.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 18 of March 2005 14:34, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 18 of March 2005 12:39, Pavel Machek wrote:
> > Hi!
> > 
> > 
> > > This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.
> > 
> > Ok, applied to my tree, will eventually propagate it. (I hope it looks
> > okay to you, rafael).
> 
> SUSPEND_PD_PAGES is not necessary in swsusp any more. :-)  We can just
> drop it, together with the pagedir_order variable, which is not used.  I'll
> send a patch later today.

The patch follows.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nrup linux-2.6.12-rc1/include/linux/suspend.h linux-2.6.12-rc1-a/include/linux/suspend.h
--- linux-2.6.12-rc1/include/linux/suspend.h	2005-03-18 18:50:15.000000000 +0100
+++ linux-2.6.12-rc1-a/include/linux/suspend.h	2005-03-18 18:58:27.000000000 +0100
@@ -34,8 +34,6 @@ typedef struct pbe {
 #define SWAP_FILENAME_MAXLENGTH	32
 
 
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
-
 extern dev_t swsusp_resume_device;
    
 /* mm/vmscan.c */
diff -Nrup linux-2.6.12-rc1/kernel/power/swsusp.c linux-2.6.12-rc1-a/kernel/power/swsusp.c
--- linux-2.6.12-rc1/kernel/power/swsusp.c	2005-03-18 18:50:18.000000000 +0100
+++ linux-2.6.12-rc1-a/kernel/power/swsusp.c	2005-03-18 18:59:46.000000000 +0100
@@ -98,7 +98,6 @@ unsigned int nr_copy_pages __nosavedata 
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -1219,7 +1218,6 @@ static int check_header(void)
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
