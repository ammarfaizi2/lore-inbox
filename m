Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEAWzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEAWzM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUEAWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:55:12 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:8708 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262503AbUEAWy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:54:56 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] add missing #include
Date: Sun, 2 May 2004 01:54:43 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0qClADPW1NvdrBv"
Message-Id: <200405020154.44062.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0qClADPW1NvdrBv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus,

A small problem still exists int 2.6.6-rc3:

fs/open.c:
==========
#include <linux/string.h>
        this pulls __constant_c_and_count_memset()
#include <linux/mm.h>
        this pulls <compiler.h>, re#defining
        inline == __inline__ __attribute__((always_inline)).
        But it is too late!
#include <linux/utime.h>

open.c isn't the only place where it bites.
Result:

# grep __constant System.map
c0144670 t __constant_c_and_count_memset
c0145c60 t __constant_c_and_count_memset
c0181230 t __constant_c_and_count_memset
c01889d0 t __constant_c_and_count_memset
c01daa10 t __constant_c_and_count_memset
c01eecc0 t __constant_c_and_count_memset
c02081a0 t __constant_c_and_count_memset
c0289f20 t __constant_c_and_count_memset
c040b170 t __constant_c_and_count_memset
c040c140 t __constant_c_and_count_memset

Patch fixes this.
--
vda

--Boundary-00=_0qClADPW1NvdrBv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing_include_compiler_h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="missing_include_compiler_h.patch"

diff -urN linux-2.6.5/include/linux/string.h linux-2.6.5.fixed_includes/include/linux/string.h
--- linux-2.6.5/include/linux/string.h	Sun Apr  4 06:36:56 2004
+++ linux-2.6.5.fixed_includes/include/linux/string.h	Wed Apr 21 09:17:32 2004
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 

--Boundary-00=_0qClADPW1NvdrBv--

