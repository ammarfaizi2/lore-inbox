Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266647AbUFWSwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUFWSwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUFWStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:49:12 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:10260 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266613AbUFWSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:48:14 -0400
Date: Wed, 23 Jun 2004 13:49:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC] replace assorted ASSERT()s by something officially 
 sanctioned
Message-ID: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: dcn@sgi.com (Dean Nelson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't appear that an officially 'sanctioned' version of ASSERT() or
an ASSERT()-like macro exists.

And by the proliferation of its use in the linux 2.6 kernel (I saw over
3000 references to it), it would seem that BUG_ON() does not satisfy all
of the requirements of the community.

One problem with BUG_ON() is that it is always enabled. And even though
the compiler does a good job of minimizing the impact of the conditional
expression, there are times when the conditional check requires the
accessing of a cacheline that would not get accessed had the BUG_ON() not
been enabled. And if that cacheline were one that is hotly contended for,
one's performance can be adversely affected.

For debugging purposes it would be nice to have a version of BUG_ON() that
was only enabled if DEBUG was set. This is what appears to be behind the use
of the ASSERT()-like macros.

As an example of what I have in mind, I've included the following quilt
patch.

Thanks,
Dean


Index: linux/include/asm-i386/bug.h
===================================================================
--- linux.orig/include/asm-i386/bug.h
+++ linux/include/asm-i386/bug.h
@@ -21,6 +21,12 @@
 
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 
+#ifdef DEBUG
+#define DBUG_ON(condition)	BUG_ON(condition)
+#else
+#define DBUG_ON(condition)
+#endif
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
