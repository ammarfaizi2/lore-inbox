Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVJNPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVJNPCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVJNPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 11:02:42 -0400
Received: from mail.udag.de ([62.146.33.70]:35286 "EHLO mail.udag.de")
	by vger.kernel.org with ESMTP id S1750744AbVJNPCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 11:02:41 -0400
From: "Stephan Brodkorb" <stephan-linuxdev@brodkorb.com>
To: <linux-kernel@vger.kernel.org>
Cc: <adobriyan@gmail.com>, <rubini@vision.unipv.it>,
       <rmk+serial@arm.linux.org.uk>, <linux-serial@vger.kernel.org>,
       <Markus_Daniel@gmx.de>
Subject: [PATCH 1/1] n_r3964 fix - char
Date: Fri, 14 Oct 2005 17:02:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXQ0FO5ZllYBtnmQWSz23aIqDpYzQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Message-Id: <20051014150238.B105980CD@mail.udag.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.14-rc4-orig/drivers/char/n_r3964.c	2005-10-11
03:19:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/char/n_r3964.c	2005-10-14
15:05:29.589643200 +0200
@@ -695,7 +695,7 @@
             {
                TRACE_PE("IDLE - got STX but no space in rx_queue!");
                pInfo->state=R3964_WAIT_FOR_RX_BUF;
-	       mod_timer(&pInfo->tmr, R3964_TO_NO_BUF);
+	       mod_timer(&pInfo->tmr, jiffies + R3964_TO_NO_BUF);
                break;
             }
 start_receiving:
@@ -705,7 +705,7 @@
             pInfo->last_rx = 0;
             pInfo->flags &= ~R3964_ERROR;
             pInfo->state=R3964_RECEIVING;
-	    mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+	    mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
 	    pInfo->nRetry = 0;
             put_char(pInfo, DLE);
             flush(pInfo);
@@ -732,7 +732,7 @@
                if(pInfo->flags & R3964_BCC)
                {
                   pInfo->state = R3964_WAIT_FOR_BCC;
-		  mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+		  mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
                }
                else 
                {
@@ -744,7 +744,7 @@
                pInfo->last_rx = c;
 char_to_buf:
                pInfo->rx_buf[pInfo->rx_position++] = c;
-	       mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+	       mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
             }
          }
         /* else: overflow-msg? BUF_SIZE>MTU; should not happen? */ 


Hi everybody,

since Revision 1.10  was released the n_r3964 module wasn't able to receive
any data. The reason for that behavior is because there were some wrong
calls of mod_timer(...) in the function receive_char (...).
This patch should fix this problem and was successfully tested with talking
to some kuka industrial robots.

Greetings,

Stephan Brodkorb

