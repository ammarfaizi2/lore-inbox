Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbULUXvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbULUXvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbULUXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:51:25 -0500
Received: from siaag1ag.compuserve.com ([149.174.40.13]:7080 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261902AbULUXvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:51:21 -0500
Date: Tue, 21 Dec 2004 18:49:13 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac16
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Ross <chris@tebibyte.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200412211850_MC3-1-916E-59A6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:

>  I backported this patch to 2.6.9 but haven't tested it yet.  It requires the
> 'spurious oomkill' patch I posted earlier in this thread.  Early reports
> are that it stops the freezes during heavy paging.

 OK here's one that actually compiles.  (3AM was not a good time to be
making patches.)

# mm_swap_token_disable.patch
#       include/linux/swap.h -0 +1
#       mm/rmap.c -0 +3
#       mm/thrash.c -1 +4
#
#       NOTE: On 2.6.9 there is no sysctl to change
#             swap_token_default_timeout.
#
#       Based on a patch by Con Kolivas for 2.6.10
#       Backported to 2.6.9 by Chuck Ebbert <76306.1226@compuserve.com>
#
--- 2.6.9.1/include/linux/swap.h
+++ 2.6.9.2/include/linux/swap.h
@@ -230,6 +230,7 @@
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
+extern unsigned long swap_token_default_timeout;
 extern void grab_swap_token(void);
 extern void __put_swap_token(struct mm_struct *);
 
--- 2.6.9.1/mm/rmap.c
+++ 2.6.9.2/mm/rmap.c
@@ -394,6 +394,9 @@ int page_referenced(struct page *page, i
 {
        int referenced = 0;
 
+       if (!swap_token_default_timeout)
+               ignore_token = 1;
+
        if (page_test_and_clear_young(page))
                referenced++;
 
--- 2.6.9.1/mm/thrash.c
+++ 2.6.9.2/mm/thrash.c
@@ -19,7 +19,11 @@ unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+#define SWAP_TOKEN_TIMEOUT     0
+/*
+ * Currently disabled; Needs further code to work at HZ * 300.
+ */
+unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
 
 /*
  * Take the token away if the process had no page faults
_
--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
