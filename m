Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWJYNwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWJYNwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWJYNwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:52:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55196 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030373AbWJYNwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:52:40 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <453F58FB.4050407@sw.ru> 
References: <453F58FB.4050407@sw.ru> 
To: Vasily Averin <vvs@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 25 Oct 2006 14:51:04 +0100
Message-ID: <20792.1161784264@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> #   If prune_dcache finds a dentry that it cannot free, it leaves it where it
> #   is (at the tail of the list) and exits, on the assumption that some other
> #   thread will be removing that dentry soon.
> 
> However as far as I see this comment is not correct: when we cannot take
> s_umount rw_semaphore (for example because it was taken in do_remount) this
> dentry is already extracted from dentry_unused list and we do not add it into
> the list again.

You would seem to be correct.

> Therefore dentry will not be found by prune_dcache() and shrink_dcache_sb()
> and will leave in memory very long time until the partition will be
> unmounted.

And here too:-/

> Am I probably err?

Unfortunately not.  I wonder if remount should be getting a writelock on the
s_umount sem, but I don't see why not.  grab_super() also gets a writelock on
it, and so that could cause problems too.

shrink_dcache_for_umount_subtree() doesn't care because it doesn't scan the
dcache_unused list, but as you say, other things are affected.

> The patch adds this dentry into tail of the dentry_unused list.

I think that's reasonable.  I wonder if we can avoid removing it from the list
in the first place, but I suspect it's less optimal.

Acked-By: David Howells <dhowells@redhat.com>
