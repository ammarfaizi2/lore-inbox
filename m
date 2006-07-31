Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWGaLj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWGaLj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 07:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGaLj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 07:39:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932283AbWGaLj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 07:39:26 -0400
Subject: [PATCH] 2.4 client - update d_cache when server reports ENOENT on
	an NFS remove
From: Jeff Layton <jlayton@poochiereds.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 31 Jul 2006 07:39:25 -0400
Message-Id: <1154345965.6328.4.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuwat Phrukphicharn of HP discovered and patched this problem in
RHEL-3, and asked that I push it upstream.

When the 2.4 NFS client does a REMOVE and gets an ENOENT back from the
server it does not remove the dentry from the d_cache. This can make it
inappropriately keep writing to an inode that has been renamed.

To reproduce, run this on an NFS server with /scratch exported:

#!/bin/sh
dir=/scratch/98201
mkdir -p $dir/recv
cat /dev/null > $dir/recv/x
while true; do
        length=`wc -l $dir/recv/x | cut -d' ' -f1`
        if [ ${length} -gt 1 ]; then
                echo "problem occured!"
                date
                exit 1
        fi
        mv $dir/x $dir/recv/x
        sleep 1
done


...and then do this on the client:

mount server:/scratch /mnt/server
while true; do
        rm -f /mnt/server/98201/x
        date >> /mnt/server/98201/x
        usleep 100
done

The file "x" should never contain more than 1 line, but occasionally,
the server will report an ENOENT back to the client (indicating that the
server script has renamed the file before the rm could occur). After
this, the client will keep appending to the same inode, even though the
file has been renamed.

I've not seen this problem in 2.6 kernels, but I've not done any
extensive testing there as of yet so I can't confirm whether it's still
a problem there or not.

A patch to fix this follows. It just makes ENOENT a special case when
handling errors in the nfs_safe_remove function, and lets the client
update the dcache as if the remove had succeeded. The ENOENT is still
reported back to userspace. This corrected the problem on my test rig
and for the reporter as well:

Signed-off-by: Jeff Layton <jlayton@poochiereds.net>

--- linux-2.4.21/fs/nfs/dir.c.unlink-enoent
+++ linux-2.4.21/fs/nfs/dir.c
@@ -1023,7 +1023,10 @@ static int nfs_safe_remove(struct dentry
 	if (inode)
 		NFS_CACHEINV(inode);
 	error = NFS_PROTO(dir)->remove(dir, &dentry->d_name);
-	if (error < 0)
+
+	/* if server returned ENOENT, assume that the dentry is already gone
+	 * and update the cache accordingly */
+	if (error < 0 && (error != -ENOENT))
 		goto out;
 	if (inode)
 		inode->i_nlink--;


