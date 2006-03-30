Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWC3CrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWC3CrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWC3CrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:47:24 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:1374 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751457AbWC3CrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:47:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kcepTumJpaCEvptLtu6XXkVbOBloYg9oZWX3l0TKgcM6qbbnBfflzHCe1SDIybZJO1hk7dmJApqo7IzkCaVioui0NufcKV63L/naZUTMgnBWitelkUuoKbgvfRjWiihiwyH6PZ1WufKQWH+AeH/oN6AGa/hbPduP+Ti6UbWBE0I=  ;
Message-ID: <442B3997.7020900@yahoo.com.au>
Date: Thu, 30 Mar 2006 12:51:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Amy Griffis <amy.griffis@hp.com>
CC: linux-kernel@vger.kernel.org, John McCutchan <ttb@tentacle.dhs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] inotify: IN_DELETE events missing in -mm
References: <20060329155719.GA22092@zk3.dec.com>
In-Reply-To: <20060329155719.GA22092@zk3.dec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amy Griffis wrote:

>In recent -mm kernels (e.g. 2.6.16-mm1), IN_DELETE events are no longer 
>generated for the removal of a file from a watched directory.
>
>This seems to be a result of clearing DCACHE_INOTIFY_PARENT_WATCHED in
>d_delete() directly before calling fsnotify_nameremove().
>
>Assuming the flag doesn't need to be cleared before dentry_iput(), this should
>do the trick.
>
>

Thanks Amy. This should go to the next -stable kernel too.

>Signed-off-by: Amy Griffis <amy.griffis@hp.com>
>
>diff --git a/fs/dcache.c b/fs/dcache.c
>index 363cd4b..344ce91 100644
>--- a/fs/dcache.c
>+++ b/fs/dcache.c
>@@ -1198,11 +1198,11 @@ void d_delete(struct dentry * dentry)
> 	spin_lock(&dentry->d_lock);
> 	isdir = S_ISDIR(dentry->d_inode->i_mode);
> 	if (atomic_read(&dentry->d_count) == 1) {
>-		/* remove this and other inotify debug checks after 2.6.18 */
>-		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
>-
> 		dentry_iput(dentry);
> 		fsnotify_nameremove(dentry, isdir);
>+
>+		/* remove this and other inotify debug checks after 2.6.18 */
>+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
> 		return;
> 	}
>

Send instant messages to your online friends http://au.messenger.yahoo.com 
