Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271506AbRHPGtc>; Thu, 16 Aug 2001 02:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271509AbRHPGtW>; Thu, 16 Aug 2001 02:49:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3754 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271506AbRHPGtO>; Thu, 16 Aug 2001 02:49:14 -0400
From: "David Stevens" <dlstevens@us.ibm.com>
Importance: Normal
Subject: setrlimit() nit
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFDF9D5E45.762AD13F-ON88256AAA.00253EAC@boulder.ibm.com>
Date: Wed, 15 Aug 2001 23:53:25 -0700
X-MIMETrack: Serialize by Router on D03NM104/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/16/2001 12:53:27 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The setrlimit() system call doesn't enforce rlim_cur <= rlim_max. This can
lead
to some unexpected results. For example, if you call setrlimit() with
RLIMIT_CPU with a hard limit of 60 secs, and a soft limit of "unlimited",
nothing will ever happen-- the hard limit is ignored, because it's never
checked if the soft limit hasn't been exceeded first (see kernel/timer.c).
     BSD had the same flaw-- always annoyed me. Simple fix (below). Diffs
are for 2.4.8.

                              +-DLS


--- linux/kernel/sys.c   Thu Jul 26 13:43:33 2001
+++ linux.NEW/kernel/sys.c    Thu Aug 16 00:20:14 2001
@@ -1119,6 +1119,8 @@
          return -EINVAL;
     if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
          return -EFAULT;
+    if (new_rlim.rlim_cur > new_rlim.rlim_max)
+         new_rlim.rlim_cur = new_rlim.rlim_max;
     old_rlim = current->rlim + resource;
     if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
          (new_rlim.rlim_max > old_rlim->rlim_max)) &&


