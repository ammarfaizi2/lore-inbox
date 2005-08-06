Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVHFHZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVHFHZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVHFHX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:23:29 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32787 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262308AbVHFHVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:21:10 -0400
Message-ID: <42F464AE.80507@vmware.com>
Date: Sat, 06 Aug 2005 00:20:14 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 6/8 Move sensitive I/O instructions into the sub-arch layer
Content-Type: multipart/mixed;
 boundary="------------060307020404080004000707"
X-OriginalArrivalTime: 06 Aug 2005 07:20:32.0796 (UTC) FILETIME=[54F2D5C0:01C59A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307020404080004000707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060307020404080004000707
Content-Type: text/plain;
 name="subarch-io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-io"

i386 Transparent paravirtualization subarch patch #6

Move I/O instructions into the sub-arch layer where they can be overridden.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/io.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/io.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13/include/asm-i386/io.h	2005-08-02 17:14:28.000000000 -0700
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <mach_io.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -341,11 +342,11 @@
 
 #define BUILDIO(bwl,bw,type) \
 static inline void out##bwl##_local(unsigned type value, int port) { \
-	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port)); \
+	__BUILDOUTINST(bwl,bw,value,port); \
 } \
 static inline unsigned type in##bwl##_local(int port) { \
 	unsigned type value; \
-	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
+	__BUILDININST(bwl,bw,value,port); \
 	return value; \
 } \
 static inline void out##bwl##_local_p(unsigned type value, int port) { \
@@ -368,10 +369,10 @@
 	return value; \
 } \
 static inline void outs##bwl(int port, const void *addr, unsigned long count) { \
-	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port)); \
+	__BUILDOUTSINST(bwl,addr,count,port); \
 } \
 static inline void ins##bwl(int port, void *addr, unsigned long count) { \
-	__asm__ __volatile__("rep; ins" #bwl : "+D"(addr), "+c"(count) : "d"(port)); \
+	__BUILDINSINST(bwl,addr,count,port); \
 }
 
 BUILDIO(b,b,char)
Index: linux-2.6.13/include/asm-i386/mach-default/mach_io.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_io.h	2005-08-02 17:14:28.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_io.h	2005-08-02 17:14:28.000000000 -0700
@@ -0,0 +1,16 @@
+#ifndef _MACH_ASM_IO_H
+#define _MACH_ASM_IO_H
+
+#define __BUILDOUTINST(bwl,bw,value,port) \
+	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
+#define	__BUILDININST(bwl,bw,value,port) \
+	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
+#define	__BUILDOUTSINST(bwl,addr,count,port) \
+	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port))
+#define	__BUILDINSINST(bwl,addr,count,port) \
+	__asm__ __volatile__("rep; ins" #bwl \
+			     : "+D"(addr), "+c"(count) \
+			     : "d"(port) \
+			     : "memory")
+
+#endif

--------------060307020404080004000707--
