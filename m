Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUGFWR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUGFWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGFWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:17:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:20101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264637AbUGFWRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:17:41 -0400
Date: Tue, 6 Jul 2004 15:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com, jim.houston@comcast.net
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040706152000.6d83c3a3.akpm@osdl.org>
In-Reply-To: <20040706213552.GA30237@agk.surrey.redhat.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407021233.09610.kevcorry@us.ibm.com>
	<20040702124218.0ad27a85.akpm@osdl.org>
	<200407061323.27066.kevcorry@us.ibm.com>
	<20040706142335.14efcfa4.akpm@osdl.org>
	<20040706213552.GA30237@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> > Confused.  idr_find() returns the thing it found, or NULL.  
> 
> Yes, but the comments imply that the thing it found might in some
> circumstances not be the thing you asked it to look for (if there've 
> been deletions) and it's the caller's responsibility to verify
> what's returned.

ah, OK.  The original idr.c code had a (weird) feature in which each time
you add a new element, idr_add_new() returns a generation counter in the
top bits of the returned index.  So when doing a lookup the idr code would
mask the counter bits off the index before using it.

This was so that if someone did a quick add/remove/add, the second `add'
would return the same index, with a different counter in te top eight bits.

When you do another lookup you can compare the counter which you imbedded
in the object with the counter in the index which you used for the lookup. 
If they're different, you know that someone has deleted the object you were
looking for.

It was, IMO, sorry, a complete crock and was all thrown away a month or so
ago.

> > To which comments do you refer?
> 
> lib/idr.c:30
> 
>  * What you need to do is, since we don't keep the counter as part of
>  * id / ptr pair, to keep a copy of it in the pointed to structure
>  * (or else where) so that when you ask for a ptr you can varify that
>  * the returned ptr is correct by comparing the id it contains with the one
>  * you asked for.  In other words, we only did half the reuse protection.
>  * Since the code depends on your code doing this check, we ignore high
>  * order bits in the id, not just the count, but bits that would, if used,
>  * index outside of the allocated ids.  In other words, if the largest id
>  * currently allocated is 32 a look up will only look at the low 5 bits of
>  * the id.  Since you will want to keep this id in the structure anyway
>  * (if for no other reason than to be able to eliminate the id when the
>  * structure is found in some other way) this seems reasonable.  If you
>  * really think otherwise, the code to check these bits here, it is just
>  * disabled with a #if 0.

The comment is stale - I'll remove it.
