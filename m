Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267570AbRGSO3q>; Thu, 19 Jul 2001 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRGSO30>; Thu, 19 Jul 2001 10:29:26 -0400
Received: from irate.zereau.net ([62.32.64.1]:5128 "EHLO irate.zereau.net")
	by vger.kernel.org with ESMTP id <S267577AbRGSO3U>;
	Thu, 19 Jul 2001 10:29:20 -0400
Message-ID: <3B56EEC2.6C3B8E76@zereau.net>
Date: Thu, 19 Jul 2001 15:29:22 +0100
From: Alex Holden <alexh@zereau.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: getrusage() patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This patch fixes Squid's cacheMaxResSize statistic by causing
getrusage() to fill in the ru_maxrss member rather than leave it as 0.
Is it correct?

--- linux-2.4.6-clean/kernel/sys.c      Thu Jul 19 12:18:15 2001
+++ linux-2.4.6-getrusage-fixed/kernel/sys.c    Thu Jul 19 11:59:24 2001

@@ -1154,6 +1154,7 @@
 int getrusage(struct task_struct *p, int who, struct rusage *ru)
 {
        struct rusage r;
+       struct mm_struct *mm;

        memset((char *) &r, 0, sizeof(r));
        switch (who) {
@@ -1165,6 +1166,13 @@
                        r.ru_minflt = p->min_flt;
                        r.ru_majflt = p->maj_flt;
                        r.ru_nswap = p->nswap;
+                       task_lock(p);
+                       if((mm = p->mm)) atomic_inc(&mm->mm_users);
+                       task_unlock(p);
+                       if(mm) {
+                               r.ru_maxrss = mm->rss;
+                               mmput(mm);
+                       }
                        break;
                case RUSAGE_CHILDREN:
                        r.ru_utime.tv_sec =
CT_TO_SECS(p->times.tms_cutime);


--------------------------------------------------------------------
This email has been Scanned for Viruses by Zereau Internet
For Info Tel: +44 (0)1642 867700  |  www.zereau.net
