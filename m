Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUHYKw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUHYKw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 06:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUHYKw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 06:52:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:36997 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266366AbUHYKwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 06:52:53 -0400
Date: Wed, 25 Aug 2004 12:52:53 +0200
From: Olaf Kirch <okir@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent memory leak in devpts
Message-ID: <20040825105252.GA24572@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

There is a dentry refcount leak in devpts_get_tty.

struct tty_struct *devpts_get_tty(int number)
{
        struct dentry *dentry = get_node(number);
        struct tty_struct *tty;

        tty = (IS_ERR(dentry) || !dentry->d_inode) ? NULL :
                        dentry->d_inode->u.generic_ip;

        up(&devpts_root->d_inode->i_sem);
        return tty;
}

The get_node function does a lookup on /dev/pts/<number> and returns the
dentry, taking a reference. We should dput the dentry after extracting
the tty pointer.

The attached patch does this.

Olaf
-- 
Olaf Kirch     |  The Hardware Gods hate me.
okir@suse.de   |
---------------+ 

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=devpts-dentry-refcount

Index: v268/fs/devpts/inode.c
===================================================================
--- v268.orig/fs/devpts/inode.c
+++ v268/fs/devpts/inode.c
@@ -183,6 +183,7 @@ struct tty_struct *devpts_get_tty(int nu
 			dentry->d_inode->u.generic_ip;
 
 	up(&devpts_root->d_inode->i_sem);
+	dput(dentry);
 
 	return tty;
 }

--r5Pyd7+fXNt84Ff3--
