Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUJRTcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUJRTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJRTbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:31:38 -0400
Received: from lists.us.dell.com ([143.166.224.162]:15057 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267505AbUJRTaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:30:19 -0400
Date: Mon, 18 Oct 2004 14:29:52 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: jmorris@redhat.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, Oleg Makarenko <mole@quadra.ru>
Subject: using crypto_digest() on non-kmalloc'd memory failures
Message-ID: <20041018192952.GB8607@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James, David,

Oleg noted that when we call crypto_digest() on memory allocated as a
static array in a module, rather than kmalloc(GFP_KERNEL), it returns
incorrect data, and with other functions, a kernel panic.

Thoughts as to why this may be?  Oleg's test patch appended.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

----- Forwarded message from Oleg Makarenko <mole@quadra.ru> -----

From: Oleg Makarenko <mole@quadra.ru>
To: Matt Domsch <Matt_Domsch@dell.com>
CC: linux-ppp@vger.kernel.org, pptpclient-devel@lists.sourceforge.net
Subject: Re: [pptp-devel] Re: [2/2]: ppp_mppe inclusion
Date: Sun, 05 Sep 2004 22:23:15 +0400

>>>2.  For some reason you can not use non GFP_KERNEL memory and scatter 
>>>lists or at least mix them in crypto_digest().  That is why sha_pad is 
>>>now in struct state {}.
>
>Can you describe what happens when you do?

please try the attached patch for tcrypt.c to see what is going on 
yourself.  modprobe the resulting module with mode=2 parameter to test 
sha1 and see how it fails the tests (incorrect results, no kernel panic).

For mode=0 (or without any parameter) you should get kernel panic.

=oleg

--- tcrypt.c.orig	2004-08-14 09:37:38.000000000 +0400
+++ tcrypt.c	2004-09-05 21:11:19.000000000 +0400
@@ -58,6 +58,8 @@
 static char *xbuf;
 static char *tvmem;
 
+static char tvmem_buf[TVMEMSIZE];
+
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
@@ -820,7 +822,8 @@
 static int __init
 init(void)
 {
-	tvmem = kmalloc(TVMEMSIZE, GFP_KERNEL);
+	tvmem = &tvmem_buf[0];
+
 	if (tvmem == NULL)
 		return -ENOMEM;
 
@@ -833,7 +836,6 @@
 	do_test();
 
 	kfree(xbuf);
-	kfree(tvmem);
 	return 0;
 }
 
