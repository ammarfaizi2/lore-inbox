Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUIPPlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUIPPlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIPPlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:41:35 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:11927 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268210AbUIPPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:40:26 -0400
Date: Thu, 16 Sep 2004 17:39:30 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
cc: Simon Derr <Simon.Derr@bull.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
In-Reply-To: <20040916075501.20c3ee45.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
 <Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr> <20040916075501.20c3ee45.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Paul Jackson wrote:

> Color me confused - this cpuset_sem down/up should not be needed,
> and should deadlock.  In the call chain:
>
>    cpuset_mkdir -> cpuset_create -> cpuset_populate_dir -> cpuset_add_file
>
> cpuset_create() already holds the cpuset_sem for the duration, and you're
> adding another cpuset_sem down in cpuset_add_file(), which should deadlock.
>
> If you are seeing the duplicate invalid cpuset entries, then must be
> something else going on, unfortunately.
>
> That, or I'm confused.
Neither.
You've just read the patch too quickly:

+       down(&dir->d_inode->i_sem);

NOT down(&cpuset_sem);

However, your remark is welcome, since there is indeed a slight chance of 
deadlock with my patch, but it needs 2 mkdirs racing.

imagine:

mkdir a/b                               mkdir a/b/c

sys_mkdir():       down(a->i_sem);
cpuset_create():   down(cpuset_sem);
                                         sys_mkdir():     down(b->i_sem);
cpuset_add_file(): down(b->i_sem);
                                         cpuset_create(): down(cpuset_sem);


-> deadlock.


So we should release cpuset_sem a bit earlier in cpuset_create(), before 
calling cpuset_populate_dir().





This updated patch should be better (hopefully).

Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-13 09:43:02.000000000 +0200
+++ mm4/kernel/cpuset.c	2004-09-16 17:23:48.764321923 +0200
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
@@ -1219,9 +1218,16 @@ static long cpuset_create(struct cpuset
  	err = cpuset_create_dir(cs, name, mode);
  	if (err < 0)
  		goto err;
+
+	/* release cpuset_sem before cpuset_populate_dir()
+	 * because it will down() this new directory's i_sem
+	 * and if we race with another mkdir,
+	 * we might deadlock 
+	 */
+	up(&cpuset_sem);
+
  	err = cpuset_populate_dir(cs->dentry);
  	/* If err < 0, we have a half-filled directory - oh well ;) */
-	up(&cpuset_sem);
  	return 0;
  err:
  	list_del(&cs->sibling);
