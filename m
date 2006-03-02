Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWCBExI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCBExI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWCBExH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:53:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWCBExG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:53:06 -0500
Date: Wed, 1 Mar 2006 20:51:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301205138.12ec91b1.akpm@osdl.org>
In-Reply-To: <20060301152246.77c24ae8@werewolf.auna.net>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<20060301152246.77c24ae8@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Wed, 1 Mar 2006 02:32:35 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
>  > 
>  > Useful, thanks.  So the second batch of /proc patches are indeed the problem.
>  > 
>  > If you have (even more) time you could test
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
>  > That's the latest of everything with the problematic sysfs patches reverted
>  > and Eric's recent /proc fixes.
>  > 
> 
>  I just tried rc5-mm1 and this. With this I can run java apps/applets again
>  without locking my system. 
> 
>  I also applied the patch you posted for inotify, but now I get this new one:
> 
>  Mar  1 15:11:04 werewolf kernel: [ 1424.891482] BUG: warning at fs/inotify.c:410/set_dentry_child_flags()

Which patch was that?  The first one was doubly broken.

This is closer.

diff -puN fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix fs/dcache.c
--- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix	2006-03-01 12:16:22.000000000 -0800
+++ devel-akpm/fs/dcache.c	2006-03-01 12:18:34.000000000 -0800
@@ -100,6 +100,7 @@ static void dentry_iput(struct dentry * 
 	if (inode) {
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
 		if (!inode->i_nlink)
_


