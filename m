Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbUKQXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbUKQXFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKQXDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:03:44 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:17820
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262578AbUKQXD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:03:28 -0500
Date: Wed, 17 Nov 2004 18:14:38 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: ISO9660 file size limitation
Message-ID: <20041117231437.GA21986@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just came across this today after burning backups to dvd-r.  The file that
caused the problem is 2,471,265,365 bytes.  After searching a little bit
I found that the kernel doesn't like the size even though it's valid (That
is from what I read).  So I did this:

--- inode.c-old	2004-11-17 17:50:51.000000000 -0500
+++ inode.c	2004-11-17 17:57:44.000000000 -0500
@@ -1218,12 +1218,16 @@
 	 * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
 	 *	    legal. Do not prevent to use DVD's schilling@fokus.gmd.de
 	 */
+#if 0
 	if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
 	    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
 		printk(KERN_WARNING "Warning: defective CD-ROM.  "
 		       "Enabling \"cruft\" mount option.\n");
 		inode->i_sb->u.isofs_sb.s_cruft = 'y';
 	}
+#else
+	inode->i_size &= 0xFFFFFFFF;
+#endif
 
 	/*
 	 * Some dipshit decided to store some other bit of information


It seems to work for me, but I would like to know if doing this might cause
problems.  The large file is a tar.gz.  After doing the above modification
and loading the module, I ran gzip -t on the file.  gzip reported the file
was ok.  With out doing "inode->i_size &= 0xFFFFFFFF", I noticed that the
file size was 18446744071885849685 (0xFFFFFFFF934C8455)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
