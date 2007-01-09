Return-Path: <linux-kernel-owner+w=401wt.eu-S1751169AbXAII6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXAII6u (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAII6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:58:50 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:64683 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbXAII6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:58:49 -0500
Message-ID: <45A3613F.1050604@in.ibm.com>
Date: Tue, 09 Jan 2007 15:02:47 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: Tomasz Kvarsin <kvarsin@gmail.com>
CC: linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
       shaggy@austin.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: JFS: possible recursive locking detected
References: <5157576d0701082333h276b99f3l7a785f6e2f250c27@mail.gmail.com>
In-Reply-To: <5157576d0701082333h276b99f3l7a785f6e2f250c27@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040304050203020302030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040304050203020302030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tomasz Kvarsin wrote:
> This I got during boot with 2.6.20-rc4:
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.20-rc4 #3
> ---------------------------------------------
> mount/5819 is trying to acquire lock:
> (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30
>
> but task is already holding lock:
> (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30
>
> other info that might help us debug this:
> 2 locks held by mount/5819:
> #0:  (&inode->i_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30
> #1:  (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30
>
Problem was in jfs_create(), it was calling 2 mutex_calls.
=============================================
static int jfs_create(struct inode *dip, struct dentry *dentry, int mode,
                struct nameidata *nd)
{
        int rc = 0;
        tid_t tid;              /* transaction id */
        struct inode *ip = NULL;        /* child directory inode */
        ino_t ino;
        struct component_name dname;    /* child directory name */
        struct btstack btstack;
        struct inode *iplist[2];
        struct tblock *tblk;

        jfs_info("jfs_create: dip:0x%p name:%s", dip, dentry->d_name.name);
      .....................................
       tid = txBegin(dip->i_sb, 0);

        mutex_lock(&JFS_IP(dip)->commit_mutex);
        mutex_lock(&JFS_IP(ip)->commit_mutex);

        rc = jfs_init_acl(tid, ip, dip);
        if (rc)
                goto out3;
=======================================

So below patch should fix this problem,please test this. Let me know 
your comments on this.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>



--------------040304050203020302030905
Content-Type: text/plain;
 name="jfs.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jfs.fix"

 namei.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.20-rc4/fs/jfs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jfs/namei.c
+++ linux-2.6.20-rc4/fs/jfs/namei.c
@@ -104,8 +104,8 @@ static int jfs_create(struct inode *dip,
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, I_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, I_MUTEX_CHILD);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)

--------------040304050203020302030905--
