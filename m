Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265068AbUEYTfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265068AbUEYTfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUEYTfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:35:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46511 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265068AbUEYTfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:35:24 -0400
Subject: how to safely not grab a semaphore when you already have it
	(rename sem)
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1085513665.11307.56.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 May 2004 14:34:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you safely test and not grab a semaphore (ie if the kernel above
you already has it ...) - without deadlock?

Al Viro correctly noted that walking a tree to build a full path can not
be safely done due to races with rename.   Unfortunately for some
filesystems (including cifs), the only obvious way to protect against
this would be to grab the rename sem for the superblock everywhere a
full path is built e.g.

	down(&i_sb->s_vfs_rename_sem);

but of course this would deadlock (vfs_rename calls at least 3 path
based operations in a filesystem, all while holding the rename sem - in
particular rename can make two lookup calls and a rename call into a vfs
while holding the sem).   At least the lookup/revalidate path in the
filesystem would require a check such as: 

if(!we_are_called_from_sys_rename)
	down(&i_sb->s_vfs_rename_sem);

build_fullpath_from_dentry(dentry);

if(!we_are_called_from_sys_rename)
	up(&_sb->s_vfs_rename_sem);

and there is no need to grab the semaphore in cifs_rename at all (it is
already held by the caller).  Unfortuantely I don't know of any way to
tell that we are in lookup/revalidate called from sys_rename other than
trying to grab the rename sem and deadlocking.

Alternatively, is there were a way to do something like:

if(our task is not owner of rename sem) {
	down(&i_sb->s_vfs_rename_sem);
	build_fullpath_from_dentry(dentry);
	up(&_sb->s_vfs_rename_sem); 
} else /* our caller had already gotten rename sem */
	build_fullpath_from_dentry(dentry);
	


