Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUFXVYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUFXVYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUFXVYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:24:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265684AbUFXVYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:24:18 -0400
Date: Thu, 24 Jun 2004 22:24:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.6.7-bk
Message-ID: <20040624212417.GG12308@parcelfarce.linux.theplanet.co.uk>
References: <1088111809.4160.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088111809.4160.1.camel@pegasus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 11:16:49PM +0200, Marcel Holtmann wrote:
> I got this oops on boot with the latest Bitkeeper snapshot of 2.6.7

Memory corruption in generic_readlink(), now that we use nd->depth instead
of current->link_count.  Fix follows:

--- fs/namei.c	Thu Jun 24 16:06:45 2004
+++ fs/namei.c-fix	Thu Jun 24 16:07:24 2004
@@ -2197,7 +2197,9 @@
 int generic_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct nameidata nd;
-	int res = dentry->d_inode->i_op->follow_link(dentry, &nd);
+	int res;
+	nd.depth = 0;
+	res = dentry->d_inode->i_op->follow_link(dentry, &nd);
 	if (!res) {
 		res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
 		if (dentry->d_inode->i_op->put_link)
