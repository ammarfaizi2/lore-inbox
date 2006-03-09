Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWCIQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCIQju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCIQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:39:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:52139 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750762AbWCIQjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:39:49 -0500
Date: Thu, 9 Mar 2006 17:39:48 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, neilb@suse.de, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309163948.GJ4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de> <44103EE3.7040303@openvz.org> <20060309160922.GI4243@hasse.suse.de> <4410554D.2050806@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4410554D.2050806@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, Kirill Korotaev wrote:

> >Thanks! I'll send the corrected patch.
> >So, everythings fine now?
> looks so! Will be glad to Ack/Sign or whatever needed :)))
> 

Ok.

> >>>	d_free(dentry);
> >>>	if (parent != dentry)
> >>>		dput(parent);
> >>>	spin_lock(&dcache_lock);
> >>>+	sb->s_prunes--;
> >>>+	if (likely(!sb->s_prunes))
> >>
> >><<< Is it possibe to do something like:
> >>if (unlikely(!sb->s_root && !sb->s_prunes))
> >>?
> >
> >
> >Uh, I forgot about that one. You already complained about that before :(
> But I'm not sure it is that simple... s_root is set to NULL w/o locks, 
> so I wonder whether it is safe to check it here or we can miss some 
> wakeups...

No, it's not. We need to down_read(&sb->s_umount) for that which is
deadlocking because we down_write() it before calling ->kill_sb(). So this
isn't safe. For now I'll keep it like before and live with the overhead of
calling wake_up() on an empty wait-queue.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
