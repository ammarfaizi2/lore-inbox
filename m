Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752538AbWKAXBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbWKAXBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbWKAXBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:01:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:3681 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752538AbWKAXBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:01:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qKEtHzkYgL+1rOBmwsZvsLa1iG8Vld6vXtsKbo7snKHVGh9vAEQLcLwpa7KaP/RXz0Aoho08tlXxYqdkzCrqz0jwPiB/rfsbGVqj5rlU5BRTCwxXV1winLGbiaFkrASommT69WzCIiHrB9Am5yI1DYW4eb1JEjkpo3EcM6vR6Jk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bail out in mathemu if __copy_to_user fails
Date: Thu, 2 Nov 2006 00:03:16 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, billm@suburbia.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020003.16424.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe we should check the return value of 
__copy_to_user in math-emu/fpu_entry.c and bail out of save_i387_soft() if 
it fails.
This patch does that.

This also kills the warning :
  arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/arch/i386/math-emu/fpu_entry.c b/arch/i386/math-emu/fpu_entry.c
index d93f16e..ddf8fa3 100644
--- a/arch/i386/math-emu/fpu_entry.c
+++ b/arch/i386/math-emu/fpu_entry.c
@@ -742,7 +742,8 @@ #ifdef PECULIAR_486
   S387->fcs &= ~0xf8000000;
   S387->fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-  __copy_to_user(d, &S387->cwd, 7*4);
+  if (__copy_to_user(d, &S387->cwd, 7*4))
+    return -1;
   RE_ENTRANT_CHECK_ON;
 
   d += 7*4;


