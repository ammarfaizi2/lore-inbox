Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWCIQJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWCIQJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCIQJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:09:24 -0500
Received: from mail.suse.de ([195.135.220.2]:20897 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751010AbWCIQJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:09:23 -0500
Date: Thu, 9 Mar 2006 17:09:22 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@openvz.org>
Cc: akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309160922.GI4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de> <44103EE3.7040303@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44103EE3.7040303@openvz.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, Kirill Korotaev wrote:

> commented your patch a bit.
> and attached a corrected version. please review it.
> 

Thanks! I'll send the corrected patch.

So, everythings fine now?


> > 	d_free(dentry);
> > 	if (parent != dentry)
> > 		dput(parent);
> > 	spin_lock(&dcache_lock);
> >+	sb->s_prunes--;
> >+	if (likely(!sb->s_prunes))
> <<< Is it possibe to do something like:
> if (unlikely(!sb->s_root && !sb->s_prunes))
> ?

Uh, I forgot about that one. You already complained about that before :(

> > void shrink_dcache_parent(struct dentry * parent)
> > {
> > 	int found;
> >+	struct super_block *sb = parent->d_sb;
> > 
> >+ again:
> > 	while ((found = select_parent(parent)) != 0)
> > 		prune_dcache(found);
> >+
> >+	/* If we are called from generic_shutdown_super() during
> >+	 * umount of a filesystem, we want to check for other prunes */
> >+	if (!sb->s_root && wait_on_prunes(sb))
> >+		goto again;
> <<<< I don't like this loop here as it looks like a hack for some 
> special case.
> better to move it to generic_shutdown() and omit sb->s_root check at all.
> 

Yes, looks a little cleaner though.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
