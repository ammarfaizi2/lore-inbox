Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUEGT6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUEGT6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUEGT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 15:56:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:41446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263712AbUEGTzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:55:50 -0400
Date: Fri, 7 May 2004 12:41:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: paul@clubi.ie, arjanv@redhat.com, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040507124157.7705bf77.akpm@osdl.org>
In-Reply-To: <535920000.1083943568@[10.10.2.4]>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405051312.30626.dominik.karall@gmx.net>
	<200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
	<20040505215136.GA8070@wohnheim.fh-wedel.de>
	<200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
	<1083858033.3844.6.camel@laptop.fenrus.com>
	<Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
	<20040506195002.520b0793.akpm@osdl.org>
	<Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org>
	<20040506205838.6948a018.akpm@osdl.org>
	<535920000.1083943568@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 2 nfs_writepage_sync is a known stack-abuser ;-) 1632 bytes on PPC64 at least
>  (from Anton's data). Maybe it's that struct nfs_write_data ?

 (from Anton's data). Maybe it's that struct nfs_write_data ?


diff -puN fs/nfs/write.c~nfs_writepage_sync-stack-reduction fs/nfs/write.c
--- 25/fs/nfs/write.c~nfs_writepage_sync-stack-reduction	2004-05-07 12:36:51.648098192 -0700
+++ 25-akpm/fs/nfs/write.c	2004-05-07 12:39:41.320304096 -0700
@@ -179,7 +179,13 @@ static int nfs_writepage_sync(struct fil
 {
 	unsigned int	wsize = NFS_SERVER(inode)->wsize;
 	int		result, written = 0;
-	struct nfs_write_data	wdata = {
+	struct nfs_write_data *wdata;
+
+	wdata = kmalloc(sizeof(*wdata), GFP_NOFS);
+	if (!wdata)
+		return -ENOMEM;
+
+	*wdata = (struct nfs_write_data) {
 		.flags		= how,
 		.cred		= NULL,
 		.inode		= inode,
@@ -192,8 +198,8 @@ static int nfs_writepage_sync(struct fil
 			.count		= wsize,
 		},
 		.res		= {
-			.fattr		= &wdata.fattr,
-			.verf		= &wdata.verf,
+			.fattr		= &wdata->fattr,
+			.verf		= &wdata->verf,
 		},
 	};
 
@@ -205,22 +211,22 @@ static int nfs_writepage_sync(struct fil
 	nfs_begin_data_update(inode);
 	do {
 		if (count < wsize)
-			wdata.args.count = count;
-		wdata.args.offset = page_offset(page) + wdata.args.pgbase;
+			wdata->args.count = count;
+		wdata->args.offset = page_offset(page) + wdata->args.pgbase;
 
-		result = NFS_PROTO(inode)->write(&wdata, file);
+		result = NFS_PROTO(inode)->write(wdata, file);
 
 		if (result < 0) {
 			/* Must mark the page invalid after I/O error */
 			ClearPageUptodate(page);
 			goto io_error;
 		}
-		if (result < wdata.args.count)
+		if (result < wdata->args.count)
 			printk(KERN_WARNING "NFS: short write, count=%u, result=%d\n",
-					wdata.args.count, result);
+					wdata->args.count, result);
 
-		wdata.args.offset += result;
-	        wdata.args.pgbase += result;
+		wdata->args.offset += result;
+	        wdata->args.pgbase += result;
 		written += result;
 		count -= result;
 	} while (count);
@@ -234,9 +240,10 @@ static int nfs_writepage_sync(struct fil
 
 io_error:
 	nfs_end_data_update_defer(inode);
-	if (wdata.cred)
-		put_rpccred(wdata.cred);
+	if (wdata->cred)
+		put_rpccred(wdata->cred);
 
+	kfree(wdata);
 	return written ? written : result;
 }
 

_

