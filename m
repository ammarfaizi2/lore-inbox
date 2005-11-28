Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVK1Qvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVK1Qvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVK1Qvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:51:51 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:5553 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751303AbVK1Qvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:51:50 -0500
Message-ID: <438B42F3.1040006@austin.rr.com>
Date: Mon, 28 Nov 2005 11:48:35 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: inode_change_ok
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are there no calls to inode_change_ok in nfs (on the client), but 
there are in most other filesytsems?   Seems like there are some cases 
in nfs in which a local permission check is done via  a call to 
nfs_permission which calls generic_permission ... if that is the case 
why not do a call to inode_change_ok in similar cases?

For the case of cifs vfs, which is also missing this call - I was 
thinking of adding something like:
       if (!cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
             inode_change_ok(direntry->d_inode, attrs);
to fs/cifs/inode.c near the beginning of cifs_setattr.   Although the 
permissions (actually ACLs) are checked on the server during setattr 
from cifs to Samba or cifs servers such as Windows, it is common for 
convenience for users to mount with one id, rather than authenticating 
each user (so that there are multiple smb uids) in which case the 
permission check on setattr on the client can be important since 
apparently the ".permission" entry point does not seem to get invoked in 
the chown/chmod path.
