Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSDFIME>; Sat, 6 Apr 2002 03:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDFILw>; Sat, 6 Apr 2002 03:11:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53778 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314056AbSDFILc>;
	Sat, 6 Apr 2002 03:11:32 -0500
Message-ID: <3CAEAD8F.80E921B3@zip.com.au>
Date: Sat, 06 Apr 2002 00:10:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.GSO.4.21.0204060034240.28391-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3 was missed - the removal of the BKL in notify_change
means that the filesytem fails quite quickly on SMP in -pre2.
Sorry, I should have spotted that when the patch floated past.

Please do it this way:

--- linux-2.5.8-pre2/fs/ext3/inode.c	Fri Apr  5 17:42:19 2002
+++ 25/fs/ext3/inode.c	Fri Apr  5 22:04:47 2002
@@ -2377,6 +2377,8 @@ int ext3_setattr(struct dentry *dentry, 
 			return error;
 	}
 
+	lock_kernel();
+
 	if (attr->ia_valid & ATTR_SIZE && attr->ia_size < inode->i_size) {
 		handle_t *handle;
 
@@ -2404,6 +2406,7 @@ int ext3_setattr(struct dentry *dentry, 
 
 err_out:
 	ext3_std_error(inode->i_sb, error);
+	unlock_kernel();
 	if (!error)
 		error = rc;
 	return error;


-
