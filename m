Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTBFWmN>; Thu, 6 Feb 2003 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTBFWmN>; Thu, 6 Feb 2003 17:42:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:27547 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267656AbTBFWmL>; Thu, 6 Feb 2003 17:42:11 -0500
Message-ID: <3E42E543.20306@us.ibm.com>
Date: Thu, 06 Feb 2003 14:44:19 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>
CC: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] Broken CLEAR_BITMAP() macro
Content-Type: multipart/mixed;
 boundary="------------090200050803090100010802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200050803090100010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
	It appears that the CLEAR_BITMAP() macro in include/linux/types.h is 
broken.

(Examples done with BITS_PER_LONG == 32, but would work with == 64, or 
anything but 8 for that matter! :)

 >#define DECLARE_BITMAP(name,bits) \
 >	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 >#define CLEAR_BITMAP(name,bits) \
 >	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)

If, for example, we DECLARE_BITMAP(foo, 64), we're going to get:
	unsigned long foo[((64)+32-1)/32] =>
	unsigned long foo[95/32] =>
	unsigned long foo[2]

Now, that's all well and good (and correct! ;)  But, look at what 
happens if we do a CLEAR_BITMAP(foo, 64):
	memset(foo, 0, ((64)+32-1)/8) =>
	memset(foo, 0, 95/8) =>
	memset(foo, 0, 11)

So the memset is going to try and clear 11 bytes starting at foo, which 
will overflow the foo array by 3 bytes.  This is bad.

What CLEAR_BITMAP wants to be doing is this:
  #define CLEAR_BITMAP(name,bits) \
  	memset(name, 0, 
(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long))

Attatched is a patch that creates a macro BITS_TO_LONGS that just rounds 
a number of bits up to the closest number of unsigned longs.  This makes 
the DECLARE & CLEAR _BITMAP macros more readable.  I also modify the 
CLEAR_BITMAP macro to work correctly.

Cheers!

-Matt

--------------090200050803090100010802
Content-Type: text/plain;
 name="clear_bitmap_fix-2.5.59.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clear_bitmap_fix-2.5.59.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/linux/types.h linux-2.5.59-bitmap_fix/include/linux/types.h
--- linux-2.5.59-vanilla/include/linux/types.h	Thu Jan 16 18:22:41 2003
+++ linux-2.5.59-bitmap_fix/include/linux/types.h	Thu Feb  6 13:51:23 2003
@@ -4,10 +4,12 @@
 #ifdef	__KERNEL__
 #include <linux/config.h>
 
+#define BITS_TO_LONGS(bits) \
+	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+	unsigned long name[BITS_TO_LONGS(bits)]
 #define CLEAR_BITMAP(name,bits) \
-	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
+	memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
 #endif
 
 #include <linux/posix_types.h>

--------------090200050803090100010802--

