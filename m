Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129806AbQK3O63>; Thu, 30 Nov 2000 09:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129846AbQK3O6S>; Thu, 30 Nov 2000 09:58:18 -0500
Received: from [216.219.246.7] ([216.219.246.7]:50362 "EHLO shuswap.gate.net")
        by vger.kernel.org with ESMTP id <S129806AbQK3O6P>;
        Thu, 30 Nov 2000 09:58:15 -0500
Message-ID: <000301c05ad9$830bde10$df1a24cf@master>
Reply-To: "Steve Grubb" <steve@web-insights.net>
From: "Steve Grubb" <steve@web-insights.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor do_syslog cleanup
Date: Thu, 30 Nov 2000 09:26:17 -0500
Organization: Web Insights, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch removes extra setting of the error value in the do_syslog
function. The patch is against 2.2.16, but printk.c seems to have changed
little so it probably applies against other kernels.

See Ya,
Steve Grubb

--------------------

--- printk.orig Thu Nov 30 07:58:58 2000
+++ printk.c    Thu Nov 30 08:55:07 2000
@@ -123,19 +123,18 @@
        unsigned long i, j, limit, count;
        int do_clear = 0;
        char c;
-       int error = -EPERM;
+       int error = 0;

-       error = 0;
        switch (type) {
        case 0:         /* Close log */
                break;
        case 1:         /* Open log */
                break;
        case 2:         /* Read from log */
-               error = -EINVAL;
-               if (!buf || len < 0)
+               if (!buf || len < 0) {
+                       error = -EINVAL;
                        goto out;
-               error = 0;
+               }
                if (!len)
                        goto out;
                error = verify_area(VERIFY_WRITE,buf,len);
@@ -163,10 +162,10 @@
                do_clear = 1;
                /* FALL THRU */
        case 3:         /* Read last kernel messages */
-               error = -EINVAL;
-               if (!buf || len < 0)
+               if (!buf || len < 0) {
+                       error = -EINVAL;
                        goto out;
-               error = 0;
+               }
                if (!len)
                        goto out;
                error = verify_area(VERIFY_WRITE,buf,len);
@@ -224,15 +223,15 @@
                spin_unlock_irq(&console_lock);
                break;
        case 8:
-               error = -EINVAL;
-               if (len < 1 || len > 8)
+               if (len < 1 || len > 8) {
+                       error = -EINVAL;
                        goto out;
+               }
                if (len < minimum_console_loglevel)
                        len = minimum_console_loglevel;
                spin_lock_irq(&console_lock);
                console_loglevel = len;
                spin_unlock_irq(&console_lock);
-               error = 0;
                break;
        default:
                error = -EINVAL;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
