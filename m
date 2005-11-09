Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVKIPXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVKIPXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVKIPXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:23:40 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:58385 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751413AbVKIPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:23:38 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <20051109143107.GV7992@ftp.linux.org.uk> (message from Al Viro on
	Wed, 9 Nov 2005 14:31:07 +0000)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu> <20051109143107.GV7992@ftp.linux.org.uk>
Message-Id: <E1EZrmJ-0001dI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 16:22:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 09, 2005 at 11:54:36AM +0100, Miklos Szeredi wrote:
> > Shouldn't this check go before copy_tree()?  Not much point in copying
> > the tree if we are sure it won't be used.
> 
> Incorrect.  Propagation nodes further down the tree can very well be
> mountable.

Can you please give an example.  I'm feeling thick.

What I see in the code is that the the mount tree is copied, then put
on the tmp_list, and at the end the newly copied tree is freed with
umount_tree().

+		if (!(child = copy_tree(source_mnt, source_mnt->mnt_root,
+						type))) {
+			ret = -ENOMEM;
+			list_splice(tree_list, tmp_list.prev);
+			goto out;
+		}
+
+		if (is_subdir(dest_dentry, m->mnt_root)) {
+			mnt_set_mountpoint(m, dest_dentry, child);
+			list_add_tail(&child->mnt_hash, tree_list);
+		} else {
+			/*
+			 * This can happen if the parent mount was bind mounted
+			 * on some subdirectory of a shared/slave mount.
+			 */
+			list_add_tail(&child->mnt_hash, &tmp_list);
+		}
+		prev_dest_mnt = m;
+		prev_src_mnt  = child;
+	}
+out:
+	spin_lock(&vfsmount_lock);
+	while (!list_empty(&tmp_list)) {
+		child = list_entry(tmp_list.next, struct vfsmount, mnt_hash);
+		list_del_init(&child->mnt_hash);
+		umount_tree(child, &umount_list);
+	}
+	spin_unlock(&vfsmount_lock);
+	release_mounts(&umount_list);
+	return ret;
