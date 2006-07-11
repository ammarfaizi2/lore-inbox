Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWGKFxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWGKFxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGKFxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:53:33 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:36251 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932378AbWGKFxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:53:33 -0400
Date: Mon, 10 Jul 2006 22:53:32 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: Remove redundant might_sleep() in user accessors.
Message-ID: <Pine.LNX.4.58.0607102244590.29091@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On i386, the user space accessor functions copy_from/to_user() both
invoke might_sleep(), do a quick sanity check, and then pass the work on
to their __copy_from/to_user() counterparts, which again invoke
might_sleep(). Given that no actual work happens between these two
calls, it is best to eliminate one of the redundant might_sleep()s.

Please apply.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.18-rc1/arch/i386/lib/usercopy.c linux-new/arch/i386/lib/usercopy.c
--- linux-2.6.18-rc1/arch/i386/lib/usercopy.c	2006-07-06 20:20:55.000000000 -0700
+++ linux-new/arch/i386/lib/usercopy.c	2006-07-10 19:03:47.000000000 -0700
@@ -843,7 +843,6 @@ unsigned long __copy_from_user_ll_nocach
 unsigned long
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_sleep();
 	BUG_ON((long) n < 0);
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
@@ -870,7 +869,6 @@ EXPORT_SYMBOL(copy_to_user);
 unsigned long
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	might_sleep();
 	BUG_ON((long) n < 0);
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
