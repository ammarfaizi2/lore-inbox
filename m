Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUIPOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUIPOCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUIPOCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:02:12 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:17811 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268079AbUIPOBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:01:45 -0400
Date: Thu, 16 Sep 2004 16:01:02 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: [Patch] cpusets: fix race in cpuset_add_file()
In-Reply-To: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

This patch fixes a missing down()/up() pair in cpuset_add_file().

Without this patch, sometimes it is possible to have two duplicate 
dentries for a single file of a cpuset, with one of them being invalid, 
and thus the file is present but cannot be opened...

Something like:

# cd /dev/cpuset/foo
# ls
ls: cpus: No such file or directory



The patch also removes comments that
1/are now bogus with this fix applied
2/were not respected anyway



Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-13 09:43:02.000000000 +0200
+++ mm4/kernel/cpuset.c	2004-09-16 15:46:21.847401360 +0200
@@ -956,13 +956,12 @@ static int cpuset_create_dir(struct cpus
  	return error;
  }

-/* MUST be called with dir->d_inode->i_sem held */
-
  static int cpuset_add_file(struct dentry *dir, const struct cftype *cft)
  {
  	struct dentry *dentry;
  	int error;

+	down(&dir->d_inode->i_sem);
  	dentry = cpuset_get_dentry(dir, cft->name);
  	if (!IS_ERR(dentry)) {
  		error = cpuset_create_file(dentry, 0644 | S_IFREG);
@@ -971,6 +970,7 @@ static int cpuset_add_file(struct dentry
  		dput(dentry);
  	} else
  		error = PTR_ERR(dentry);
+	up(&dir->d_inode->i_sem);
  	return error;
  }

@@ -1162,7 +1162,6 @@ static struct cftype cft_notify_on_relea
  	.private = FILE_NOTIFY_ON_RELEASE,
  };

-/* MUST be called with ->d_inode->i_sem held */
  static int cpuset_populate_dir(struct dentry *cs_dentry)
  {
  	int err;
