Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUAPKRZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUAPKRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:17:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21451 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265365AbUAPKRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:17:22 -0500
Date: Fri, 16 Jan 2004 15:52:11 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
Message-ID: <20040116102211.GC1276@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <400762F9.5010908@comcast.net> <20040116094037.GA1276@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116094037.GA1276@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 03:10:37PM +0530, Maneesh Soni wrote:
> 
[..]
> Can you elaborate on the recreation scenario a little bit more or if possible
> run this debug patch on top of -mm3. This should print some info about the 
> bad dentry.
> 


Walt,

Pleae run this debug patch instead of the previous one. Thanks to Andrew
for suggestion.


 fs/dcache.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN fs/dcache.c~prune_dcache-debug fs/dcache.c
--- linux-2.6.1-mm3/fs/dcache.c~prune_dcache-debug	2004-01-16 14:36:00.000000000 +0530
+++ linux-2.6.1-mm3-maneesh/fs/dcache.c	2004-01-16 15:41:26.000000000 +0530
@@ -344,6 +344,12 @@ static inline void prune_one_dentry(stru
 	struct dentry * parent;
 
 	__d_drop(dentry);
+	if (dentry->d_child.next->prev != &dentry->d_child) {
+		printk("Bad dentry for %s count %d %p %p\n", dentry->d_name.name, atomic_read(&dentry->d_count), dentry->d_child.next, dentry->d_child.prev);
+		if (dentry->d_sb)
+			printk("Super block magic %lx\n", dentry->d_sb->s_magic);
+		BUG();
+	}
 	list_del(&dentry->d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
 	dentry_iput(dentry);

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
