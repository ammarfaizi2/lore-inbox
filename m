Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWBTXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWBTXcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWBTXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:32:14 -0500
Received: from ns1.siteground.net ([207.218.208.2]:21227 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1161193AbWBTXcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:32:13 -0500
Date: Mon, 20 Feb 2006 15:32:42 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: [patch] Cache align futex hash buckets
Message-ID: <20060220233242.GC3594@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following change places each element of the futex_queues hashtable on a 
different cacheline.  Spinlocks of adjacent hash buckets lie on the same 
cacheline otherwise.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc2/kernel/futex.c
===================================================================
--- linux-2.6.16-rc2.orig/kernel/futex.c	2006-02-07 23:14:04.000000000 -0800
+++ linux-2.6.16-rc2/kernel/futex.c	2006-02-09 14:04:22.000000000 -0800
@@ -100,9 +100,10 @@ struct futex_q {
 struct futex_hash_bucket {
        spinlock_t              lock;
        struct list_head       chain;
-};
+} ____cacheline_internodealigned_in_smp;
 
-static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
+static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] 
+				__cacheline_aligned_in_smp;
 
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
