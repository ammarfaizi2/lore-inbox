Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752231AbWFLTYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbWFLTYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWFLTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:24:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:29356 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1752228AbWFLTYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:24:33 -0400
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="60524940:sNHT30220528"
Date: Mon, 12 Jun 2006 20:24:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Robin H. Johnson" <robbat2@gentoo.org>
cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards.
 Also VFS time granularity bug on creat(). (Repost, more content)
In-Reply-To: <20060612051001.GA18634@curie-int.vc.shawcable.net>
Message-ID: <Pine.LNX.4.64.0606122011020.18760@blonde.wat.veritas.com>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
 <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
 <20060612051001.GA18634@curie-int.vc.shawcable.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jun 2006 19:24:32.0839 (UTC) FILETIME=[D549DD70:01C68E55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Robin H. Johnson wrote:
> On Sun, Jun 11, 2006 at 07:10:31PM +0100, Hugh Dickins wrote:
> 
> > Perhaps we could devise a debug WARN_ON somewhere to check consistent
> > granularity; but I don't have the ingenuity right now, and would need
> > an additional superblock field or flag to not spam the logs horribly.
> > Perhaps it's easier just to delete CURRENT_TIME, converting its users.
> Yes, I'd agree that replacing CURRENT_TIME in filesystems with
> current_fs_time should be worthwhile for all filesystems - That,
> combined with your patch below to ensure they all use s_time_gran,
> should ensure safety.
> 
> A total removal of CURRENT_TIME wouldn't work, there are a few other
> users besides setting [acm]times - however as above, we should be able
> to kill it for all filesystems.

Well, with CURRENT_TIME defined, for some time to come we're likely
to have new filesystems going into the tree, copying old filesystems,
using CURRENT_TIME but not setting s_time_gran.  Undefining CURRENT_TIME
and updating all its users would prevent that; but I don't intend to do
so myself, and it certainly wouldn't be a 2.6.17 thing.

> However CURRENT_TIME_SEC looks safe to convert, all of it's users are
> filesystems.

There should be no need to change that one at all: it was introduced to
match the default s_time_gran of one second, so filesystems using it
are declaring that they understand all this.  Except for that odd
stray usage in JFS.

> > Setting that safety aside, the patch below (against 2.6.17-rc6) looks
> > to me like all that's currently needed in mainline - but ecryptfs and
> > reiser4 in the mm tree will also want fixing, and more discrepancies
> > are sure to trickle in later.
> I checked at well, and this does cover every filesystem I see in the
> mainline.

Oh, thanks a lot for double checking, that's a great help.

> > If anyone thinks tmpfs is the most important to fix (I would think
> > that, wouldn't I?), I can forward your fix to Linus ahead of the rest.
> > Or if people agree the patch below is good, I can sign it off and send;
> > or FS maintainers extract their own little parts.
> I'd appreciate it tmpfs either of the fixes actually making it to
> 2.6.17, there are a reasonable number of Gentoo users that use tmpfs as
> temporary storage to compile stuff, and there's a long-standing argument
> that tmpfs wasn't safe for that, due to this bug ;-).

Right, I don't want Gentoo user impugning the safety of tmpfs:
I'll send just your patch on to Linus; but divide the rest up
to send to maintainers later (some of my choices may be wrong).

Hugh
