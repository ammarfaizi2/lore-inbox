Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbRE0KQS>; Sun, 27 May 2001 06:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRE0KP7>; Sun, 27 May 2001 06:15:59 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:19126 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261434AbRE0KPx>; Sun, 27 May 2001 06:15:53 -0400
From: "Akash Jain" <aki.jain@stanford.edu>
To: <rgooch@atnf.csiro.au>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <su.class.cs99q@nntp.stanford.edu>
Subject: [PATCH] fs/devfs/base.c
Date: Sun, 27 May 2001 03:12:00 -0700
Message-ID: <GLEPIDKFGKPCBDLKDHEAAELGDDAA.aki.jain@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

in fs/devfs/base.c,
the struct devfsd_notify_struct is approx 1056 bytes, allocating it on
a stack of 8k seems unreasonable.  here we simply move it to the heap, i
don't think it is a _must_ be on stack type thing

-aki-


--- fs/devfs/base.c.orig	Tue Apr 17 15:04:10 2001
+++ fs/devfs/base.c	Tue May 22 23:59:54 2001
@@ -3153,7 +3153,7 @@
     int done = FALSE;
     int ival;
     loff_t pos, devname_offset, tlen, rpos;
-    struct devfsd_notify_struct info;
+    struct devfsd_notify_struct* info;
     struct devfsd_buf_entry *entry;
     struct fs_info *fs_info = file->f_dentry->d_inode->i_sb->u.generic_sbp;
     DECLARE_WAITQUEUE (wait, current);
@@ -3162,8 +3162,14 @@
     if (ppos != &file->f_pos) return -ESPIPE;
     /*  Verify the task has grabbed the queue  */
     if (fs_info->devfsd_task != current) return -EPERM;
-    info.major = 0;
-    info.minor = 0;
+
+    /* must alloc the info struct */
+    info = kmalloc(sizeof(struct devfsd_notify_struct), GFP_KERNEL);
+    if(info == NULL)
+        return -ENOMEM;
+
+    info->major = 0;
+    info->minor = 0;
     /*  Block for a new entry  */
     add_wait_queue (&fs_info->devfsd_wait_queue, &wait);
     current->state = TASK_INTERRUPTIBLE;
@@ -3177,6 +3183,7 @@
 	{
 	    remove_wait_queue (&fs_info->devfsd_wait_queue, &wait);
 	    current->state = TASK_RUNNING;
+	    kfree(info);
 	    return -EINTR;
 	}
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -3186,18 +3193,18 @@
     /*  Now play with the data  */
     ival = atomic_read (&fs_info->devfsd_overrun_count);
     if (ival > 0) atomic_sub (ival, &fs_info->devfsd_overrun_count);
-    info.overrun_count = ival;
+    info->overrun_count = ival;
     entry = (struct devfsd_buf_entry *) fs_info->devfsd_buffer +
 	fs_info->devfsd_buf_out;
-    info.type = entry->type;
-    info.mode = entry->mode;
-    info.uid = entry->uid;
-    info.gid = entry->gid;
+    info->type = entry->type;
+    info->mode = entry->mode;
+    info->uid = entry->uid;
+    info->gid = entry->gid;
     if (entry->type == DEVFSD_NOTIFY_LOOKUP)
     {
-	info.namelen = strlen (entry->data);
+	info->namelen = strlen (entry->data);
 	pos = 0;
-	memcpy (info.devname, entry->data, info.namelen + 1);
+	memcpy (info->devname, entry->data, info->namelen + 1);
     }
     else
     {
@@ -3205,23 +3212,27 @@

 	if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
 	{
-	    info.major = de->u.fcb.u.device.major;
-	    info.minor = de->u.fcb.u.device.minor;
+	    info->major = de->u.fcb.u.device.major;
+	    info->minor = de->u.fcb.u.device.minor;
+	}
+	pos = devfs_generate_path (de, info->devname, DEVFS_PATHLEN);
+	if (pos < 0) {
+	  kfree(info);
+	  return pos;
 	}
-	pos = devfs_generate_path (de, info.devname, DEVFS_PATHLEN);
-	if (pos < 0) return pos;
-	info.namelen = DEVFS_PATHLEN - pos - 1;
-	if (info.mode == 0) info.mode = de->mode;
+	info->namelen = DEVFS_PATHLEN - pos - 1;
+	if (info->mode == 0) info->mode = de->mode;
     }
-    devname_offset = info.devname - (char *) &info;
+    devname_offset = info->devname - (char *) info;
     rpos = *ppos;
     if (rpos < devname_offset)
     {
 	/*  Copy parts of the header  */
 	tlen = devname_offset - rpos;
 	if (tlen > len) tlen = len;
-	if ( copy_to_user (buf, (char *) &info + rpos, tlen) )
+	if ( copy_to_user (buf, (char *) info + rpos, tlen) )
 	{
+	    kfree(info);
 	    return -EFAULT;
 	}
 	rpos += tlen;
@@ -3231,12 +3242,13 @@
     if ( (rpos >= devname_offset) && (len > 0) )
     {
 	/*  Copy the name  */
-	tlen = info.namelen + 1;
+	tlen = info->namelen + 1;
 	if (tlen > len) tlen = len;
 	else done = TRUE;
-	if ( copy_to_user (buf, info.devname + pos + rpos - devname_offset,
+	if ( copy_to_user (buf, info->devname + pos + rpos - devname_offset,
 			   tlen) )
 	{
+	    kfree(info);
 	    return -EFAULT;
 	}
 	rpos += tlen;
@@ -3251,6 +3263,7 @@
 	*ppos = 0;
     }
     else *ppos = rpos;
+    kfree(info);
     return tlen;
 }   /*  End Function devfsd_read  */


