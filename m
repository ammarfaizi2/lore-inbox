Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSEPDXK>; Wed, 15 May 2002 23:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316570AbSEPDXJ>; Wed, 15 May 2002 23:23:09 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25428 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316569AbSEPDXI>; Wed, 15 May 2002 23:23:08 -0400
Date: Thu, 16 May 2002 05:23:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516032303.GH1025@dualathlon.random>
In-Reply-To: <20020515212733.GA1025@dualathlon.random> <Pine.LNX.4.44L.0205151929430.32261-100000@imladris.surriel.com> <20020516020134.GC1025@dualathlon.random> <3CE32384.65C70AA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 08:12:04PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > That's all, and that's an autodetection bug because ext3 must be always
> > tried first, there's no point at all to try to mount with ext2 before
> > ext3 (of course unless rootfstype= is specified).
> 
> It is *very* common problem for people to think that their root fs is ext3
> when in fact it is being mounted as ext2.
> 
> It seems that /etc/mtab incorrectly reports ext3, which doesn't help.
> The real truth is revealed in /proc/mounts.  (Which has this irritating
> "/dev/root" thing in it, btw).
> 
> So anything we can do to simplify this problem for people would be
> really good.  (It would be good if kernel.org came back, too, so we
> can see the patch ;))

Here it is, it's short enough that I can post it here too. it falls into
the obviously right category IMHO.

--- 2.4.19pre8aa3/fs/ext3/super.c.~1~	Mon Feb 25 22:05:08 2002
+++ 2.4.19pre8aa3/fs/ext3/super.c	Fri May 10 14:09:28 2002
@@ -1736,7 +1736,7 @@
 
 static int __init init_ext3_fs(void)
 {
-        return register_filesystem(&ext3_fs_type);
+        return register_filesystem_lifo(&ext3_fs_type);
 }
 
 static void __exit exit_ext3_fs(void)
--- 2.4.19pre8aa3/fs/super.c.~1~	Thu May  9 23:30:07 2002
+++ 2.4.19pre8aa3/fs/super.c	Fri May 10 14:08:29 2002
@@ -89,7 +89,7 @@
  *	unregistered.
  */
  
-int register_filesystem(struct file_system_type * fs)
+int __register_filesystem(struct file_system_type * fs, int lifo)
 {
 	int res = 0;
 	struct file_system_type ** p;
@@ -103,8 +103,14 @@
 	p = find_filesystem(fs->name);
 	if (*p)
 		res = -EBUSY;
-	else
-		*p = fs;
+	else {
+		if (!lifo)
+			*p = fs;
+		else {
+			fs->next = file_systems;
+			file_systems = fs;
+		}
+	}
 	write_unlock(&file_systems_lock);
 	return res;
 }
--- 2.4.19pre8aa3/include/linux/fs.h.~1~	Fri May 10 00:46:11 2002
+++ 2.4.19pre8aa3/include/linux/fs.h	Fri May 10 14:16:54 2002
@@ -1077,7 +1077,9 @@
 		__MOD_DEC_USE_COUNT((fops)->owner);	\
 } while(0)
 
-extern int register_filesystem(struct file_system_type *);
+extern int __register_filesystem(struct file_system_type *, int);
+#define register_filesystem(fs) __register_filesystem(fs, 0)
+#define register_filesystem_lifo(fs) __register_filesystem(fs, 1)
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount(struct vfsmount *);
--- 2.4.19pre8aa3/kernel/ksyms.c.~1~	Thu May  9 23:30:06 2002
+++ 2.4.19pre8aa3/kernel/ksyms.c	Fri May 10 14:14:22 2002
@@ -355,7 +355,7 @@
 EXPORT_SYMBOL(do_SAK);
 
 /* filesystem registration */
-EXPORT_SYMBOL(register_filesystem);
+EXPORT_SYMBOL(__register_filesystem);
 EXPORT_SYMBOL(unregister_filesystem);
 EXPORT_SYMBOL(kern_mount);
 EXPORT_SYMBOL(__mntput);

> And Andreas' idea of "Warning: mounting ext3 as as ext2" will help,
> too.
> 
> --- 2.4.19-pre8/fs/ext2/super.c~ext2-ext3-warning	Wed May 15 19:36:12 2002
> +++ 2.4.19-pre8-akpm/fs/ext2/super.c	Wed May 15 20:11:41 2002
> @@ -486,6 +486,9 @@ struct super_block * ext2_read_super (st
>  		       bdevname(dev), i);
>  		goto failed_mount;
>  	}
> +	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL))
> +		ext2_warning(sb, __FUNCTION__,
> +			"mounting ext3 filesystem as ext2\n");
>  	sb->s_blocksize_bits =
>  		le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size) + 10;
>  	sb->s_blocksize = 1 << sb->s_blocksize_bits;

agreed on this patch too.

Andrea
