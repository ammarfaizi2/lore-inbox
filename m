Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJQOI2>; Thu, 17 Oct 2002 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJQOI2>; Thu, 17 Oct 2002 10:08:28 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:46525 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261584AbSJQOI0>; Thu, 17 Oct 2002 10:08:26 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <87smza1p7f.fsf@goat.bogus.local>
	<87bs5tba9j.fsf@goat.bogus.local>
	<20021017053014.C26442@figure1.int.wirex.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 17 Oct 2002 16:14:05 +0200
Message-ID: <87bs5t9mqa.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chris@wirex.com> writes:

> * Olaf Dietsche (olaf.dietsche#list.linux-kernel@t-online.de) wrote:
>> 
>> I haven't got a convincing answer against this patch, so far. The
>> patch applies to 2.5.43 as well.
>> Linus, please apply.

Hehe, "please apply" is watched a lot more closely, it seems. Good to
know ;-)

> No way.  This is clearly a bad idea.  CAP_SYS_RAWIO should be treated very
> seriously, look at what it enables.  CAP_DAC_OVERRIDE is substantially
> less powerful, and if you remove this check, it would be the only
> capability protecting this.

$ grep -r CAP_SYS_RAWIO v2.5.43 | wc
55

Well, since CAP_SYS_RAWIO is such a dangerous beast and /dev/kmem can't
live without, then something like CAP_SYS_KMEM would be more
appropriate.

Here's a new untested patch against 2.5.43. Comments?

Regards, Olaf.

diff -urN a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Sat Oct  5 18:44:55 2002
+++ b/drivers/char/mem.c	Thu Oct 17 16:02:56 2002
@@ -525,7 +525,7 @@
 
 static int open_port(struct inode * inode, struct file * filp)
 {
-	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+	return capable(CAP_SYS_KMEM) ? 0 : -EPERM;
 }
 
 #define mmap_kmem	mmap_mem
diff -urN a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h	Sat Oct  5 18:43:38 2002
+++ b/include/linux/capability.h	Thu Oct 17 16:02:35 2002
@@ -283,6 +283,10 @@
 
 #define CAP_LEASE            28
 
+/* Allow access to system memory */
+
+#define CAP_SYS_KMEM         29
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
