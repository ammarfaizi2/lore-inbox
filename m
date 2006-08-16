Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWHPDH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWHPDH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWHPDHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:07:55 -0400
Received: from mx1.budgetdialup.com ([129.41.7.40]:29448 "EHLO
	anywhere.irove.net") by vger.kernel.org with ESMTP id S1750864AbWHPDHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:07:55 -0400
From: Joel & Rebecca VanderZee <joel_vanderzee@yahoo.com>
Reply-To: joel_vanderzee@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: suggested patch for PROBLEM:  I/O Error attempting to read last partial block of a file in an ISO9660 file system
Date: Tue, 15 Aug 2006 22:06:37 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+uo4EVX6HHItWhT"
Message-Id: <200608152206.38153.joel_vanderzee@yahoo.com>
X-Spam-Report: *  3.4 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
	*  0.9 FORGED_YAHOO_RCVD 'From' yahoo.com does not match 'Received'
	*      headers
X-Spam-Processed: anywhere.irove.net, Tue, 15 Aug 2006 20:07:52 -0700
	(processed during SMTP session)
X-Return-Path: joel_vanderzee@yahoo.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+uo4EVX6HHItWhT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


[1.] One line summary of the problem:
I/O Error attempting to read last partial block of a file in ISO9660 file 
system.

[2.] Full description of the problem/report:
In an ISO9660 filesystem that I have, the kernel fails to read several of the 
larger files. Now that I solved the problem, I will spare you the many more 
details that I discovered as I went along.

[3.] Keywords (i.e., modules, networking, kernel):
ISO9660, isofs, filesystems

[4.] Kernel version (from /proc/version):
The patch is based on 2.6.17.8, but it was tested on 2.6.11.4-20a-default 
(SuSE 9.3). (The code in the patch area had not changed.)

[5.] No Oops.. message.

[6.] A small shell script or example program which triggers the
     problem (if possible)
The ISO9660 filesystem that I have is around 500 MB, and I do not have any 
small way to reproduce the problem, but I think someone could make a small 
image to trigger the problem and/or verify that it does not exist in the 
future. See the comments in the attached patch. My image was produced by 
DirectCD, and it probably will not put a file in more than one section unless 
the file is over around 15 MB.

[7.] Environment
Nothing special. I worked from both CD-ROM and a file image of it. I used 
various programs, but mostly dd and isodump for investigating the problem. I 
used several kernel versions (even a 2.4, which has worse problems with files 
comprising multiple sections), and various hardware.

[X.] Other notes, patches, fixes, workarounds:
I assume that the mailing list prefers a small patch inline, but I will attach 
this one as well so that if I failed to properly disable line breaking in my 
mailer, there will be a copy with lines intact.

I apologize for any lapse in protocol. I am not subscribed to the list and am 
trying to be helpful.

Joel VanderZee
--------

Patch for linux-2.6.17.8 (tested on 2.6.11.4-20a-default)

There was an I/O error that prevented reading the last partial block
of large files in an ISO9660 filesystem.  The error was generated
when a file comprised more than one section and had a size that was
not an exact multiple of the filesystem block size.  This patch removes
the check (and failure) for reading into the last partial block (and
possibly beyond) for multiple-section files.

It worked in my testing to prevent reading beyond the end of the
section; my first patch just incremented the sect_size block count
for a partial block and continued doing the check.  But there is a
commment in the source code about reading beyond the end of the file
to fill a page cache.  Failing to access beyond the section would
prevent reading beyond the end of the file.

Suggested patch by Joel VanderZee.  Version 3.


--- fs/isofs/inode_orig.c	2006-08-06 23:18:54.000000000 -0500
+++ fs/isofs/inode.c	2006-08-15 09:47:24.831460300 -0500
@@ -961,31 +961,31 @@
 			       iblock, (unsigned long) inode->i_size);
 			goto abort;
 		}
-		
-		if (nextblk) {
-			while (b_off >= (offset + sect_size)) {
-				struct inode *ninode;
-				
-				offset += sect_size;
-				if (nextblk == 0)
-					goto abort;
-				ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
-				if (!ninode)
-					goto abort;
-				firstext  = ISOFS_I(ninode)->i_first_extent;
-				sect_size = ISOFS_I(ninode)->i_section_size >> ISOFS_BUFFER_BITS(ninode);
-				nextblk   = ISOFS_I(ninode)->i_next_section_block;
-				nextoff   = ISOFS_I(ninode)->i_next_section_offset;
-				iput(ninode);
-				
-				if (++section > 100) {
-					printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
-					printk("isofs_get_blocks: block=%ld firstext=%u sect_size=%u "
-					       "nextblk=%lu nextoff=%lu\n",
-					       iblock, firstext, (unsigned) sect_size,
-					       nextblk, nextoff);
-					goto abort;
-				}
+		
+		/* On the last section, nextblk == 0, section size is likely to
+		 * exceed sect_size by a partial block, and access beyond the
+		 * end of the file will reach beyond the section size, too.
+		 */
+		while (nextblk && (b_off >= (offset + sect_size))) {
+			struct inode *ninode;
+
+			offset += sect_size;
+			ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
+			if (!ninode)
+				goto abort;
+			firstext  = ISOFS_I(ninode)->i_first_extent;
+			sect_size = ISOFS_I(ninode)->i_section_size >> ISOFS_BUFFER_BITS(ninode);
+			nextblk   = ISOFS_I(ninode)->i_next_section_block;
+			nextoff   = ISOFS_I(ninode)->i_next_section_offset;
+			iput(ninode);
+
+			if (++section > 100) {
+				printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
+				printk("isofs_get_blocks: block=%ld firstext=%u sect_size=%u "
+				       "nextblk=%lu nextoff=%lu\n",
+				       iblock, firstext, (unsigned) sect_size,
+				       nextblk, nextoff);
+				goto abort;
 			}
 		}
 		

--Boundary-00=_+uo4EVX6HHItWhT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux_isofs_largefile_v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux_isofs_largefile_v3.patch"

Patch for linux-2.6.17.8 (tested on 2.6.11.4-20a-default)

There was an I/O error that prevented reading the last partial block
of large files in an ISO-9660 filesystem.  The error was generated
when a file comprised more than one section and had a size that was
not an exact multiple of the filesystem block size.  This patch removes
the check (and failure) for reading into the last partial block (and
possibly beyond) for multiple-section files.

It worked in my testing to prevent reading beyond the end of the
section; my first patch just incremented the sect_size block count
for a partial block and continued doing the check.  But there is a
commment in the source code about reading beyond the end of the file
to fill a page cache.  Failing to access beyond the section would
prevent reading beyond the end of the file.

Suggested patch by Joel VanderZee.  Version 3.


--- fs/isofs/inode_orig.c	2006-08-06 23:18:54.000000000 -0500
+++ fs/isofs/inode.c	2006-08-15 09:47:24.831460300 -0500
@@ -961,31 +961,31 @@
 			       iblock, (unsigned long) inode->i_size);
 			goto abort;
 		}
-		
-		if (nextblk) {
-			while (b_off >= (offset + sect_size)) {
-				struct inode *ninode;
-				
-				offset += sect_size;
-				if (nextblk == 0)
-					goto abort;
-				ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
-				if (!ninode)
-					goto abort;
-				firstext  = ISOFS_I(ninode)->i_first_extent;
-				sect_size = ISOFS_I(ninode)->i_section_size >> ISOFS_BUFFER_BITS(ninode);
-				nextblk   = ISOFS_I(ninode)->i_next_section_block;
-				nextoff   = ISOFS_I(ninode)->i_next_section_offset;
-				iput(ninode);
-				
-				if (++section > 100) {
-					printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
-					printk("isofs_get_blocks: block=%ld firstext=%u sect_size=%u "
-					       "nextblk=%lu nextoff=%lu\n",
-					       iblock, firstext, (unsigned) sect_size,
-					       nextblk, nextoff);
-					goto abort;
-				}
+		
+		/* On the last section, nextblk == 0, section size is likely to
+		 * exceed sect_size by a partial block, and access beyond the
+		 * end of the file will reach beyond the section size, too.
+		 */
+		while (nextblk && (b_off >= (offset + sect_size))) {
+			struct inode *ninode;
+
+			offset += sect_size;
+			ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
+			if (!ninode)
+				goto abort;
+			firstext  = ISOFS_I(ninode)->i_first_extent;
+			sect_size = ISOFS_I(ninode)->i_section_size >> ISOFS_BUFFER_BITS(ninode);
+			nextblk   = ISOFS_I(ninode)->i_next_section_block;
+			nextoff   = ISOFS_I(ninode)->i_next_section_offset;
+			iput(ninode);
+
+			if (++section > 100) {
+				printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
+				printk("isofs_get_blocks: block=%ld firstext=%u sect_size=%u "
+				       "nextblk=%lu nextoff=%lu\n",
+				       iblock, firstext, (unsigned) sect_size,
+				       nextblk, nextoff);
+				goto abort;
 			}
 		}
 		

--Boundary-00=_+uo4EVX6HHItWhT--

