Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUATEW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUATEW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:22:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:44949 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263580AbUATEW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:22:26 -0500
Date: Mon, 19 Jan 2004 20:22:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
Message-Id: <20040119202243.3d0aa60a.akpm@osdl.org>
In-Reply-To: <20040119184435.GT8664@srv-lnx2600.matchmail.com>
References: <20040119184435.GT8664@srv-lnx2600.matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> I've been getting these error messages in my kernel forever, I think even
> with 2.2 kernels, and it's still there in 2.6:
> 
> smb_open: config/SAM open failed, result=-26
> smb_readpage_sync: config/SAM open failed, error=-26
> 
> It does this for several locked system files on the windows machines.
> 
> This happens during a find command run on the mounted share from one of my
> scripts that compares file dates.
> 
> Can these printk calls be removed?

I think so.  We don't want to allow unprivileged users to spam the
logfiles.


 fs/smbfs/file.c |    5 +----
 fs/smbfs/proc.c |    5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff -puN fs/smbfs/proc.c~smbfs-fix-noisiness fs/smbfs/proc.c
--- 25/fs/smbfs/proc.c~smbfs-fix-noisiness	2004-01-19 20:18:16.000000000 -0800
+++ 25-akpm/fs/smbfs/proc.c	2004-01-19 20:18:16.000000000 -0800
@@ -1181,11 +1181,8 @@ smb_open(struct dentry *dentry, int wish
 		result = 0;
 		if (!smb_is_open(inode))
 			result = smb_proc_open(server, dentry, wish);
-		if (result) {
-			PARANOIA("%s/%s open failed, result=%d\n",
-				 DENTRY_PATH(dentry), result);
+		if (result)
 			goto out;
-		}
 		/*
 		 * A successful open means the path is still valid ...
 		 */
diff -puN fs/smbfs/file.c~smbfs-fix-noisiness fs/smbfs/file.c
--- 25/fs/smbfs/file.c~smbfs-fix-noisiness	2004-01-19 20:22:21.000000000 -0800
+++ 25-akpm/fs/smbfs/file.c	2004-01-19 20:22:23.000000000 -0800
@@ -64,11 +64,8 @@ smb_readpage_sync(struct dentry *dentry,
 		DENTRY_PATH(dentry), count, offset, rsize);
 
 	result = smb_open(dentry, SMB_O_RDONLY);
-	if (result < 0) {
-		PARANOIA("%s/%s open failed, error=%d\n",
-			 DENTRY_PATH(dentry), result);
+	if (result < 0)
 		goto io_error;
-	}
 
 	do {
 		if (count < rsize)

_

