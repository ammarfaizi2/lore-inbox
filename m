Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRBRTLP>; Sun, 18 Feb 2001 14:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129246AbRBRTLG>; Sun, 18 Feb 2001 14:11:06 -0500
Received: from colorfullife.com ([216.156.138.34]:32516 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129224AbRBRTK5>;
	Sun, 18 Feb 2001 14:10:57 -0500
Message-ID: <3A901DF5.6198F31F@colorfullife.com>
Date: Sun, 18 Feb 2001 20:09:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Leathley <mail@robleathley.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: page_alloc 2.4.1 kernel BUG running java 1.3.0
In-Reply-To: <3A9011E1.8A122306@robleathley.uklinux.net>
Content-Type: multipart/mixed;
 boundary="------------339055CB58C727B46844E66C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------339055CB58C727B46844E66C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Rob Leathley wrote:
> 
> [X] I have been suffering a lot of memory paging related Oops' on the
> above PC since upgrading to the 2.2.16 kernel.  Most of these problems
> are fixed in 2.4.1 appart from the above.  These problems don't appear
> on a faster machine (e.g. P3 733MHz) so could be related to race
> conditions?  I appreciate that there is probably a bug in java 1.3.0 but
> it would be nice if it didn't kill the whole machine!
>

It's not a bug in java 1.3.0, that certain.
It's either a kernel bug or bad memory. Usually I'd say bad memory, but
your report is the third or forth one with __free_pages_ok(), so I
suspect a kernel bug.

Could you apply the attached patch to your kernel and run it until it
crashes again?

--
	Manfred
--------------339055CB58C727B46844E66C
Content-Type: text/plain; charset=us-ascii;
 name="patch-tst"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tst"

--- linux.old/mm/page_alloc.c	Sun Feb 18 20:06:11 2001
+++ linux/mm/page_alloc.c	Sun Feb 18 20:05:59 2001
@@ -70,8 +70,15 @@
 
 	if (page->buffers)
 		BUG();
-	if (page->mapping)
+	if (page->mapping) {
+	    	printk(KERN_EMERG "found bad mapping %lxh.\n",
+			(unsigned long)page->mapping);
+		printk(KERN_EMERG "page->mapping->nrpages: %d.\n",
+				(int)page->mapping->nrpages);
+		printk(KERN_EMERG "page->mapping->a_ops: [<%lxh>]\n",
+				(unsigned long)page->mapping->a_ops);
 		BUG();
+	}
 	if (!VALID_PAGE(page))
 		BUG();
 	if (PageSwapCache(page))

--------------339055CB58C727B46844E66C--


