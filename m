Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274985AbTHQAQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 20:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274986AbTHQAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 20:16:18 -0400
Received: from dsl-bow-205-233-15-i232-cgy.nucleus.com ([205.233.15.232]:23045
	"HELO thepurplebuffalo.net") by vger.kernel.org with SMTP
	id S274985AbTHQAQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 20:16:15 -0400
Date: Sat, 16 Aug 2003 18:16:14 -0600 (MDT)
From: lkml@superfrink.net
X-X-Sender: frink@thepurplebuffalo.net
To: linux-kernel@vger.kernel.org
Subject: vfat dentry cache issues on 2.4.20
Message-ID: <Pine.LNX.4.44.0308161803150.305-100000@thepurplebuffalo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still running 2.4.20 (for an nForce chipset) so changes between then
and the current kernel may have fixed this.

I was getting errors from ls sometimes.  strace shows open() is failing
with "-1 ESTALE (Stale NFS file handle)" on the file ".".  After adding
some printk()s to fs/namei.c and fs/vfat/namei.c I think the ESTALE is
coming from the return_err: in fs/namei.c .

In particular dentry->d_op->d_revalidate(dentry,0) is returning 1 causing
d_invalidate(dentry) to be called but this may not clear the cache because
the only way I've found to get rid of the error message is to unmount and
re-mount the partition again.

Here is how I reproduce the error message:
( /dev/hdc2 on /data type vfat (rw,gid=102,umask=002) )

[frink@truth /data/foo]$\rm -rf *
[frink@truth /data/foo]$touch file    <--\__ this order is important
[frink@truth /data/foo]$mkdir dir     <--/
[frink@truth /data/foo]$cd dir
[frink@truth /data/foo/dir]$ls
[frink@truth /data/foo/dir]$mv ../file .
[frink@truth /data/foo/dir]$ls
/bin/ls: .: Stale NFS file handle
[frink@truth /data/foo/dir]$

A thread found on google seems to indicate that this problem has been seen
before (January 1999).  Has this been discussed recently?  Was it fixed and
is appearing again after some other change?  For that mater is it present in
the current development kernel?

http://groups.google.com/groups?hl=en&lr=lang_en&ie=UTF-8&oe=utf-8&safe=off&frame=right&th=3aea305227e98f93&seekm=fa.ivvetlv.4iinqo%40ifi.uio.no#link1

Thanks,
Chad


Patches used:

[frink@truth /usr/src/linux/fs]$diff -u namei.c.orig namei.c
--- namei.c.orig        2002-11-28 16:53:15.000000000 -0700
+++ namei.c     2003-08-16 17:58:01.000000000 -0600
@@ -634,8 +634,17 @@
                 */
                dentry = nd->dentry;
                if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+
+                       printk(KERN_DEBUG "vfat_NFS_error: (link_path_walk): ");
+
+                       if(name)
+                               printk("name: '%x' '%s'\n", name, name);
+                       else
+                               printk("name: NULL\n");
+
                        err = -ESTALE;
                        if (!dentry->d_op->d_revalidate(dentry, 0)) {
+                               printk(KERN_DEBUG "vfat_NFS_error: calling d_invalidate()\n");
                                d_invalidate(dentry);
                                break;
                        }
@@ -648,6 +657,10 @@
        }
        path_release(nd);
 return_err:
+       if(err == -ESTALE) {
+
+               printk(KERN_DEBUG "vfat_NFS_error: link_path_walk() returning ESTALE\n");
+       }
        return err;
 }


[frink@truth /usr/src/linux/fs]$diff -u vfat/namei.c.orig vfat/namei.c
--- vfat/namei.c.orig   2002-08-02 18:39:45.000000000 -0600
+++ vfat/namei.c        2003-08-12 20:27:55.000000000 -0600
@@ -75,12 +75,15 @@
 static int vfat_revalidate(struct dentry *dentry, int flags)
 {
        PRINTK1(("vfat_revalidate: %s\n", dentry->d_name.name));
+       printk(KERN_DEBUG "vfat_revalidate: %s\n", dentry->d_name.name);
        spin_lock(&dcache_lock);
        if (dentry->d_time == dentry->d_parent->d_inode->i_version) {
                spin_unlock(&dcache_lock);
+               printk(KERN_DEBUG "vfat_revalidate: return 1\n");
                return 1;
        }
        spin_unlock(&dcache_lock);
+       printk(KERN_DEBUG "vfat_revalidate: return ZERO!\n");
        return 0;
 }


