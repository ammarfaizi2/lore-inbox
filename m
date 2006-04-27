Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWD0SqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWD0SqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWD0SqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:46:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964920AbWD0SqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:46:10 -0400
Message-ID: <44511164.4080303@redhat.com>
Date: Thu, 27 Apr 2006 14:45:56 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: NFS@lists.sourceforge.net
Subject: [PATCH] NFS server subtree_check returns dubious value
Content-Type: multipart/mixed;
 boundary="------------070204080600050601050005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070204080600050601050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached is a patch which addresses a problem found when a Linux NFS server
uses the "subtree_check" export option.

The "subtree_check" NFS export option was designed to prohibit a client from
using a file handle for which it should not have permission.  The algorithm
used is to ensure that the entire path to the file being referenced is
accessible to the user attempting to use the file handle.  If some part of
the path is not accessible, then the operation is aborted and the 
appropriate
version of ESTALE is returned to the NFS client.

The error, ESTALE, is unfortunate in that it causes NFS clients to make
certain assumptions about the continued existence of the file.  They assume
that the file no longer exists and refuse to attempt to access it again.
In this case, the file really does exist, but access was denied by the
server for a particular user.

A better error to return would be an EACCES sort of error.  This would
inform the client that the particular operation that it was attempting
was not allowed, without the nasty side effects of the ESTALE error.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------070204080600050601050005
Content-Type: text/plain;
 name="devel.today"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devel.today"

--- linux-2.6.16.x86_64/fs/exportfs/expfs.c.org
+++ linux-2.6.16.x86_64/fs/exportfs/expfs.c
@@ -102,7 +102,7 @@ find_exported_dentry(struct super_block 
 		if (acceptable(context, result))
 			return result;
 		if (S_ISDIR(result->d_inode->i_mode)) {
-			/* there is no other dentry, so fail */
+			err = -EACCES;
 			goto err_result;
 		}
 

--------------070204080600050601050005--
