Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTEOU2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTEOU2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:28:00 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:9405 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264272AbTEOU16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:27:58 -0400
Date: Thu, 15 May 2003 13:40:42 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 2 potential out-of-bound user-pointer errors in fs/readdir.c
In-Reply-To: <Pine.GSO.4.44.0305112337160.3242-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0305151329550.29285-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Enclosed are two warnings found in fs/readdir.c, where user provided
pointers are accessed out of 'verified' bounds.

The warnings are found by: first, whenenver we see calls to verify_area,
access_ok and all the no-underscore versions of *_user functions, we
remember the verified bounds. when a user-pointer is accessed thru
__*_user functions, we check if the verified bound is big enough.

Please confirm or clarify. Thanks!

-Junfeng


---------------------------------------------------------

[BUG] copy_to_user verifies that [0, namelen) of dirent->d_name is okay to
write, but the following __put_user accesses dirent->d_name + namelen

/home/junfeng/linux-2.5.69/fs/readdir.c:239:filldir64:
ERROR:BUFFER:239:239:memory operation error (len < off + n) (__put_user(0,
(void*)(char*)&dirent->d_name + (char*)(long unsigned
int)namlen):(void*)(char*)&dirent->d_name + (char*)(long unsigned
int)namlen, len = sym_8, off = sym_8 + 0, n = 1, min (off + n - len = 1)

		goto efault;
	if (__put_user(d_type, &dirent->d_type))
		goto efault;
	if (copy_to_user(dirent->d_name, name, namlen))
		goto efault;

Error --->
	if (__put_user(0, dirent->d_name + namlen))
		goto efault;
	((char *) dirent) += reclen;
	buf->current_dir = dirent;
---------------------------------------------------------

[BUG] copy_to_user verifies that [0, namelen) of dirent->d_name is okay to
write, but the following __put_user accesses dirent->d_name + namelen

/home/junfeng/linux-2.5.69/fs/readdir.c:154:filldir:
ERROR:BUFFER:154:154:memory operation error (len < off + n) (__put_user(0,
(void*)(char*)&dirent->d_name + (char*)(long unsigned
int)namlen):(void*)(char*)&dirent->d_name + (char*)(long unsigned
int)namlen, len = sym_8, off = sym_8 + 0, n = 1, min (off + n - len = 1)

		goto efault;
	if (__put_user(reclen, &dirent->d_reclen))
		goto efault;
	if (copy_to_user(dirent->d_name, name, namlen))
		goto efault;

Error --->
	if (__put_user(0, dirent->d_name + namlen))
		goto efault;
	((char *) dirent) += reclen;
	buf->current_dir = dirent;


