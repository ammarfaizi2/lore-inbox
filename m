Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVAFAdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVAFAdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVAFAdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:33:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:23239 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262674AbVAFAdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:33:41 -0500
Date: Thu, 6 Jan 2005 01:45:04 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Bill Metzenthen <billm@suburbia.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [rfc] i386/math-emu: __copy_to_user (and missing semicolon?) 
 [possible patch included]
Message-ID: <Pine.LNX.4.61.0501060132480.3491@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

building a few 'make randconfig's I noticed this : 

  CC      arch/i386/math-emu/fpu_entry.o
include/asm/uaccess.h: In function `save_i387_soft':
arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
 
When I took a look I saw what looked like a missing semicolon and indeed 
the return value of __copy_to_user was being ignored (but a few lines from 
there another instance /was/ being tested).
That seems wrong.

I'll admit that I'm not familliar with the code in fpu_entry.c and I've 
only done a very cursory investigation to see if the patch below is 
actually correct (all I can really say is that it now compiles without 
warnings with the patch below).

Would something like this patch make sense? or am I missing something 
somewhere? Any comments are welcome.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk8-orig/arch/i386/math-emu/fpu_entry.c  linux-2.6.10-bk8/arch/i386/math-emu/fpu_entry.c
--- linux-2.6.10-bk8-orig/arch/i386/math-emu/fpu_entry.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.10-bk8/arch/i386/math-emu/fpu_entry.c	2005-01-06 01:28:28.000000000 +0100
@@ -742,7 +742,8 @@ int save_i387_soft(void *s387, struct _f
   S387->fcs &= ~0xf8000000;
   S387->fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-  __copy_to_user(d, &S387->cwd, 7*4);
+  if (__copy_to_user(d, &S387->cwd, 7*4))
+    return -1;
   RE_ENTRANT_CHECK_ON;
 
   d += 7*4;
@@ -753,7 +754,7 @@ int save_i387_soft(void *s387, struct _f
     return -1;
   if ( offset )
     if (__copy_to_user(d+other, (u_char *)&S387->st_space, offset))
-      return -1
+      return -1;
   RE_ENTRANT_CHECK_ON;
 
   return 1;



