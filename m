Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbREVM5q>; Tue, 22 May 2001 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbREVM5h>; Tue, 22 May 2001 08:57:37 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:42473 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261511AbREVM5X>; Tue, 22 May 2001 08:57:23 -0400
Message-ID: <3B0A6124.E90717E7@uow.edu.au>
Date: Tue, 22 May 2001 22:52:52 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] s_maxbytes handling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ->f_pos is positioned exactly at sb->s_maxbytes, a non-zero-length
write to the file doesn't write anything, and write() returns zero.

Consequently applications which try to append to a file which
is s_maxbytes in length hang up, because write() just keeps
on returning zero.

We need to return -EFBIG if ->f_pos is at s_maxbytes and
the length is non-zero.

--- linux-2.4.5-pre4/mm/filemap.c	Mon May 21 20:03:03 2001
+++ linux-akpm/mm/filemap.c	Tue May 22 22:34:41 2001
@@ -2571,11 +2571,13 @@
 	 *	Linus frestrict idea will clean these up nicely..
 	 */
 	 
-	if (pos > inode->i_sb->s_maxbytes)
-	{
-		send_sig(SIGXFSZ, current, 0);
-		err = -EFBIG;
-		goto out;	
+	if (pos >= inode->i_sb->s_maxbytes) {
+		if (count || pos > inode->i_sb->s_maxbytes) {
+			send_sig(SIGXFSZ, current, 0);
+			err = -EFBIG;
+			goto out;
+		}
+		/* zero-length writes at ->s_maxbytes are OK */
 	}
 
 	if (pos + count > inode->i_sb->s_maxbytes)
