Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTE3NH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTE3NH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:07:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8558 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263638AbTE3NH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:07:57 -0400
Date: Fri, 30 May 2003 14:21:12 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org,
       Stephen Tweedie <sct@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs !
Message-ID: <20030530132112.GA9572@redhat.com>
References: <Pine.LNX.4.53.0305281612160.13968@chaos> <200305282052.h4SKqUBw016537@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <200305282052.h4SKqUBw016537@verdi.et.tudelft.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, May 28, 2003 at 10:52:30PM +0200, Rob van Nieuwkerk wrote:

> I don't have the POSIX spec, but maybe it specifies what "read-only"
> is supposed to mean somewhere too ..

SingleUnix says:

http://www.opengroup.org/onlinepubs/007904975/basedefs/xbd_chap04.html#tag_04_07

"Marks for update, and updates themselves, are not done for files on
read-only file systems"

So we're wrong here.  Patch below fixes it for me for 2.4.

Cheers,
 Stephen

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4202-vfs-mctime-rofs.patch"

--- linux-2.4-odirect/fs/inode.c.=K0004=.orig
+++ linux-2.4-odirect/fs/inode.c
@@ -1194,6 +1194,24 @@ void update_atime (struct inode *inode)
 	mark_inode_dirty_sync (inode);
 }   /*  End Function update_atime  */
 
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
+	if ( IS_RDONLY (inode) ) return;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty (inode);
+}   /*  End Function update_mctime  */
+
 
 /*
  *	Quota functions that want to walk the inode lists..
--- linux-2.4-odirect/fs/pipe.c.=K0004=.orig
+++ linux-2.4-odirect/fs/pipe.c
@@ -230,8 +230,7 @@ pipe_write(struct file *filp, const char
 	/* Signal readers asynchronously that there is more data.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
 
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+	update_mctime(inode);
 
 out:
 	up(PIPE_SEM(*inode));
--- linux-2.4-odirect/include/linux/fs.h.=K0004=.orig
+++ linux-2.4-odirect/include/linux/fs.h
@@ -201,6 +201,7 @@ extern int leases_enable, dir_notify_ena
 #include <asm/byteorder.h>
 
 extern void update_atime (struct inode *);
+extern void update_mctime (struct inode *);
 #define UPDATE_ATIME(inode) update_atime (inode)
 
 extern void buffer_init(unsigned long);

--y0ulUmNC+osPPQO6--
