Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbRFSUcG>; Tue, 19 Jun 2001 16:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbRFSUbq>; Tue, 19 Jun 2001 16:31:46 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:59405 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S264769AbRFSUbk>; Tue, 19 Jun 2001 16:31:40 -0400
Reply-To: <martin.frey@compaq.com>
From: "Martin Frey" <frey@scs.ch>
To: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Cc: <baettig@scs.ch>
Subject: large offset llseek breaks for device special files on ac series
Date: Tue, 19 Jun 2001 16:31:31 -0400
Message-ID: <014b01c0f8fe$d457a830$0100007f@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the ac series include a check in default_llseek() to not set the
file position beyond the file systems maximum file size.

This check should be done only for regular files, e.g. for
a device special file the test does not make sense.
Either we change the check or we have to write a llseek
method for each device driver.

The patch below by-passes the check for non-file inodes.
The patch is against 2.4.5.ac16. The problem was introduced
earlier (at least on 2.4.3.ac14 the same check is there).

--- linux-2.4.5.ac16/fs/read_write.c    Tue Jun 19 15:11:58 2001
+++ linux-2.4.5.ac16.patched/fs/read_write.c    Tue Jun 19 15:28:37 2001
@@ -36,7 +36,7 @@
                        offset += file->f_pos;
        }
        retval = -EINVAL;
-       if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
+       if (offset>=0 && (!S_ISREG(file->f_dentry->d_inode->i_mode) || offset<=file->f_dentry->d_inode->i_sb->s_maxbytes)) {
                if (offset != file->f_pos) {
                        file->f_pos = offset;
                        file->f_reada = 0;


Regards, Martin

