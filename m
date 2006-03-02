Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCBEwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCBEwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCBEwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:52:22 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:47713 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750777AbWCBEwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:52:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=s1sQoifCs8LLj1GBWU0zBWKaEjkMTcoA6WEwxWPea2Illubi2DSy2mMps6cq19w1r4oqlGYmf+b8hhTxT/70K9lh3p6YE31YbIjfA9qB+D0NJVocG3oj61/O+dOwCzwubYRXfzWX/5WVmP59mDb8dBmY+mblA6C7YQT4QuH0mAI=  ;
Message-ID: <440679FF.80101@yahoo.com.au>
Date: Thu, 02 Mar 2006 15:52:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mike Galbraith <efault@gmx.de>, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, ebiederm@xmission.com,
       Robert Love <rml@tech9.net>, John McCutchan <john@johnmccutchan.com>
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>	<4404CE39.6000109@liberouter.org>	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>	<4404DA29.7070902@free.fr>	<20060228162157.0ed55ce6.akpm@osdl.org>	<4405723E.5060606@free.fr>	<20060301023235.735c8c47.akpm@osdl.org>	<1141221511.7775.10.camel@homer>	<4405B4AA.7090207@free.fr>	<1141227199.10460.2.camel@homer> <20060301121218.68fb3f76.akpm@osdl.org>
In-Reply-To: <20060301121218.68fb3f76.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030809050303030109020108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809050303030109020108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> Maybe you're not running applications which install inotify watches.  This
> is apparently triggerable by doing `touch foo;rm foo;touch foo' in a watched
> directory.
> 
> Nick, isn't it simply a matter of..
> 

Sorry, I forgot about that. With that patch, d_instantiate can still get some
warnings. The following one should fix that and also makes the watch creation
deletion loop-over-all-dentrys ignore negative dentrys too.

I'm not sure what the cleanest way to do this is. I'm fairly sure the vfs
guys do not want a DENTRY_INOTIFY_ flag in fs/dcache.c, so I've added a
comment there.

I also don't know whether or not the inotify guys want parent events on
negative entries. They don't appear to now, so I'll take that as a no.

After the DENTRY_INOTIFY_PARENT_WATCHED debugging stuff is taken out, that
flag will basically be undefined for negative dentrys rather than always
clear (after this patch). I'm not sure whether the vfs people consider that
to be unclean.

-- 
SUSE Labs, Novell Inc.


--------------030809050303030109020108
Content-Type: text/plain;
 name="inotify-dentry-flag-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inotify-dentry-flag-fix.patch"

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -1177,6 +1177,9 @@ void d_delete(struct dentry * dentry)
 	spin_lock(&dentry->d_lock);
 	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) == 1) {
+		/* remove this and other inotify debug checks after 2.6.18 */
+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
+
 		dentry_iput(dentry);
 		fsnotify_nameremove(dentry, isdir);
 		return;
Index: linux-2.6/fs/inotify.c
===================================================================
--- linux-2.6.orig/fs/inotify.c
+++ linux-2.6/fs/inotify.c
@@ -390,6 +390,7 @@ static inline int inotify_inode_watched(
 
 /*
  * Get child dentry flag into synch with parent inode.
+ * Flag should always be clear for negative dentrys.
  */
 static void set_dentry_child_flags(struct inode *inode, int watched)
 {
@@ -400,6 +401,10 @@ static void set_dentry_child_flags(struc
 		struct dentry *child;
 
 		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
+			if (!child->d_inode) {
+				WARN_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+				continue;
+			}
 			spin_lock(&child->d_lock);
 			if (watched) {
 				WARN_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);

--------------030809050303030109020108--
Send instant messages to your online friends http://au.messenger.yahoo.com 
