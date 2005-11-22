Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVKVVdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVKVVdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVKVVdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:33:32 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:62670 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965056AbVKVVdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:33:31 -0500
Subject: What protection does sysfs_readdir have with SMP/Preemption?
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 16:33:22 -0500
Message-Id: <1132695202.13395.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm developing a custom kernel on top of Ingo's -rt patch. My kernel
makes race conditions in the vanilla kernel show up very well :-)

I just hit a bug, actually a page fault in fs/sysfs/dir.c in
sysfs_readdir:



			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
				struct sysfs_dirent *next;
				const char * name;
				int len;

				next = list_entry(p, struct sysfs_dirent,
						   s_sibling);
				if (!next->s_element)
					continue;

				name = sysfs_get_name(next);
				len = strlen(name);
				if (next->s_dentry)
					ino = next->s_dentry->d_inode->i_ino;

^^^^
This is where I had a bad pointer reference.

				else
					ino = iunique(sysfs_sb, 2);

				if (filldir(dirent, name, len, filp->f_pos, ino,
						 dt_type(next)) < 0)
					return 0;


Looking at this code, I don't see anything protecting the s_dentry. For
example, couldn't the following happen:

sysfs_create_dir is called, which calls create_dir.  Now we create a
dentry with no d_inode. In sysfs_make_dirent which calls
sysfs_new_dirent which adds to the parents s_children. Then
sysfs_make_dirent sets s_dentry = dentry (the one that was just made
with no d_inode assigned yet).  Then create_dir calls sysfs_create which
finally assigns the d_inode.

So, either there is some hidden protection and my modification to the
kernel has caused this to bug, or we have just been lucky the whole time
in the vanilla kernel.

-- Steve


