Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVHTW2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVHTW2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVHTW2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 18:28:12 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:53930 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbVHTW2L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 18:28:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NbK7RTCSsG+vCrgqicpuReJqrzTDQrhPYRylbWf3UVnaSX/uQiBM0zfxlbBSY/MsCywhzX4xKMGSESYlTK1reRD/zV2R9MhP6I351CYW8cGLQeWCi7hZ5Fw4lYNhUje1pZgEvGfZcVqChyLkHcgV5od+ME0ZjcomstuY88e8wow=
Message-ID: <9a87484905082015284c1686ec@mail.gmail.com>
Date: Sun, 21 Aug 2005 00:28:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: use of uninitialized pointer in jffs_create()
Cc: jffs-dev@axis.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc kindly pointed me at jffs_create() with this warning : 

fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
in this function

And looking at the function :

static int
jffs_create(struct inode *dir, struct dentry *dentry, int mode,
                struct nameidata *nd)
{
        struct jffs_raw_inode raw_inode;
        struct jffs_control *c;
        struct jffs_node *node;
        struct jffs_file *dir_f; /* JFFS representation of the directory.  */
        struct inode *inode;
        int err;

        truncate_inode_pages(&inode->i_data, 0);
...

I think it is correct. How on earth is that call to
truncate_inode_pages() going to avoid blowing up? inode has not yet
been initialized... Looks like a bug to me.
Unfortunately I don't know anything about this code, so I haven't
attempted to fix it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
