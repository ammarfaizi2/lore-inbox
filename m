Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUHKQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUHKQRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268091AbUHKQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:17:03 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:37936 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S268085AbUHKQOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:14:48 -0400
Subject: Re: [patch] preempt-smp.patch, 2.6.8-rc3-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       LKML <linux-kernel@vger.kernel.org>, Robert Love <rml@ximian.com>
In-Reply-To: <20040809140103.GA18106@elte.hu>
References: <20040809102125.GA12391@elte.hu>
	 <20040809032523.40250fe8.akpm@osdl.org> <20040809104533.GA13710@elte.hu>
	 <20040809140103.GA18106@elte.hu>
Content-Type: text/plain
Date: Wed, 11 Aug 2004 18:14:46 +0200
Message-Id: <1092240886.6554.20.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

from the preempt-smp patch:

@@ -306,6 +306,21 @@ static int invalidate_list(struct list_h
 		struct list_head * tmp = next;
 		struct inode * inode;
 
+		/*
+		 * Preempt if necessary. To make this safe we use a dummy
+		 * inode as a marker - we can continue off that point.
+		 * We rely on this sb's inodes (including the marker) not
+		 * getting reordered within the list during umount. Other
+		 * inodes might get reordered.
+		 */
+		if (need_resched_lock()) {
+			list_add_tail(mark, next);
+			spin_unlock(&inode_lock);
+			cond_resched();
+			spin_lock(&inode_lock);
+			tmp = next = mark->next;
+			list_del(mark);
+		}
 		next = next->next;
 		if (tmp == head)
 			break;


why use cond_resched in the loop if you use need_resched_lock in the condition?
cond_resched does not do the cpu_relax. Nor is it quite nice to use 
cond_resched_lock there since it would increment preempt_check_count again
causing the step to be 2 which in turn will make one miss the cpu_relax condition.

Peter Zijlstra



