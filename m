Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUEDSK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUEDSK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUEDSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:10:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37312 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264562AbUEDSKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:10:17 -0400
Subject: Re: [CHECKER] Memory Leak on commonly executed path in jfs_link
	(JFS 2.4, kernel 2.4.19)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0404301530400.14340-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404301530400.14340-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083694203.2201.144.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 May 2004 13:10:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 17:31, Junfeng Yang wrote:
> get_UCSname is a memory allocation function.  Should call
> free_UCSname(&dname) to free the allocated memory

I'm embarrassed to see how long this one has gone undetected.  Here's a
patch.  I'll send these to Marcelo and Linus after more complete
testing.

===== fs/jfs/namei.c 1.22 vs edited =====
--- 1.22/fs/jfs/namei.c	Wed Mar 24 14:55:56 2004
+++ edited/fs/jfs/namei.c	Tue May  4 12:54:00 2004
@@ -784,14 +784,14 @@
 		goto out;
 
 	if ((rc = dtSearch(dir, &dname, &ino, &btstack, JFS_CREATE)))
-		goto out;
+		goto free_dname;
 
 	/*
 	 * create entry for new link in parent directory
 	 */
 	ino = ip->i_ino;
 	if ((rc = dtInsert(tid, dir, &dname, &ino, &btstack)))
-		goto out;
+		goto free_dname;
 
 	/* update object inode */
 	ip->i_nlink++;		/* for new link */
@@ -803,6 +803,9 @@
 	iplist[0] = ip;
 	iplist[1] = dir;
 	rc = txCommit(tid, 2, &iplist[0], 0);
+
+      free_dname:
+	free_UCSname(&dname);
 
       out:
 	txEnd(tid);

-- 
David Kleikamp
IBM Linux Technology Center

