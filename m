Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTFDFnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTFDFnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:43:52 -0400
Received: from smtpout.mac.com ([17.250.248.88]:35797 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262912AbTFDFni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:43:38 -0400
Date: Wed, 4 Jun 2003 15:56:09 +1000
Subject: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Stewart Smith <stewart@linux.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <1054646171.17921.64.camel@passion.cambridge.redhat.com>
Message-Id: <3D3CD66D-9651-11D7-A060-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
please apply - this fixes unresolved symbols when CONFIG_CRC32=y and 
CONFIG_8139TOO=m (it also appeared on some other ethernet device 
drivers). I think this is the right way to fix this problem. It at 
least now builds, links and boots (and hey, even my ethernet works so 
it can't all be bad :)

patches cleanly against 2.5.70 and 2.5.70-bk8

--- linux-2.5.70-orig/include/linux/crc32.h	2003-05-05 
09:53:08.000000000 +1000
+++ linux-2.5.70-stew3/include/linux/crc32.h	2003-06-04 
15:27:34.000000000 +1000
@@ -6,6 +6,7 @@
  #define _LINUX_CRC32_H

  #include <linux/types.h>
+#include <linux/module.h>

  extern u32  crc32_le(u32 crc, unsigned char const *p, size_t len);
  extern u32  crc32_be(u32 crc, unsigned char const *p, size_t len);
@@ -21,7 +22,16 @@
   * is in bit nr 0], thus it must be reversed before use. Except for
   * nics that bit swap the result internally...
   */
-#define ether_crc(length, data)    bitreverse(crc32_le(~0, data, 
length))
-#define ether_crc_le(length, data) crc32_le(~0, data, length)
+static inline u32 ether_crc(size_t length, unsigned char const *data)
+{
+  return bitreverse(crc32_le(~0, data, length));
+}
+EXPORT_SYMBOL(ether_crc);
+
+static inline u32 ether_crc_le(size_t length, unsigned char const 
*data)
+{
+  return crc32_le(~0, data, length);
+}
+EXPORT_SYMBOL(ether_crc_le);

  #endif /* _LINUX_CRC32_H */
--- linux-2.5.70-orig/kernel/ksyms.c	2003-06-02 23:28:32.000000000 +1000
+++ linux-2.5.70-stew3/kernel/ksyms.c	2003-06-04 15:11:37.000000000 
+1000
@@ -58,6 +58,7 @@
  #include <linux/time.h>
  #include <linux/backing-dev.h>
  #include <linux/percpu_counter.h>
+#include <linux/crc32.h>
  #include <asm/checksum.h>

  #if defined(CONFIG_PROC_FS)


------------
Stewart Smith
Vice President, Linux Australia
stewart@linux.org.au
http://www.linux.org.au

