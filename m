Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCPD7Y>; Thu, 15 Mar 2001 22:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCPD7P>; Thu, 15 Mar 2001 22:59:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9222 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129638AbRCPD7D>; Thu, 15 Mar 2001 22:59:03 -0500
Date: Thu, 15 Mar 2001 23:13:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <3AB13E47.7C777DF3@digitalimpact.com>
Message-ID: <Pine.LNX.4.21.0103152311030.4543-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Mar 2001, Shane Y. Gibson wrote:

> Marcelo Tosatti wrote:
> >
> > Did'nt you get a message similar to
> > 
> > "kernel BUG at page_alloc.c line xxx!"
> 
> Marcelo,
> 
> Yes there was.  I'm pasting the total sum of the /var/log/messages
> output.  Note that I'm only able to locate details for the first
> crash, the second didn't seem to log a whole lot.  Originally, 
> just pasted the output of what "ksymops" regurgitated, which seems
> to have pulled out that "kernel BUG" reference.  Here goes...

Can you please try to reproduce it with the following patch against 2.4.2? 

With the patch applied it gets easier to find the problem.

Thanks 

--- linux/include/linux/swap.h.orig	Fri Mar 16 06:31:51 2001
+++ linux/include/linux/swap.h	Fri Mar 16 06:33:41 2001
@@ -201,7 +201,15 @@
  */
 #define DEBUG_ADD_PAGE \
 	if (PageActive(page) || PageInactiveDirty(page) || \
-					PageInactiveClean(page)) BUG();
+					PageInactiveClean(page)) { \
+		if (PageActive(page)) \
+			printk (KERN_ERR "Active page on free list!\n"); \
+		if (PageInactiveDirty(page)) \
+			printk (KERN_ERR "Inactive dirty page on free list!\n"); \
+		if (PageInactiveClean(page)) \
+			printk (KERN_ERR "Inactive clean page on free list!\n"); \
+		BUG(); \
+	}
 
 #define ZERO_PAGE_BUG \
 	if (page_count(page) == 0) BUG();


