Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWFWTno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWFWTno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbWFWTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:43:44 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:24804 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751961AbWFWTnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:43:43 -0400
Message-ID: <449C446C.3020605@tilera.com>
Date: Fri, 23 Jun 2006 15:43:40 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: compiler warning from cryptic pointer math
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2006 19:43:41.0860 (UTC) FILETIME=[54B3CE40:01C696FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Using the format from REPORTING-BUGS...)

[1.] compiler warning from cryptic pointer math

[2.] This change simplifies a cryptic macro in fs/readdir.c.  Rather
than subtracting an uninitialized pointer's d_name field address from
the uninitialized pointer base to get the field offset, we just use the
normal "offsetof" idiom to directly get the d_name field address from a
pointer to zero.  We can't use offsetof directly since the variable type
we have handy is a pointer, not the structure type itself.

(Our compiler is a gcc-alike that can figure out that it doesn't need to 
warn about things like "foo - foo" for an uninitialized pointer foo, but 
the field reference makes it think the pointer is truly being used; the 
warning made me look more closely at this piece of code.)

[4.] The kernel version is 2.6.17.1.

[X.]

--- /tmp/tmp.3955.0     2006-06-23 10:10:54.000000000 -0400
+++ /u/cmetcalf/linux/fs/readdir.c  2006-06-23 10:09:07.000000000 -0400
@@ -51,7 +51,7 @@
  * anyway. Thus the special "fillonedir()" function for that
  * case (the low-level handlers don't need to care about this).
  */
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
+#define NAME_OFFSET(de) ((int) ((typeof(de))0)->d_name)
#define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))

#ifdef __ARCH_WANT_OLD_READDIR

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


