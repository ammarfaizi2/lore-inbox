Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269273AbUIHSGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbUIHSGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUIHSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:05:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269267AbUIHSFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:05:35 -0400
Subject: Re: [Patch 4/6]: ext3 reservations: Turn ext3 per-sb reservations
	list into an rbtree.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Mingming Cao <cmm@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040907154833.4cc8d7a3.akpm@osdl.org>
References: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
	 <20040907154833.4cc8d7a3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1094666713.1985.181.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Sep 2004 19:05:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-09-07 at 23:48, Andrew Morton wrote:

> Takes this structure up to 32 bytes on x86.  That's a moderate amount of
> inode bloat for something which is only used when an application currently
> has the inode open for writing.
> 
> Have you given any thought to dynamic allocation of the above?

No, none at all.  <thinks>

We already have an ext3 function that's called on all opens ---
currently it checks nothing except O_LARGEFILE, but it's an easy and
obvious place where we could set up the may-write bits.

We'd have to take special care with directories, and potentially with
xattrs, but I don't see any great problems with doing it.

> And if we were to do that, there are a few things which we could move out
> of the ext3 in-core inode and into the above structure, such as
> i_next_alloc_block and i_next_alloc_goal.

Yep.

> Does the reservation code work for directory growth, btw?

Yes, it should be hidden inside the allocation code, and should work
straight out of the box for directories.  But thinking about that,
there's at least one obvious difference that we need to worry about:
there's no "close" on directories to indicate when we've stopped
extending the dir, and can discard the reservation.

That shouldn't lead to spurious ENOSPC, but might lead to suboptimal
layout on full filesystems if we have reserved all the free space and
have to fall back to the old allocation mechanism.

--Stephen

