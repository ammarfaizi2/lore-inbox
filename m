Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTE3PFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTE3PFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:05:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4393 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263737AbTE3PFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:05:36 -0400
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs !
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, root@chaos.analogic.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030530155820.A11144@infradead.org>
References: <Pine.LNX.4.53.0305281612160.13968@chaos>
	 <200305282052.h4SKqUBw016537@verdi.et.tudelft.nl>
	 <20030530132112.GA9572@redhat.com>  <20030530155820.A11144@infradead.org>
Content-Type: multipart/mixed; boundary="=-Yk21PKFgcJ0pO2kPtxik"
Organization: 
Message-Id: <1054307933.3749.313.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 16:18:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yk21PKFgcJ0pO2kPtxik
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 2003-05-30 at 15:58, Christoph Hellwig wrote:

> Yikes, this looks like devfs code!  Please try to use proper kernel style..

It's pure cut-and-paste from the update_atime immediately above it.  But
sure, we can clean them both up while we're at it if you want.

--Stephen


--=-Yk21PKFgcJ0pO2kPtxik
Content-Disposition: inline; filename=4202-vfs-mctime-rofs.patch
Content-Type: text/plain; name=4202-vfs-mctime-rofs.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.4-odirect/fs/inode.c.=3DK0001=3D.orig
+++ linux-2.4-odirect/fs/inode.c
@@ -1187,12 +1187,34 @@ void update_atime (struct inode *inode)
 {
 	if (inode->i_atime =3D=3D CURRENT_TIME)
 		return;
-	if ( IS_NOATIME (inode) ) return;
-	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
-	if ( IS_RDONLY (inode) ) return;
+	if (IS_NOATIME(inode))
+		return;
+	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))=20
+		return;
+	if (IS_RDONLY(inode))=20
+		return;
 	inode->i_atime =3D CURRENT_TIME;
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
+=20
+void update_mctime (struct inode *inode)
+{
+	if (inode->i_mtime =3D=3D CURRENT_TIME && inode->i_ctime =3D=3D CURRENT_T=
IME)
+		return;
+	if (IS_RDONLY(inode))
+		return;
+	inode->i_ctime =3D inode->i_mtime =3D CURRENT_TIME;
+	mark_inode_dirty (inode);
+}
=20
=20
 /*
--- linux-2.4-odirect/fs/pipe.c.=3DK0001=3D.orig
+++ linux-2.4-odirect/fs/pipe.c
@@ -230,8 +230,7 @@ pipe_write(struct file *filp, const char
 	/* Signal readers asynchronously that there is more data.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
=20
-	inode->i_ctime =3D inode->i_mtime =3D CURRENT_TIME;
-	mark_inode_dirty(inode);
+	update_mctime(inode);
=20
 out:
 	up(PIPE_SEM(*inode));
--- linux-2.4-odirect/include/linux/fs.h.=3DK0001=3D.orig
+++ linux-2.4-odirect/include/linux/fs.h
@@ -201,6 +201,7 @@ extern int leases_enable, dir_notify_ena
 #include <asm/byteorder.h>
=20
 extern void update_atime (struct inode *);
+extern void update_mctime (struct inode *);
 #define UPDATE_ATIME(inode) update_atime (inode)
=20
 extern void buffer_init(unsigned long);

--=-Yk21PKFgcJ0pO2kPtxik--
