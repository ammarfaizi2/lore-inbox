Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVFQBU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVFQBU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFQBU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:20:26 -0400
Received: from mail.ccur.com ([208.248.32.212]:62574 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261879AbVFQBTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:19:53 -0400
Subject: NFS: NFS3 - page null fill in a short read situation
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CCUR
Message-Id: <1118971191.2202.14.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 16 Jun 2005 21:19:51 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2005 01:19:52.0054 (UTC) FILETIME=[A9682960:01C572DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

One of our applications running on a Linux client experiences partial
file data corruption (nulls) if the NFS filesystem on a non-Linux server
is mounted as NFS3. It works properly if mounted NFS2. The Linux NFS client
creates a file on the server and issues the following sequence of lseeks,
writes, and read calls:
                                                                                
  init write buffer to non-null values

  lseek: SEEK_SET to 52
  write: 224 bytes

  lseek: SEEK_SET to 4096
  write: 224 bytes
                                                                                 
  lseek: SEEK_SET to 0
  read: 276 bytes

Using ethereal, I found that the data read back over the wire from the
server for bytes 0 to 276 was correct (bytes 52-275 were not null). However,
the data returned to the application for bytes 52 to 275 was null.

We have several non-Linux NFS servers that do not return the EOF status
flag on a read when data is being returned. A second read at the updated
offset returns the EOF flag. This causes the nfs_readpage_result() short
read logic to be used in this case. If some progress is made on the read
(count != 0), nfs_readpage_result() adjusts the starting position in
pgbase and offset, and decrements the count by the amount that was
completed. It then restarts the read call. Once the original count is
satified or an EOF occurs, nfs_readpage_result_full() is called to null
fill the end of any page(s) that were not satisfied by the read(s).

I found nfs_readpage_result_full() is not taking into account a short
read situation may have occurred. In my example, data->res.count was 0
after the second read (for bytes 276 to 4095) due to the EOF. Because
req->wb_pgbase was 0 and req->wb_bytes was 4096, memclear_highpage_flush()
cleared all 4096 bytes of the page even though 276 bytes had been read by
the first short read. This caused bytes 52 to 275 to be clobbered by nulls.

I changed count in nfs_readpage_result_full() to be a total of all the
reads by adding data->args.pgbase to data->res.count (count of the last
read). I found that data->args.pgbase contained the sum of any previous
short reads that may have occurred, and 0 otherwise. In my example, bytes
276 to 4095 are now cleared by memclear_highpage_flush() instead of bytes
0 to 4095 which fixes the problem for this application.

Cheers!
Linda

The following patch is for 2.6.12-rc6:

diff -ura base/fs/nfs/read.c new/fs/nfs/read.c
--- base/fs/nfs/read.c	2005-06-07 16:21:43.000000000 -0400
+++ new/fs/nfs/read.c	2005-06-16 16:59:45.000000000 -0400
@@ -425,7 +425,7 @@
  */
 static void nfs_readpage_result_full(struct nfs_read_data *data, int status)
 {
-	unsigned int count = data->res.count;
+	unsigned int count = data->res.count + data->args.pgbase;
 
 	while (!list_empty(&data->pages)) {
 		struct nfs_page *req = nfs_list_entry(data->pages.next);


