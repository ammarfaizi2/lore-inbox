Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270851AbTHFR0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270854AbTHFRZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:25:28 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:1926 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S270851AbTHFRXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:23:39 -0400
Date: Wed, 6 Aug 2003 19:23:06 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: 2.4.22-rc1 FIFO bug still present
Message-Id: <20030806192306.6085b3e0.robn@verdi.et.tudelft.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI:
I see that the "FIFO inode time-stamps are updated on a *readonly* fs"
bug is still not fixed in 2.4.22-rc1.

(this bug is a efficient way to destroy your CompactFlash devices in
certain applications ..)

Stephen C. Tweedie made a fix (see below) for it in May.
It has been in the Alan's -ac series since then and it works fine.

for more info see:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1132.html
	http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1604.html

	greetings,
	Rob van Nieuwkerk

The patch:
(http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/att-1604/01-4202-vfs-mctime-rofs.patch):
###################################################################

--- linux-2.4-odirect/fs/inode.c.=K0001=.orig
+++ linux-2.4-odirect/fs/inode.c
@@ -1187,12 +1187,34 @@ void update_atime (struct inode *inode)
 {
 	if (inode->i_atime == CURRENT_TIME)
 		return;
-	if ( IS_NOATIME (inode) ) return;
-	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
-	if ( IS_RDONLY (inode) ) return;
+	if (IS_NOATIME(inode))
+		return;
+	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode)) 
+		return;
+	if (IS_RDONLY(inode)) 
+		return;
 	inode->i_atime = CURRENT_TIME;
 	mark_inode_dirty_sync (inode);
-}   /*  End Function update_atime  */
+}
+
+/**
+ *	update_mctime	-	update the mtime and ctime
+ *	@inode: inode accessed
+ *
+ *	Update the modified and changed times on an inode for writes to special
+ *	files such as fifos.  No change is forced if the timestamps are already
+ *	up-to-date or if the filesystem is readonly.
+ */
+ 
+void update_mctime (struct inode *inode)
+{
+	if (inode->i_mtime == CURRENT_TIME && inode->i_ctime == CURRENT_TIME)
+		return;
+	if (IS_RDONLY(inode))
+		return;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty (inode);
+}
 
 
 /*
--- linux-2.4-odirect/fs/pipe.c.=K0001=.orig
+++ linux-2.4-odirect/fs/pipe.c
@@ -230,8 +230,7 @@ pipe_write(struct file *filp, const char
 	/* Signal readers asynchronously that there is more data.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
 
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+	update_mctime(inode);
 
 out:
 	up(PIPE_SEM(*inode));
--- linux-2.4-odirect/include/linux/fs.h.=K0001=.orig
+++ linux-2.4-odirect/include/linux/fs.h
@@ -201,6 +201,7 @@ extern int leases_enable, dir_notify_ena
 #include <asm/byteorder.h>
 
 extern void update_atime (struct inode *);
+extern void update_mctime (struct inode *);
 #define UPDATE_ATIME(inode) update_atime (inode)
 
 extern void buffer_init(unsigned long);

