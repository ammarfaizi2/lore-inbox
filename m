Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUFKKRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUFKKRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUFKKRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:17:09 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14350 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263778AbUFKKRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:17:05 -0400
Date: Fri, 11 Jun 2004 20:16:55 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040611101655.GA8208@gondor.apana.org.au>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20040611094844.GC13834@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 11, 2004 at 11:48:44AM +0200, Pavel Machek wrote:
>
> > Thanks, but my question remains: why do we need the memset?  The
> > area allocated is either thrown away because it collides or is
> > overwritten with the pagedir stuff straight away.
> 
> You are right, it should not be needed.

Great.  Here's the patch that removes the memset calls from both
pmdisk and swsusp.  It depends on the previous patches in this
thread.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-06-11 20:14:54 +10:00
+++ b/kernel/power/pmdisk.c	2004-06-11 20:14:54 +10:00
@@ -806,7 +806,6 @@
 
 	err = -ENOMEM;
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
-		memset(m, 0, PAGE_SIZE);
 		if (!does_collide_order(old_pagedir, (unsigned long)m,
 					pagedir_order)) {
 			pm_pagedir_nosave = new_pagedir = m;
--- linux-2.5/kernel/power/swsusp.c.orig	2004-06-11 20:14:02.000000000 +1000
+++ linux-2.5/kernel/power/swsusp.c	2004-06-11 20:14:07.000000000 +1000
@@ -936,7 +936,6 @@
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
-		memset(m, 0, PAGE_SIZE);
 		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
 			break;
 		eaten_memory = m;

--sdtB3X0nJg68CQEu--
