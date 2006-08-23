Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWHWVmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWHWVmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWHWVmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:42:02 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:5107 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S965221AbWHWVmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:42:00 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>
Subject: Serial custom speed deprecated?
Date: Wed, 23 Aug 2006 17:41:34 -0400
Organization: Connect Tech Inc.
Message-ID: <028a01c6c6fc$e792be90$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From
http://www.kernel.org/pub/linux/kernel/v2.5/ChangeLog-2.5.64

"<dwmw2@dwmw2.baythorne.internal>
	Complain about setting custom speed or divisor on serial ports."

And the relevant patch hunk:
@@ -832,8 +826,17 @@
                goto exit;
        if (info->flags & UIF_INITIALIZED) {
                if (((old_flags ^ port->flags) & UPF_SPD_MASK) ||
-                   old_custom_divisor != port->custom_divisor)
+                   old_custom_divisor != port->custom_divisor) {
+                       /* If they're setting up a custom divisor or speed,
+                        * instead of clearing it, then bitch about it. No
+                        * need to rate-limit; it's CAP_SYS_ADMIN only. */
+                       if (port->flags & UPF_SPD_MASK) {
+                               printk(KERN_NOTICE "%s sets custom speed on %s%d. This is deprecated.\n",
+                                      current->comm, info->tty->driver.name,
+                                      info->port->line);
+                       }
                        uart_change_speed(info, NULL);
+               }
        } else
                retval = uart_startup(info, 1);
  exit:

If custom speeds are deprecated, what's the new method for setting
them? Specifically, how can the SPD_CUST functionality be accomplished
without that flag? I've checked 2.5.64 and 2.6.17, and don't see how
it is possible.

..Stu

