Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVHTAtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVHTAtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVHTAtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:49:49 -0400
Received: from smtp.istop.com ([66.11.167.126]:58258 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932595AbVHTAtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:49:49 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: [PATCH] Permissions don't stick on ConfigFS attributes
Date: Sat, 20 Aug 2005 10:50:51 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200508201050.51982.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Permissions set on ConfigFS attributes (aka files) do not stick.  The reason 
is that configfs attribute inodes are not pinned and simply disappear after
each file operation.  This is good because it saves memory, but it is not
good to throw the permissions away - you then don't have any way to expose 
configuration tweaks to normal users.  The patch below fixes this by copying 
each file's mode back into the non-transient backing structure on dentry 
delete.

Some general comments on this work, if I may.  First, this is really an 
inspired hack, it gives the user an intuitive way to instance kernel
subsystems.  It turned out to be just the thing for one of my own projects. 
_However_ while it may make sense to you as a programmer that configfs is
separate from sysfs, it certainly will not make sense to users.  Users will
just wonder why they can't create directories in sysfs.  This work needs to
end up as part of sysfs.  It should simply be a new way for a subsystem to
instance a sysfs directory.  (Note!  I haven't actually looked at sysfs yet,
my impression of how it must work is in fact based on reading ConfigFS.)

So: Integrate with sysfs.  To prove itself, it is perfectly fine for configfs
to own a separate namespace, but in my opinion you need to get together with
the sysfs crew and make it one thing, in the fullness of time (i.e., before
hitting mainline).

Terminology skew.  It is a very bad idea to call your configfs files 
"attributes".  Filesystems already have attributes, there is an api for them, 
and they are not the things you call attributes.  You need to put on your 
thinking cap and come up with a new term.  They are really files, but that 
somehow just doesn't sound sufficiently high-tech, does it.  OK, I see you 
inherited this bogosity from sysfs, it is not your fault.  But it is still 
way wrong.

Memory requirements.  ConfigFS pins way too much kernel memory for inodes
and dentries.  You can extend the concept of what happens at the leaf nodes 
(files aka attributes) and copy the useful data back into compact in-memory 
backing store, then just let the vfs objects vanish as each operation 
completes.  Nobody will notice the extra cpu work, but they will certainly 
notice dozens or hundreds of pinned inodes.  Getting rid of the pinned inodes 
is not that hard.

Note that getting rid of the pinned memory will make it an even worse idea to 
use this interface in the block IO path of a cluster, as was proposed at 
Walldorf.   As you noted, Netlink et al are still there and in many cases 
remain the right tools for the job.  ConfigFS is also not a replacement for 
config files.  For one thing, it is volatile and ultimately needs a separate 
persistent store anyway.  Ahem, a config file.  What ConfigFS does better 
than any other interface is allow the user to instance a kernel subsystem.  
There is code out there that tries to do this with insmod, a horribly bad 
idea.  Any such code needs to get the ConfigFS religion right now.

Verbose kernel side interfaces.  My kernel-side implementation of a very 
simple group with single-attribute children is about 150 lines.  If this 
interface takes off and there are, say, 100 kernel classes exposed via 
configfs, is 15,000 lines of kernel source an acceptable overhead?  Not in my 
book.  You need a libconfigfs to encapsulate some of the more common 
situations so that a kernel-side interface can be just half a dozen lines or 
so in those cases.  Of course, it would help to use this a while and find out 
what those common situations really are.

Lindenting.  You have lots of spaces in the wrong places.  It is pervasive 
enough that you might consider just running the whole thing through lindent.

Permissions.  There are still some loose ends, I will play with it some more.

Error reporting.  If a ConfigFS instance doesn't like something the user
throws at it, it just rejects it with EINVAL (your examples silently treat
alpha strings not as EINVAL, but as zero).  Kprinting a detailed error would
help, but you ought to have a ponder about how to make errors more
user-visible and more directly coupled to the culprit.  Error attributes?

Anyway, great stuff!  You have managed to see the forest in spite of all the 
trees in the way.

Regards,

Daniel

diff -up --recursive 2.6.12-mm2.clean/fs/configfs/dir.c 2.6.12-mm2/fs/configfs/dir.c
--- 2.6.12-mm2.clean/fs/configfs/dir.c	2005-08-12 00:53:06.000000000 -0400
+++ 2.6.12-mm2/fs/configfs/dir.c	2005-08-19 18:35:28.000000000 -0400
@@ -64,6 +64,17 @@ static struct dentry_operations configfs
 	.d_delete	= configfs_d_delete,
 };
 
+static int configfs_d_delete_attr(struct dentry *dentry)
+{
+	to_attr(dentry)->ca_mode = dentry->d_inode->i_mode;
+	return 1;
+}
+
+static struct dentry_operations configfs_attr_dentry_ops = {
+	.d_delete = configfs_d_delete_attr,
+	.d_iput = configfs_d_iput,
+};
+
 /*
  * Allocates a new configfs_dirent and links it to the parent configfs_dirent
  */
@@ -245,7 +256,7 @@ static int configfs_attach_attr(struct c
 	if (error)
 		return error;
 
-	dentry->d_op = &configfs_dentry_ops;
+	dentry->d_op = &configfs_attr_dentry_ops;
 	dentry->d_fsdata = configfs_get(sd);
 	sd->s_dentry = dentry;
 	d_rehash(dentry);
