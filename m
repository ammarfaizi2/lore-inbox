Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266490AbRGLSLA>; Thu, 12 Jul 2001 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266493AbRGLSKv>; Thu, 12 Jul 2001 14:10:51 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:18130 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266490AbRGLSKi>; Thu, 12 Jul 2001 14:10:38 -0400
Date: Thu, 12 Jul 2001 19:11:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: proc_scsi_gen_write PAGE_SIZE
Message-ID: <Pine.LNX.4.21.0107121844150.2192-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

Forgive me if I guess wrongly, but patch-2.4.5.log says of -pre3:
 - Al Viro: sanity-check user arguments, zero-terminated strings etc.
from which I assume you made the proc_scsi_gen_write() mod below.

I'm not sure what it ought to say instead, but I believe the "else"
case is wrong: buffer[length] is in that case buffer[PAGE_SIZE],
just beyond the end of the page we have allocated.

Hugh

--- v2.4.4/linux/drivers/scsi/scsi.c	Wed Apr 25 16:18:54 2001
+++ linux/drivers/scsi/scsi.c	Tue May 15 01:29:34 2001
@@ -1572,6 +1572,11 @@
 	copy_from_user(buffer, buf, length);
 
 	err = -EINVAL;
+	if (length < PAGE_SIZE)
+		buffer[length] ='\0';
+	else if (buffer[length])
+		goto out;
+
 	if (length < 11 || strncmp("scsi", buffer, 4))
 		goto out;
 

