Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUB1RKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUB1RKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:10:37 -0500
Received: from smtp06.wxs.nl ([195.121.6.58]:53995 "EHLO smtp06.wxs.nl")
	by vger.kernel.org with ESMTP id S261891AbUB1RKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:10:05 -0500
Date: Sat, 28 Feb 2004 18:12:59 +0100
From: Maurice van der Stee <stee@planet.nl>
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
To: linux-kernel@vger.kernel.org
Message-id: <20040228171259.GA587@maurice.stee.nl>
MIME-version: 1.0
X-Mailer: Balsa 2.0.16
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, looks like it fixes my problem.

>>On Sat, Feb 28, 2004 at 12:04:03PM +0100, Maurice van der Stee wrote:
>> When saving an edited file residing on a HPFS filesystem I get the
>> following
>> oops.
>> Kernel is 2.6.4-rc1, compiled with gcc 3.3.2. After this any access
>> to
>> the
>> filesystem hangs the session. Kernel 2.6.3 has the same behavior.
>> Don't
>> know
>> about earlier ones.

><stares at the code>
><blinks>
><wonders whereTF do we assign hpfs1_i and hpfs2_i if both inodes are
non-NULL>
><finds the patch in question>
><stares at jgarzik>

>Fix follows.  That, BTW, means that *nobody* had ever tried to use  
> hpfs
>r/w since 2.5.3-pre3.

>diff -urN RC4-rc1/fs/hpfs/buffer.c RC4-rc1-current/fs/hpfs/buffer.c
>--- RC4-rc1/fs/hpfs/buffer.c	Mon Oct  7 15:58:24 2002
>+++ RC4-rc1-current/fs/hpfs/buffer.c	Sat Feb 28 06:33:29 2004
>@@ -62,56 +62,28 @@
< 
> void hpfs_lock_2inodes(struct inode *i1, struct inode *i2)
< {
>-	struct hpfs_inode_info *hpfs_i1 = NULL, *hpfs_i2 = NULL;
>-
>-	if (!i1) {
>-		if (i2) {
>-			hpfs_i2 = hpfs_i(i2);
>+	if (!i2 || i1 == i2) {
>+		hpfs_lock_inode(i1);
>+	} else if (!i1) {
>+		hpfs_lock_inode(i2);
>+	} else {
>+		struct hpfs_inode_info *hpfs_i1 = hpfs_i(i1);
>+		struct hpfs_inode_info *hpfs_i2 = hpfs_i(i2);
>+		if (i1->i_ino < i2->i_ino) {
>+			down(&hpfs_i1->i_sem);
>+			down(&hpfs_i2->i_sem);
>+		} else {
> 			down(&hpfs_i2->i_sem);
>-		}
>-		return;
>-	}
>-	if (!i2) {
>-		if (i1) {
>-			hpfs_i1 = hpfs_i(i1);
> 			down(&hpfs_i1->i_sem);
> 		}
>-		return;
> 	}
>-	if (i1->i_ino < i2->i_ino) {
>-		down(&hpfs_i1->i_sem);
>-		down(&hpfs_i2->i_sem);
>-	} else if (i1->i_ino > i2->i_ino) {
>-		down(&hpfs_i2->i_sem);
>-		down(&hpfs_i1->i_sem);
>-	} else down(&hpfs_i1->i_sem);
> }
> 
> void hpfs_unlock_2inodes(struct inode *i1, struct inode *i2)
> {
>-	struct hpfs_inode_info *hpfs_i1 = NULL, *hpfs_i2 = NULL;
>-
>-	if (!i1) {
>-		if (i2) {
>-			hpfs_i2 = hpfs_i(i2);
>-			up(&hpfs_i2->i_sem);
>-		}
>-		return;
>-	}
>-	if (!i2) {
>-		if (i1) {
>-			hpfs_i1 = hpfs_i(i1);
>-			up(&hpfs_i1->i_sem);
>-		}
>-		return;
>-	}
>-	if (i1->i_ino < i2->i_ino) {
>-		up(&hpfs_i2->i_sem);
>-		up(&hpfs_i1->i_sem);
>-	} else if (i1->i_ino > i2->i_ino) {
>-		up(&hpfs_i1->i_sem);
>-		up(&hpfs_i2->i_sem);
>-	} else up(&hpfs_i1->i_sem);
>+	/* order of up() doesn't matter here */
>+	hpfs_unlock_inode(i1);
>+	hpfs_unlock_inode(i2);
> }
 
> void hpfs_lock_3inodes(struct inode *i1, struct inode *i2, struct
>inode *i3)
>-

-- 
Maurice van der Stee
stee@planet.nl
