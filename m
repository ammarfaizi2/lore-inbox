Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVAYUEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVAYUEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVAYUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:03:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20961 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262099AbVAYUBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:01:06 -0500
Date: Tue, 25 Jan 2005 20:01:01 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@novell.com,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
Subject: Re: [ANNOUNCE] inotify 0.18
Message-ID: <20050125200100.GC8859@parcelfarce.linux.theplanet.co.uk>
References: <1106682112.23615.3.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106682112.23615.3.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+static struct inode * find_inode(const char __user *dirname)
+{
+	struct inode *inode;
+	struct nameidata nd;
+	int error;
+
+	error = __user_walk(dirname, LOOKUP_FOLLOW, &nd);
+	if (error)
+		return ERR_PTR(error);
+
+	inode = nd.dentry->d_inode;
+
+	/* you can only watch an inode if you have read permissions on it */
+	error = permission(inode, MAY_READ, NULL);
+	if (error) {
+		inode = ERR_PTR(error);
+		goto release_and_out;
+	}
+
+	spin_lock(&inode_lock);
+	__iget(inode);
+	spin_unlock(&inode_lock);
+release_and_out:
+	path_release(&nd);
+	return inode;
+}

Yawn...  OK, so what happens if we get umount in the middle of your
find_inode(), so that path_release() in there drops the last remaining
reference to vfsmount (and superblock)?
