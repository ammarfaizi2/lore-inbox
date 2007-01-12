Return-Path: <linux-kernel-owner+w=401wt.eu-S1161148AbXALWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbXALWfX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXALWfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:35:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161136AbXALWfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:35:20 -0500
Message-ID: <45A80D1C.40005@redhat.com>
Date: Fri, 12 Jan 2007 16:35:08 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>
CC: Alex Tomas <alex@clusterfs.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
 unlink race
References: <45A7F384.3050303@redhat.com> <m34pqw0xii.fsf@bzzz.home.net>	<45A7FA3C.8030209@redhat.com> <m3lkk8ym2f.fsf@bzzz.home.net> <45A80213.5060401@redhat.com>
In-Reply-To: <45A80213.5060401@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:

> Alex Tomas wrote:
>   
>> yes, but it shouldn't allow to re-link such inode back, IMHO.
>> a filesystem may start some non-revertable activity in its
>> unlink method.
>>
>> thanks, Alex
>>     
>
> I tend to agree, chatting w/ Al I think he does too.  :)  I'll test
> a patch that kicks out ext3_link() with -ENOENT at the top, and resubmit
> that if things go well.
>   
Well this seems to fix things up for ext3 (and ext4 by extension):

---

Return -ENOENT from ext[34]_link if we've raced with unlink and
i_nlink is 0.  Doing otherwise has the potential to corrupt the
orphan inode list, because we'd wind up with an inode with a
non-zero link count on the list, and it will never get properly
cleaned up.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/namei.c
+++ linux-2.6.19/fs/ext3/namei.c
@@ -2191,6 +2191,8 @@ static int ext3_link (struct dentry * ol
 
 	if (inode->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
+	if (inode->i_nlink == 0)
+		return -ENOENT;
 
 retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS(dir->i_sb) +
Index: linux-2.6.19/fs/ext4/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext4/namei.c
+++ linux-2.6.19/fs/ext4/namei.c
@@ -2189,6 +2189,8 @@ static int ext4_link (struct dentry * ol
 
 	if (inode->i_nlink >= EXT4_LINK_MAX)
 		return -EMLINK;
+	if (inode->i_nlink == 0)
+		return -ENOENT;
 
 retry:
 	handle = ext4_journal_start(dir, EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +


