Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946402AbWJ0LQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946402AbWJ0LQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946401AbWJ0LQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:16:16 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:47307 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946402AbWJ0LQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:16:14 -0400
Date: Fri, 27 Oct 2006 13:16:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] termio <-> termios conversion error handling.
Message-ID: <20061027111612.GC27468@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] termio <-> termios conversion error handling.

Get rid of our own user_termio_to_kernel_termios() and
kernel_termios_to_user_termio() macros which didn't check for errors
on user space accesses. Instead use the generic functions which
handle this properly.
In addition the generic version of user_termio_to_kernel_termios()
also copies the c_line member which was missing in our variant.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/termios.h |   34 +---------------------------------
 1 files changed, 1 insertion(+), 33 deletions(-)

diff -urpN linux-2.6/include/asm-s390/termios.h linux-2.6-patched/include/asm-s390/termios.h
--- linux-2.6/include/asm-s390/termios.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/termios.h	2006-10-27 11:26:16.000000000 +0200
@@ -75,39 +75,7 @@ struct termio {
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	(termios)->x = (0xffff0000 & ((termios)->x)) | __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#include <asm-generic/termios.h>
 
 #endif	/* __KERNEL__ */
 
