Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWFONFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWFONFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWFONFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 09:05:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:39733 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030393AbWFONFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 09:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        b=BbkT+oHRZvbAEqVgzIpWunsdSd0rM2gFek7RQ4ypqFYRJiG+F1f00s9pR7GbiOP3JOC/G7tBYW0OhxK+WlU5zLeLL8SQVJQ021G/BY/+37H3PSMOn3OWkIjsVPZMdP0aFVv0g/82Qyzu+N0Hh+FRQK2zeTMR13vFk5Skza/BoRc=
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <542727CE-8E10-44EB-98E7-15481DE45259@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Subject: sys_poll with timeout -1 bug fix
Date: Thu, 15 Jun 2006 15:05:00 +0200
To: akpm@osdl.org, Nishanth Aravamudan <nacc@us.ibm.com>
X-Mailer: Apple Mail (2.749.3)
From: frode isaksen <frode.isaksen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you do a poll() call with timeout -1, the wait will be a big  
number (depending on HZ)  instead of infinite wait, since -1 is  
passed to the msecs_to_jiffies function.
Tested on i386 and MIPS with latest (2.6.16) kernel.

Frode


--- linux-2.6.16.20/fs/select.c.orig.c	2006-06-05 19:18:23.000000000  
+0200
+++ linux-2.6.16.20/fs/select.c	2006-06-15 14:20:47.000000000 +0200
@@ -699,9 +699,9 @@ out_fds:
asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
			long timeout_msecs)
{
-	s64 timeout_jiffies = 0;
+	s64 timeout_jiffies;
-	if (timeout_msecs) {
+	if (timeout_msecs > 0) {
#if HZ > 1000
		/* We can only overflow if HZ > 1000 */
		if (timeout_msecs / 1000 > (s64)0x7fffffffffffffffULL / (s64)HZ)
@@ -709,6 +709,9 @@ asmlinkage long sys_poll(struct pollfd _
		else
#endif
			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
+	} else {
+		/* Infinite (-1) or no (0) timeout */
+		timeout_jiffies = timeout_msecs;
	}
	return do_sys_poll(ufds, nfds, &timeout_jiffies);

