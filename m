Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUDBNZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDBNZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:25:39 -0500
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:39081 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264039AbUDBNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:25:37 -0500
Message-ID: <406D69D2.10306@informatik.hu-berlin.de>
Date: Fri, 02 Apr 2004 15:25:38 +0200
From: Stefan Nordhausen <deletethis.nordhaus@informatik.hu-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, de-at, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: chown() not POSIX compliant in 2.2.* and 2.4.*
Content-Type: multipart/mixed;
 boundary="------------020805050902070502030200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805050902070502030200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I noted that chown will not always take away the SGID bit from 
nondirectories. Posix says the following about it (taken from [1]):

"If the path argument refers to a regular file, the set-user-ID 
(S_ISUID) and set-group-ID (S_ISGID) bits of the file mode shall be 
cleared upon successful return from chown(), unless the call is made by 
process with appropriate privileges [=root], in which case it is 
implementation defined whether those bits are altered."

As far as I can tell the 2.6.* kernel is Posix compliant as it will 
always remove both SUID and SGID. 2.2.* and 2.4.* will _only_ remove the 
SGID bit if the file is group executable. This is not Posix compliant 
and it is also a potential security whole (as in my case). So I suggest 
the attached patch against 2.4.26rc1. It will make chown always clear 
the SGID bit, just like 2.6 does.

MfG
Stefan Nordhausen


[1] http://mail-index.netbsd.org/netbsd-bugs/1997/12/10/0003.html
--
Not only does god play dice. The dice are loaded.

--------------020805050902070502030200
Content-Type: text/plain;
 name="chown.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chown.diff"

diff -Naur linux-2.4.26rc1/fs/open.c linux-2.4.26rc1_/fs/open.c
--- linux-2.4.26rc1/fs/open.c	2004-04-02 14:46:26.000000000 +0200
+++ linux-2.4.26rc1_/fs/open.c	2004-04-02 15:01:21.000000000 +0200
@@ -587,8 +587,10 @@
 	 * 19981026	David C Niemi <niemi@tux.org>
 	 *
 	 * Removed the fsuid check (see the comment above) -- 19990830 SD.
+	 *
+	 * Always remove SGID bit to comply with POSIX.
 	 */
-	if (((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) 
+	if (((inode->i_mode & S_ISGID) == S_ISGID) 
 		&& !S_ISDIR(inode->i_mode))
 	{
 		newattrs.ia_mode &= ~S_ISGID;

--------------020805050902070502030200--
