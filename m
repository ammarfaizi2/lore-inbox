Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVAUTC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVAUTC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVAUTCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:02:44 -0500
Received: from smtpout17.mailhost.ntl.com ([212.250.162.17]:14372 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262465AbVAUTCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:02:30 -0500
Date: Fri, 21 Jan 2005 19:04:43 +0000
From: Stuart Brady <sdbrady@ntlworld.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/soundcard.h: AFMT_S16_NE macro
Message-ID: <20050121190443.GA26995@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the AFMT_S16_NE macro from include/linux/soundcard.h
on some big-endian machines.

Signed-off-by: Stuart Brady <sdbrady@ntlworld.com>

--- include/linux/soundcard.h	29 Jul 2003 17:02:14 -0000	1.1
+++ include/linux/soundcard.h	21 Jan 2005 18:51:45 -0000
@@ -39,6 +39,13 @@
 /* In Linux we need to be prepared for cross compiling */
 #include <linux/ioctl.h>
 
+/* Endian macros. */
+#ifdef __KERNEL__
+#  include <asm/byteorder.h>
+#else
+#  include <endian.h>
+#endif
+
 /*
  *	Supported card ID numbers (Should be somewhere else?)
  */
@@ -179,13 +186,26 @@
  * Some big endian/little endian handling macros
  */
 
-#if defined(_AIX) || defined(AIX) || defined(sparc) || defined(__sparc__) || defined(HPPA) || defined(PPC) || defined(__mc68000__)
-/* Big endian machines */
-#  define _PATCHKEY(id) (0xfd00|id)
-#  define AFMT_S16_NE AFMT_S16_BE
-#else
-#  define _PATCHKEY(id) ((id<<8)|0xfd)
-#  define AFMT_S16_NE AFMT_S16_LE
+#if defined(__KERNEL__)
+#  if defined(__BIG_ENDIAN)
+#    define AFMT_S16_NE AFMT_S16_BE
+#    define _PATCHKEY(id) (0xfd00|id)
+#  elif defined(__LITTLE_ENDIAN)
+#    define AFMT_S16_NE AFMT_S16_LE
+#    define _PATCHKEY(id) ((id<<8)|0x00fd)
+#  else
+#    error "could not determine byte order"
+#  endif
+#elif defined(__BYTE_ORDER)
+#  if __BYTE_ORDER == __BIG_ENDIAN
+#    define AFMT_S16_NE AFMT_S16_BE
+#    define _PATCHKEY(id) (0xfd00|id)
+#  elif __BYTE_ORDER == __LITTLE_ENDIAN
+#    define AFMT_S16_NE AFMT_S16_LE
+#    define _PATCHKEY(id) ((id<<8)|0x00fd)
+#  else
+#    error "could not determine byte order"
+#  endif
 #endif
 
 /*
