Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUFRU6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUFRU6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUFRU5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:57:44 -0400
Received: from [81.187.239.184] ([81.187.239.184]:22468 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S262101AbUFRUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:54:00 -0400
Date: Fri, 18 Jun 2004 21:53:55 +0100
From: matthew-lkml@newtoncomputing.co.uk
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040618205355.GA5286@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have had problems recently with the output from dmesg. Somewhere in
the depths of ACPI (drivers/acpi/tables.c:104) the
header->asl_compiler_id contained non-printable characters, and it made
xterm stop displaying any more output. dmesg|less had to be used as less
filters out the duff chars.

The main problem seems to be in ACPI, but I don't see any reason for
printk to even consider printing _any_ non-printable characters at all.
It makes all characters out of the range 32..126 (except for newline)
print as a '?'.

Patch is for 2.6.7.

Matthew


--- linux-2.6.7/kernel/printk.c.orig	2004-06-18 20:44:28.000000000 +0100
+++ linux-2.6.7/kernel/printk.c	2004-06-18 20:53:36.000000000 +0100
@@ -14,6 +14,8 @@
  *     manfreds@colorfullife.com
  * Rewrote bits to get rid of console_lock
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
+ * Stop emit_log_char from emitting non-ASCII chars.
+ *  Matthew Newton, 18 June 2004 <matthew-lkml@newtoncomputing.co.uk>
  */
 
 #include <linux/kernel.h>
@@ -538,7 +540,11 @@
 			}
 			log_level_unknown = 0;
 		}
-		emit_log_char(*p);
+		if (p[0] != '\n' && (p[0] < 32 || p[0] > 126)) {
+			emit_log_char('?');
+		} else {
+			emit_log_char(*p);
+		}
 		if (*p == '\n')
 			log_level_unknown = 1;
 	}


