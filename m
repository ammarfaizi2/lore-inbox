Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUD0P73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUD0P73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUD0P73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:59:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57287 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262356AbUD0P70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:59:26 -0400
Subject: Re: [PATCH COW] sys_copyfile
From: Steve French <smfltc@us.ibm.com>
To: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Cc: linux-cifs-client@lists.samba.org, jra@samba.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1083081505.12804.65.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Apr 2004 10:58:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With warm cache, copyfile() is about 10% faster

Over the network it would be a lot more than that.

With cifs vfs, I would expect that copyfile of files located on the same
server share would be much faster than that perhaps 5 to 10 times faster
due to the huge reduction in network bandwidth usage and latency - since
for the case of cifs the protocol already defines a single network
operation for copy file that could be then used (although it would be
preceeded by a couple of cheap cifs calls for the directory name lookup,
although the target mode complicates things for cifs - there would be a
minor change needed at the end to set the mode if the copy succeeds
which makes the copy error paths over the ).  For the CIFS Unix
Extensions version 2 would could add a trivial change to Samba to take
the mode as part of copy network parms.

in do_copyfile all I would need would be an op that looks a bit like 
rename (the cifs vfs part of the changes, to fs/cifs/cifssmb.c mostly,
would be trivial) e.g.:

 int do_copyfile(struct nameidata *old_nd, struct nameidata *new_nd,
                 struct dentry *new_dentry, umode_t mode)
{
-	int ret;
+       int ret = 0;

        if (!old_nd->dentry->d_inode)
                return -ENOENT;
        if (!S_ISREG(old_nd->dentry->d_inode->i_mode))
                return -EINVAL;
        /* FIXME: replace with proper permission check */
        if (new_dentry->d_inode)
                return -EEXIST;

+	if(old_nd->dentry->d_inode->i_op->copy) {
+		ret = old_dir->i_op->copy(old_nd->dentry, 
+			mode, new_dentry);
+	}

	if(!ret)
		return ret;
	else
		ret = vfs_create(new_nd->dentry->d_inode,
			 new_dentry, mode, new_nd);
	if (ret)
                return ret;

	ret = copy_data(old_nd->dentry, old_nd->mnt, new_dentry,
		new_nd->mnt);

        if (ret) {
                int error = vfs_unlink(new_nd->dentry->d_inode,
			new_dentry);
                BUG_ON(error);
               /* FIXME: not sure if there are return value we 
			should not BUG()
	               * on */
        }
        return ret;
}
	

