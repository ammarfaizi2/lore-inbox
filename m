Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVAXUpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVAXUpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVAXUny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:43:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261632AbVAXUmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:42:25 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: fix against journal overflow
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m38y6ieigl.fsf@bzzz.home.net>
References: <m3r7khv3id.fsf@bzzz.home.net>
	 <1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3llaien2g.fsf@bzzz.home.net>
	 <1106590709.2103.132.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m38y6ieigl.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106596141.2103.179.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 20:42:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-01-24 at 19:27, Alex Tomas wrote:

> oops. i overlooked this line. so, the fix becomes minor improvement patch ;)

Agreed, but a worthwhile one anyway.  I'm still worried if you've seen
tests where this patch definitely cured a journal overflow, though ---
if so, it may be masking some other bug somewhere else.

> do you think the following can be improved?
> 
> 	/*
> 	 * @@@ AKPM: This seems rather over-defensive.  We're giving commit
> 	 * a _lot_ of headroom: 1/4 of the journal plus the size of
> 	 * the committing transaction.  
...

Possibly.  But what this bit is doing is effectively chunking the
checkpoint operations --- if we have run out of journal space, we wait
until we've got enough room left for a maximally-sized transaction
before we let the new transaction start.  And by doing that, we make
sure that the new transaction can grow to its full size before a commit
is forced.

The trouble is, it is not possible to wait for more log space during a
transaction's lifetime.  You can't clear old log entries without making
sure that the buffers in them have been written back elsewhere, either
to more recent transactions in the log, or to the final writeback
store.  And if you've got a buffer touched both in the oldest
transaction and the current one, then it's being journaled so you can't
do writeback; so you can't flush the old transaction from the log until
you've finished running and committing the current one.  

So if we want to allow a transaction to grow to its full size, we *must*
wait for the log to have enough space for a maximal transaction before
we let the transaction start in the first place.  And obviously, at that
point we don't know how large the transaction is going to get, so we
can't tell in advance whether we would be able to get away with a
smaller amount of space. :)

We could in theory monitor the usage, and if all the transactions being
committed are much smaller than maximum, we could shrink the space
requirement here.  But I'm not convinced it's really worth it.  (It
might be a small improvement for things like mail servers, though.)

Cheers,
 Stephen

