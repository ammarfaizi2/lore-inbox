Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKTFf4>; Wed, 20 Nov 2002 00:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSKTFf4>; Wed, 20 Nov 2002 00:35:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:11660 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265787AbSKTFfz>;
	Wed, 20 Nov 2002 00:35:55 -0500
Message-ID: <3DDB20DC.7C8BE115@digeo.com>
Date: Tue, 19 Nov 2002 21:42:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rebecca.Callan@ir.com
CC: linux-kernel@vger.kernel.org
Subject: Re: decrement of inodes_stat.nr_inodes in inode.c not SMP safe?
References: <694BB7191495D51183A9005004C0B05482D50E@ir-exchange-srv.ir.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 05:42:52.0730 (UTC) FILETIME=[AB1F39A0:01C29057]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rebecca.Callan@ir.com wrote:
> 
> The value for nr_inodes in /proc/sys/fs/inode-state appears to be wrong.
> 
> I think this is probably a bug in all 2.4 smp kernels. I've seen it in
> 2.4.8-26mdksmp and 2.4.18-3smp.
> 

Is true.  The 2.5 change needs to be backported.


--- linux-akpm/fs/inode.c~inodes_stat-race	Tue Nov 19 21:42:08 2002
+++ linux-akpm-akpm/fs/inode.c	Tue Nov 19 21:42:23 2002
@@ -532,22 +532,25 @@ void clear_inode(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head * head)
+static void dispose_list(struct list_head *head)
 {
-	struct list_head * inode_entry;
-	struct inode * inode;
+	int nr_disposed = 0;
 
-	while ((inode_entry = head->next) != head)
-	{
-		list_del(inode_entry);
+	while (!list_empty(head)) {
+		struct inode *inode;
+
+		inode = list_entry(head->next, struct inode, i_list);
+		list_del(&inode->i_list);
 
-		inode = list_entry(inode_entry, struct inode, i_list);
 		if (inode->i_data.nrpages)
 			truncate_inode_pages(&inode->i_data, 0);
 		clear_inode(inode);
 		destroy_inode(inode);
-		inodes_stat.nr_inodes--;
+		nr_disposed++;
 	}
+	spin_lock(&inode_lock);
+	inodes_stat.nr_inodes -= nr_disposed;
+	spin_unlock(&inode_lock);
 }
 
 /*

_
