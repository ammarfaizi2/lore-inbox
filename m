Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCFL4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCFL4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCFL4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:56:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:1995 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751144AbWCFL4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:56:04 -0500
Date: Mon, 6 Mar 2006 12:56:02 +0100
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060306115602.GC22832@hasse.suse.de>
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17419.53761.295044.78549@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, Neil Brown wrote:

> On Thursday March 2, neilb@suse.de wrote:
> > 
> > 
> > Hi,
> >  This mail relates to the thread with the same subject which can be
> >  found at
> > 
> >     http://lkml.org/lkml/2006/1/16/279
> > 
> >  I would like to propose an alternate patch for the problem.
> ....
> > 
> > Comments?  Please :-?
> 
> Somewhere in among the comments (thanks), I realised that I was only
> closing half the race.  I had tried to make sure there were no stray
> references to any dentries, but there is still the inode which is
> being iput which can cause problem.
> 
> The following patch takes a totally different approach, is based on an
> idea from Jan Kara, and is much less intrusive.
> 
> We:
>   - keep track of "who" is calling prune_dcache, and when a filesystem
>     is being unmounted (s_root == NULL) we only allow the unmount thread
>     to prune dentries.
>   - keep track of how many dentries are in the process of having
>     dentry_iput called on them for pruning
>   - don't allow umount to proceed until that count hits zero
>   - bias the count this way and that to make sure we get a wake_up at
>     the right time
>   - reuse 's_wait_unfrozen' to wait on the iput to complete.
> 
> Again, I'm very keen on feedback.  This race is very hard to trigger,
> so code review is the only real way to evaluate that patch.
> 

Just ask Olaf. Afaik he was the one who triggered it frequently.

This are two different problems which you adress with this and your first
patch. This one is to prevent busy inodes on umouny, the first one was to get
the reference counting on dentries right.

Neil, did you actually read my patch for this one?!
http://marc.theaimsgroup.com/?l=linux-kernel&m=114123870406751&w=2

> diff ./fs/super.c~current~ ./fs/super.c
> --- ./fs/super.c~current~	2006-03-06 16:54:59.000000000 +1100
> +++ ./fs/super.c	2006-03-06 16:57:19.000000000 +1100
> @@ -230,7 +230,18 @@ void generic_shutdown_super(struct super
>  	struct super_operations *sop = sb->s_op;
>  
>  	if (root) {
> +		spin_lock(&dcache_lock);
> +		/* disable stray dputs */
>  		sb->s_root = NULL;
> +
> +		/* trigger a wake_up */
> +		sb->s_pending_iputs --;
> +		spin_unlock(&dcache_lock);
> +		wait_event(sb->s_wait_unfrozen,
> +			   sb->s_pending_iputs < 0);
> +		/* avoid further wakeups */
> +		sb->s_pending_iputs = 65000;
> +
>  		shrink_dcache_parent(root);
>  		shrink_dcache_anon(&sb->s_anon);
>  		dput(root);
> 

What I don't like, is that you are serializing the work of shrink_dcache_*
although they could work in parallel on different processors.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
