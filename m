Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSHEOhc>; Mon, 5 Aug 2002 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318505AbSHEOhb>; Mon, 5 Aug 2002 10:37:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59862 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318503AbSHEOh3>; Mon, 5 Aug 2002 10:37:29 -0400
Date: Mon, 5 Aug 2002 16:41:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: David Woodhouse <dwmw2@infradead.org>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30-dj1 (sort of) 
In-Reply-To: <25466.1028556923@redhat.com>
Message-ID: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, David Woodhouse wrote:

> bunk@fs.tum.de said:
> >  the part of -dj1 below is obviously wrong (and it causes a compile
> > error). After removing it the file compiles.
>
> The -dj tree should have no changes to JFFS2. If there are any, they are
> patches which have passed me by for some reason so please resend them to me.

Below is the output of
  filterdiff -z -i \*jffs2\* patch-2.5.30-dj1.diff.gz

> dwmw2

cu
Adrian



--- linux-2.5.30/fs/jffs2/background.c	2002-08-01 22:16:02.000000000 +0100
+++ linux-2.5/fs/jffs2/background.c	2002-08-02 15:50:33.000000000 +0100
@@ -83,7 +83,6 @@ static int jffs2_garbage_collect_thread(
 	struct jffs2_sb_info *c = _c;

 	daemonize();
-	current->tty = NULL;
 	c->gc_task = current;
 	up(&c->gc_thread_start);

--- linux-2.5.30/fs/jffs2/dir.c	2002-08-01 22:16:15.000000000 +0100
+++ linux-2.5/fs/jffs2/dir.c	2002-08-02 15:50:33.000000000 +0100
@@ -718,6 +718,7 @@ static int jffs2_rename (struct inode *o
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dir_i->i_sb);
 	struct jffs2_inode_info *victim_f = NULL;
 	uint8_t type;
+	struct jffs2_inode_info *victim_f = NULL;

 	/* The VFS will check for us and prevent trying to rename a
 	 * file over a directory and vice versa, but if it's a directory,
@@ -775,6 +776,18 @@ static int jffs2_rename (struct inode *o
 	if (S_ISDIR(old_dentry->d_inode->i_mode) && !victim_f)
 		new_dir_i->i_nlink++;

+	if (victim_f) {
+		/* There was a victim. Kill it off nicely */
+		new_dentry->d_inode->i_nlink--;
+		/* Don't oops if the victim was a dirent pointing to an
+		   inode which didn't exist. */
+		if (victim_f->inocache) {
+			down(&victim_f->sem);
+			victim_f->inocache->nlink--;
+			up(&victim_f->sem);
+		}
+	}
+
 	/* Unlink the original */
 	ret = jffs2_do_unlink(c, JFFS2_INODE_INFO(old_dir_i),
 		      old_dentry->d_name.name, old_dentry->d_name.len, NULL);

