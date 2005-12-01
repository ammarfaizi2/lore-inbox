Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVLAPzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVLAPzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVLAPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:55:51 -0500
Received: from rtr.ca ([64.26.128.89]:29895 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932279AbVLAPzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:55:50 -0500
Message-ID: <438F1D05.5020004@rtr.ca>
Date: Thu, 01 Dec 2005 10:55:49 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix bytecount result from printk()
Content-Type: multipart/mixed;
 boundary="------------030505030106040607000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030505030106040607000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

printk() returns a bytecount, which nothing actually appears to use.

This count is generated internally in vprintk(),
and is off-by-3 for one particular path through that function.

This patch fixes it to be consistent with how it is calculated
for the other paths through that same function (vprintk).

Whether or not the count should even exist in the first place
is still a question for examination -- nothing appears to use it.

On a related note, WHY does the LOG LEVEL format <6> not get
interpreted correctly for the first printk() after an oops report?
As in this example -- the <6> is printed, instead of being interpreted:

	kernel:  <6>note: insmod[31060] exited with preempt_count 1

Here's the off-by-3 fix patch.

Signed-off-by:  Mark Lord <lkml@rtr.ca>

--- linux-2.6.15-rc3/kernel/printk.c.orig       2005-11-29 23:24:19.000000000 -0500
+++ linux/kernel/printk.c       2005-12-01 10:01:39.000000000 -0500
@@ -592,8 +592,8 @@
                                         emit_log_char(default_message_loglevel
                                                 + '0');
                                         emit_log_char('>');
-                               }
-                               printed_len += 3;
+                               } else
+                                       printed_len += 3;
                         }
                         log_level_unknown = 0;
                         if (!*p)

--------------030505030106040607000403
Content-Type: text/x-patch;
 name="printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk.patch"

--- linux-2.6.15-rc3/kernel/printk.c.orig	2005-11-29 23:24:19.000000000 -0500
+++ linux/kernel/printk.c	2005-12-01 10:01:39.000000000 -0500
@@ -592,8 +592,8 @@
 					emit_log_char(default_message_loglevel
 						+ '0');
 					emit_log_char('>');
-				}
-				printed_len += 3;
+				} else
+					printed_len += 3;
 			}
 			log_level_unknown = 0;
 			if (!*p)

--------------030505030106040607000403--
