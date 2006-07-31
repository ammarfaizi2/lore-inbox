Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWGaTeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWGaTeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGaTeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:34:15 -0400
Received: from relay1.beelinegprs.ru ([217.118.71.5]:20622 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S932146AbWGaTeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:34:14 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: akpm@osdl.org
Subject: Re: possible recursive locking detected - while running fs operations in loops - 2.6.18-rc2-git5
Date: Mon, 31 Jul 2006 23:34:55 +0400
User-Agent: KMail/1.8.2
Cc: reiserfs-list@namesys.com, "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Hans Reiser" <reiser@namesys.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com> <44CBEA7A.4010308@namesys.com> <9a8748490607292317t405c906ek8b1577920eeace65@mail.gmail.com>
In-Reply-To: <9a8748490607292317t405c906ek8b1577920eeace65@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312334.56203.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (476/060731)
X-SpamTest-Info: Profile: Detect Standard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sunday 30 July 2006 10:17, Jesper Juhl wrote:
> On 30/07/06, Hans Reiser <reiser@namesys.com> wrote:
> > Jesper Juhl wrote:
> > > Thanks. That's a nice little test suite.
> >
> > Yes, it is quite useful, our developers have added it to the
> > regression suite....
>
> That's nice.
>
> Now how about that lock validator message I managed to tease out?
>
> Akpm said "... the reiserfs locking appears to be unneeded - this
> inode is going down and nobody else can look it up, so what is to be
> locked against?" - can you comment on that?

Thanks. it is correct.
Andrew, please apply the following patch: 

i_mutex does not need to be locked in reiserfs_delete_inode.

Signed-off-by: Alexander Zarochentsev <zam@namesys.com>

fs/reiserfs/inode.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

Index: linux-2.6-git/fs/reiserfs/inode.c
===================================================================
--- linux-2.6-git.orig/fs/reiserfs/inode.c
+++ linux-2.6-git/fs/reiserfs/inode.c
@@ -37,14 +37,10 @@ void reiserfs_delete_inode(struct inode 
 
 	/* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
 	if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) {	/* also handles bad_inode case */
-		mutex_lock(&inode->i_mutex);
-
 		reiserfs_delete_xattrs(inode);
 
-		if (journal_begin(&th, inode->i_sb, jbegin_count)) {
-			mutex_unlock(&inode->i_mutex);
+		if (journal_begin(&th, inode->i_sb, jbegin_count))
 			goto out;
-		}
 		reiserfs_update_inode_transaction(inode);
 
 		err = reiserfs_delete_object(&th, inode);
@@ -55,12 +51,8 @@ void reiserfs_delete_inode(struct inode 
 		if (!err) 
 			DQUOT_FREE_INODE(inode);
 
-		if (journal_end(&th, inode->i_sb, jbegin_count)) {
-			mutex_unlock(&inode->i_mutex);
+		if (journal_end(&th, inode->i_sb, jbegin_count))
 			goto out;
-		}
-
-		mutex_unlock(&inode->i_mutex);
 
 		/* check return value from reiserfs_delete_object after
 		 * ending the transaction


