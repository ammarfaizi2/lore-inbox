Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUH0Qyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUH0Qyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUH0Qyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:54:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42429 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266595AbUH0Qyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:54:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093556379.5678.109.camel@krustophenia.net>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>
	 <1093556379.5678.109.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093625672.837.25.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 12:54:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 17:39, Lee Revell wrote:
> On Tue, 2004-08-24 at 02:14, Ingo Molnar wrote:
> 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> > 
> 
> Hmm, it seems that those strange ~1ms latencies are back.  This was
> triggered by mounting an NTFS volume:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace5.txt
> 

I think vger was messed up yesterday, as this did not get through the
first time I sent it, and I did not get any messages from the list for
4-5 hours last night.

I am seeing large latencies (600-2000 usec) latencies in
dcache_readdir.  This started when the machine became a Samba server and
the dcache presumably got large.  Traces are at the above url (8 and 9 I
believe).  I think this patch fixes it.

--- fs/libfs.c~	2004-08-14 06:54:47.000000000 -0400
+++ fs/libfs.c	2004-08-27 00:44:17.000000000 -0400
@@ -140,6 +140,7 @@
 			}
 			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
 				struct dentry *next;
+				voluntary_resched_lock(&dcache_lock);
 				next = list_entry(p, struct dentry, d_child);
 				if (d_unhashed(next) || !next->d_inode)
 					continue;


Lee

