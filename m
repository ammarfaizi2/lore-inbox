Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273253AbRINBvb>; Thu, 13 Sep 2001 21:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273254AbRINBvV>; Thu, 13 Sep 2001 21:51:21 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:15378 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S273253AbRINBvM>; Thu, 13 Sep 2001 21:51:12 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: alan@redhat.com, Jan Kara <jack@suse.cz>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2.20: Avoid buffer overrun in quota warning
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Sep 2001 18:50:01 -0700
Message-Id: <E15hi7F-0004jm-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The quota code in several places does an sprintf() to a fixed (75 char) 
buffer, where one of the format arguments is a directory name. If your 
mountpoints have long enough names, this can easily overflow and 
corrupt data following the buffer.

This has been fixed in 2.4, but not in 2.2.20pre. There are three ways 
to fix it:

a) backport the delayed warning code from 2.4, which doesn't use sprintf

b) increase the buffer size

c) limit the %s directives in the sprintf() format string.

Given that 2.2.20 is about to be frozen, this patch takes option b, 
increasing the buffer size to be equal to the maximum directory name 
length passed to mount() (PAGE_SIZE) plus some slop for the rest of the 
string to be printed. Maybe for 2.2.21 it might be worth backporting 
the delayed warning code.

Paul

--- linux.orig/include/linux/quota.h    Tue Jun 12 00:56:52 2001
+++ linux/include/linux/quota.h Thu Sep 13 18:21:23 2001
@@ -155,7 +155,7 @@
  * Maximum length of a message generated in the quota system,
  * that needs to be kicked onto the tty.
  */
-#define MAX_QUOTA_MESSAGE 75
+#define MAX_QUOTA_MESSAGE (PAGE_SIZE + 256)
 
 #define DQ_LOCKED     0x01     /* locked for update */
 #define DQ_WANT       0x02     /* wanted for update */


