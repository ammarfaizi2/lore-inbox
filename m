Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbUAPJgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUAPJgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:36:02 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:33193 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265338AbUAPJfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:35:52 -0500
Date: Fri, 16 Jan 2004 15:10:37 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
Message-ID: <20040116094037.GA1276@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <400762F9.5010908@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400762F9.5010908@comcast.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 08:05:13PM -0800, Walt H wrote:
> Hi Maneesh,
> 
> I've had a pretty repeatible case of the BUG in list.h from attempting
> backups via rsync. This has persisted thru 2.6.1-mm3. I reverted the
> race fix patch at:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm3/broken-out/sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
> 
> Which allows my rsync to finish properly.

Hi Walt,

This patch is needed for a different race. We get hangs when we read and
remove a sysfs directory at the same time on an SMP box. It is easily
recreated by running following two loops. (Obviously without this fix)

while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
while true; do find /sys/class/net > /dev/null; done

I am still not convinced that this fix will cause any problem. 

The kswapd problem what I have understood so far, is happening because of a 
bad d_child pointer in the dentry. As it is hitting the list_del BUG(), and the 
only list_del in prune_dcache() is for d_child list pointer. I suspect dentry
from d_child list is being deleted more than once. 

Can you elaborate on the recreation scenario a little bit more or if possible
run this debug patch on top of -mm3. This should print some info about the 
bad dentry.

Thanks
Maneesh

 fs/dcache.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN fs/dcache.c~prune_dcache-debug fs/dcache.c
--- linux-2.6.1-mm3/fs/dcache.c~prune_dcache-debug	2004-01-16 14:36:00.000000000 +0530
+++ linux-2.6.1-mm3-maneesh/fs/dcache.c	2004-01-16 15:03:25.000000000 +0530
@@ -344,6 +344,13 @@ static inline void prune_one_dentry(stru
 	struct dentry * parent;
 
 	__d_drop(dentry);
+	if (dentry->d_child.next->prev != &dentry->d_child) {
+		printk("Bad dentry for %s flags %lx, %d\n", dentry->d_name.name,
+			dentry->d_vfs_flags, atomic_read(&dentry->d_count));
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
