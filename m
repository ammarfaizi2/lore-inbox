Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTB1Gpy>; Fri, 28 Feb 2003 01:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTB1Gpy>; Fri, 28 Feb 2003 01:45:54 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:64016 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S267482AbTB1Gpx>; Fri, 28 Feb 2003 01:45:53 -0500
Date: Fri, 28 Feb 2003 12:39:05 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: kernel Ooops (2.5.63 bk latest)
Message-ID: <20030228070905.GA11135@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030226113718.GA3568@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226113718.GA3568@gemtek.lt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The BUG was caught in d_validate() --> dget(). I think the 
dentry to be validated can be already on LRU list with d_count 
as zero. So, dget_locked should be used in place of dget(). 
dcache_rcu mistakingly used dget. This patch corrects it.

Please apply the following patch.

diff -urN linux-2.5.63-bk3/fs/dcache.c linux-2.5.63-bk3-d_validate/fs/dcache.c
--- linux-2.5.63-bk3/fs/dcache.c	2003-02-28 12:06:09.000000000 +0530
+++ linux-2.5.63-bk3-d_validate/fs/dcache.c	2003-02-28 12:16:30.000000000 +0530
@@ -1056,7 +1056,7 @@
 		 * as it is parsed under dcache_lock
 		 */
 		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-			dget(dentry);
+			__dget_locked(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
 		}


Regards,
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
