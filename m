Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282757AbRLKTfv>; Tue, 11 Dec 2001 14:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282747AbRLKTfm>; Tue, 11 Dec 2001 14:35:42 -0500
Received: from zok.sgi.com ([204.94.215.101]:58764 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282736AbRLKTfd>;
	Tue, 11 Dec 2001 14:35:33 -0500
Subject: Re: possible bug with RAID
From: Steve Lord <lord@sgi.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112111952430.1232-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0112111952430.1232-100000@mustard.heime.net>
Content-Type: multipart/mixed; boundary="=-iElwcuzEeFbBVF9Hjh1t"
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 11 Dec 2001 13:34:03 -0600
Message-Id: <1008099243.17996.13.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iElwcuzEeFbBVF9Hjh1t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2001-12-11 at 12:54, Roy Sigurd Karlsbakk wrote:
> > it would be interesting to write a simple benchmark
> > that simply reads a file at a fixed rate.  *that* would
> > actually simulate your app.
> 
> sure. I'm using tux+wget for that. I were just playing around with dd
> 
> > sounds like a VM/balance problem.  you didn't mention which kernel
> > you're using.
> 
> 2.4.16 w/tux + xfs. The fs used on the raid vol is xfs

We just got to the bottom of a problem in xfs which was causing memory
not to get cleaned as efficiently as it should be - it lead to dbench
lockups on low memory systems. It is possible you are seeing a similar
effect - we dirty all the memory and then struggle to clean it up.

Try the attached patch.

Steve



--=-iElwcuzEeFbBVF9Hjh1t
Content-Disposition: attachment; filename=xfs.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Index: linux/fs/buffer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- /usr/tmp/TmpDir.12499-0/linux/fs/buffer.c_1.96	Tue Dec 11 13:33:26 2001
+++ linux/fs/buffer.c	Tue Dec 11 13:31:17 2001
@@ -224,6 +224,7 @@
 	unlock_buffer(bh);
 	put_bh(bh);
 }
+EXPORT_SYMBOL(end_buffer_io_sync);
=20
 /*
  * The buffers have been marked clean and locked.  Just submit the dang
@@ -2538,7 +2539,7 @@
 /*
  * Can the buffer be thrown out?
  */
-#define BUFFER_BUSY_BITS	((1<<BH_Dirty) | (1<<BH_Lock))
+#define BUFFER_BUSY_BITS	((1<<BH_Dirty) | (1<<BH_Lock) | (1<<BH_Delay))
 #define buffer_busy(bh)		(atomic_read(&(bh)->b_count) | ((bh)->b_state & B=
UFFER_BUSY_BITS))
=20
 /*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Index: linux/fs/pagebuf/page_buf_io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- /usr/tmp/TmpDir.12499-0/linux/fs/pagebuf/page_buf_io.c_1.102	Tue Dec 11=
 13:33:26 2001
+++ linux/fs/pagebuf/page_buf_io.c	Tue Dec 11 10:22:58 2001
@@ -1337,10 +1337,12 @@
 	head =3D bh;
 	do {
 		lock_buffer(bh);
-		set_buffer_async_io(bh);
-		set_bit(BH_Uptodate, &bh->b_state);
-		clear_bit(BH_Dirty, &bh->b_state);
 		clear_bit(BH_Delay, &bh->b_state);
+		if (atomic_set_buffer_clean(bh)) {
+			get_bh(bh);
+			bh->b_end_io =3D end_buffer_io_sync;
+			refile_buffer(bh);
+		}
 		bh =3D bh->b_this_page;
 	} while (bh !=3D head);
=20
@@ -1350,6 +1352,7 @@
 	} while (bh !=3D head);
=20
 	SetPageUptodate(page);
+	UnlockPage(page);
 	page_cache_release(page);
 }
=20

--=-iElwcuzEeFbBVF9Hjh1t--
