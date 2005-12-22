Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVLVKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLVKy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVLVKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:54:26 -0500
Received: from mail.rs4.huwig.de ([212.88.142.131]:62641 "HELO
	sponts.iku-ag.de") by vger.kernel.org with SMTP id S932110AbVLVKyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:54:25 -0500
Message-ID: <43AA85DD.6050000@iku-ag.de>
Date: Thu, 22 Dec 2005 11:54:21 +0100
From: Kurt Huwig <k.huwig@iku-ag.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: [PATCH 2.x] n_r3964: fixed usage of HZ and mod_timer(); removed bad
 include
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SPONTS-Version: 2.3.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The n_r3964 driver did not work any more with any 2.6 kernel. The
reasons for this were

- HZ assumed to be 100
- jiffies forgotten in call to mod_timer()

In the header file, there was an unnecessary include of
<asm/termio.h> which made it nearly impossible to compile any
code against it, as it caused definition duplicates with
<termio.h>.

The patch probably should be applied to the other 2.x kernels, too.

--- linux-source-2.6.12/include/linux/n_r3964.h.orig	2005-12-21 19:49:00.000000000 +0100
+++ linux-source-2.6.12/include/linux/n_r3964.h	2005-12-21 20:21:18.000000000 +0100
@@ -13,6 +13,10 @@
  * L. Haag
  *
  * $Log: r3964.h,v $
+ * Revision 1.4  2005/12/21 19:54:24  Kurt Huwig <kurt huwig de>
+ * Fixed HZ usage on 2.6 kernels
+ * Removed unnecessary include
+ *
  * Revision 1.3  2001/03/18 13:02:24  dwmw2
  * Fix timer usage, use spinlocks properly.
  *
@@ -45,9 +49,11 @@
 #define __LINUX_N_R3964_H__

 /* line disciplines for r3964 protocol */
-#include <asm/termios.h>

 #ifdef __KERNEL__
+
+#include <linux/param.h>
+
 /*
  * Common ascii handshake characters:
  */
@@ -58,14 +64,14 @@
 #define NAK 0x15

 /*
- * Timeouts (msecs/10 msecs per timer interrupt):
+ * Timeouts (from milliseconds to jiffies)
  */

-#define R3964_TO_QVZ 550/10
-#define R3964_TO_ZVZ 220/10
-#define R3964_TO_NO_BUF 400/10
-#define R3964_NO_TX_ROOM 100/10
-#define R3964_TO_RX_PANIC 4000/10
+#define R3964_TO_QVZ msecs_to_jiffies(550)
+#define R3964_TO_ZVZ msecs_to_jiffies(220)
+#define R3964_TO_NO_BUF msecs_to_jiffies(400)
+#define R3964_NO_TX_ROOM msecs_to_jiffies(100)
+#define R3964_TO_RX_PANIC msecs_to_jiffies(4000)
 #define R3964_MAX_RETRIES 5

 #endif
--- linux-source-2.6.12/drivers/char/n_r3964.c.orig	2005-12-21 19:48:34.000000000 +0100
+++ linux-source-2.6.12/drivers/char/n_r3964.c	2005-12-21 20:17:14.000000000 +0100
@@ -13,6 +13,9 @@
  * L. Haag
  *
  * $Log: n_r3964.c,v $
+ * Revision 1.11  2005/12/21 19:54:24  Kurt Huwig <kurt huwig de>
+ * Missing jiffies in call to mod_timer()
+ *
  * Revision 1.10  2001/03/18 13:02:24  dwmw2
  * Fix timer usage, use spinlocks properly.
  *
@@ -217,7 +220,7 @@ static int __init r3964_init(void)
 {
    int status;

-   printk ("r3964: Philips r3964 Driver $Revision: 1.10 $\n");
+   printk ("r3964: Philips r3964 Driver $Revision: 1.11 $\n");

    /*
     * Register the tty line discipline
@@ -695,7 +698,7 @@ static void receive_char(struct r3964_in
             {
                TRACE_PE("IDLE - got STX but no space in rx_queue!");
                pInfo->state=R3964_WAIT_FOR_RX_BUF;
-	       mod_timer(&pInfo->tmr, R3964_TO_NO_BUF);
+	       mod_timer(&pInfo->tmr, jiffies + R3964_TO_NO_BUF);
                break;
             }
 start_receiving:
@@ -705,7 +708,7 @@ start_receiving:
             pInfo->last_rx = 0;
             pInfo->flags &= ~R3964_ERROR;
             pInfo->state=R3964_RECEIVING;
-	    mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+	    mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
 	    pInfo->nRetry = 0;
             put_char(pInfo, DLE);
             flush(pInfo);
@@ -732,7 +735,7 @@ start_receiving:
                if(pInfo->flags & R3964_BCC)
                {
                   pInfo->state = R3964_WAIT_FOR_BCC;
-		  mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+		  mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
                }
                else
                {
@@ -744,7 +747,7 @@ start_receiving:
                pInfo->last_rx = c;
 char_to_buf:
                pInfo->rx_buf[pInfo->rx_position++] = c;
-	       mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+	       mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
             }
          }
         /* else: overflow-msg? BUF_SIZE>MTU; should not happen? */


 Developer's Certificate of Origin 1.1

 By making a contribution to this project, I certify that:

 (a) The contribution was created in whole or in part by me and I
     have the right to submit it under the open source license
     indicated in the file; or

 (b) The contribution is based upon previous work that, to the best
     of my knowledge, is covered under an appropriate open source
     license and I have the right under that license to submit that
     work with modifications, whether created in whole or in part
     by me, under the same open source license (unless I am
     permitted to submit under a different license), as indicated
     in the file; or

 (c) The contribution was provided directly to me by some other
     person who certified (a), (b) or (c) and I have not modified
     it.

 (d) I understand and agree that this project and the contribution
     are public and that a record of the contribution (including all
     personal information I submit with it, including my sign-off) is
     maintained indefinitely and may be redistributed consistent with
     this project or the open source license(s) involved.

 Signed-off-by: Kurt Huwig <k.huwig iku-ag de>

