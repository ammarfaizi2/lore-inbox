Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWJYO3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWJYO3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWJYO3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:29:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60616 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751798AbWJYO3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:29:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <453F6D90.4060106@sw.ru> 
References: <453F6D90.4060106@sw.ru>  <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 25 Oct 2006 15:23:29 +0100
Message-ID: <21393.1161786209@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> >> The patch adds this dentry into tail of the dentry_unused list.
> > 
> > I think that's reasonable.  I wonder if we can avoid removing it from the
> > list in the first place, but I suspect it's less optimal.
> 
> Could you please explain this place in details, I do not understand why tail
> of the list is better than head.  Also I do not understand why we should go
> to out in this case. Why we cannot use next dentry in the list instead?

I meant adding it back into the list is reasonable; I didn't actually consider
where you were adding it back.

However, you've just raised a good point: moving a dentry to the head of the
list is what happens when we see it's been referenced recently.  The most
recently used entry is at the head and the least at the tail.

If you look at the list scan algorithm, you can see it works from the tail
towards the head.

We could re-insert the dentry at the position from which we removed it, but
that would mean retaining a pointer to one of its neighbouring dentries.  We
can do that - it's just stack space after all...

I think the main point though, is generally that the superblock that owns the
dentry is very busy in some critical way; either it's being unmounted (in which
case we may as well put the dentry at the MRU end), or it's being remounted (in
which case, it's probably best putting it back where we found it).

You also have to consider how often superblocks are going to be unmounted or
remounted vs the dcache being pruned...

There is also grab_super(), but that's only used by sget() when a superblock is
being mounted again - also unlikely.

So, given that the three ops that affect this are very unlikely to be happening
at any one time, it's probably worth just slapping it at the head and ignoring
it.  The main thing is that it's reinserted somewhere.

Hope that helps...

David
