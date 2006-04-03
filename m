Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWDCSMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWDCSMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWDCSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:12:06 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:65391 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbWDCSME convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:12:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RMIEVS1k1J9vUxtIMCOj1Zer4O/f/53tH0eSe3FOv9X98aXoyPwQdZsvq9l50jRPF77k6m0hxzmM4d4Msi+t0r7jDzpyhZqqXh9VJNT8BZfyGzG7nKuONTH7cB4xg5emeAWEsLVxB7shd279dpTgZDQt69D6jN8yMeI5qBIAbB0=
Message-ID: <661de9470604031112j3bf81a21r7066c67f62f1de63@mail.gmail.com>
Date: Mon, 3 Apr 2006 23:42:03 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] Fix dcache race during umount
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jan Blunck" <jblunck@suse.de>, "Kirill Korotaev" <dev@openvz.org>,
       olh@suse.de, balbir@in.ibm.com
In-Reply-To: <1060403034001.28030@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060403133804.27986.patches@notabene>
	 <1060403034001.28030@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil,

>
> Cc: Jan Blunck <jblunck@suse.de>
> Cc: Kirill Korotaev <dev@openvz.org>
> Cc: olh@suse.de
> Cc: bsingharora@gmail.com

Could you please make this balbir@in.ibm.com

>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
<snip>
-               /* If the dentry was recently referenced, don't free it. */
-               if (dentry->d_flags & DCACHE_REFERENCED) {
-                       dentry->d_flags &= ~DCACHE_REFERENCED;
-                       list_add(&dentry->d_lru, &dentry_unused);
-                       dentry_stat.nr_unused++;
-                       spin_unlock(&dentry->d_lock);
-                       continue;
+               if (!(dentry->d_flags & DCACHE_REFERENCED) &&
+                   (!sb || dentry->d_sb == sb)) {

Comments for the condition please. Something like

/*
 * If the dentry is not DCACHED_REFERENCED, it is time to move it to LRU list,
 * provided the super block is NULL (which means we are trying to reclaim memory
 * or this dentry belongs to the same super block that we want to shrink.
 */

One side-effect of this check I see is

Earlier, all prune_dcache() calls would prune the dentry cache. This
condition will cause dentries belonging only those super blocks being
shrink'ed to be freed up. shrink_dcache_memory() will have to do the
additional work of freeing dentries (especially for file systems like
sysfs, procfs, etc). But the good thing is it should make the per
super block operations faster (like unmount). IMO, this is the correct
behaviour, but I am not sure of the side-effects.

+                       if (sb) {
+                               prune_one_dentry(dentry);
+                               continue;
+                       }
> +                       /* Need to avoid race with generic_shutdown_super */
> +                       if (down_read_trylock(&dentry->d_sb->s_umount) &&
> +                           dentry->d_sb->s_root != NULL) {

There is a probable bug here. What if down_read_trylock() succeeds and
dentry->d_sb->s_root == NULL? We still need to do an up_read before we
move on.
The comment would be better put as

/*
 * If we are able to acquire the umount semaphore, then the super
block cannot be unmounted
 * while we are pruning this dentry. This helps avoid a race condition
that is caused due to
 * intermediate reference counts held by the children of the dentry in
prune_one_dentry().
 * This leads to select_dcache_parent() ignoring those dentries,
leaving behind non-dput
 * dentries. The unmount happens before prune_one_dentry() can dput
the dentries.
 */

> +                               prune_one_dentry(dentry);
> +                               up_read(&dentry->d_sb->s_umount);
> +                               continue;
> +                       }
>                 }
<snip>

Looks good to go, except for the comments (especially the up_read() bug)

Balbir
