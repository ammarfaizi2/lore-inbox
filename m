Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVAXWMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVAXWMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVAXWHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:07:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261693AbVAXWFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:05:51 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3wtu9v3il.fsf@bzzz.home.net>
References: <m3wtu9v3il.fsf@bzzz.home.net>
Content-Type: text/plain
Message-Id: <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 22:05:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-01-19 at 15:32, Alex Tomas wrote:

> @@ -1178,8 +1199,40 @@
>  void
>  journal_release_buffer(handle_t *handle, struct buffer_head *bh, int credits)
>  {
> +	/* return credit back to the handle if it was really spent */
> +	if (credits)
> +		handle->h_buffer_credits++; 

> +	jh->b_tcount--;
> +	if (jh->b_tcount == 0) {
> +		/* 
> +		 * this was last reference to the block from the current
> +		 * transaction and we'd like to return credit to the
> +		 * whole transaction -bzzz
> +		 */
> +		if (!credits)
> +			handle->h_buffer_credits++; 

I think there's a problem here.

What if:
  Process A gets write access, and is the first to do so (*credits=1)
  Processes B gets write access (*credits=0)
  B modifies the buffer and finishes
  A looks again, sees B's modifications, and releases the buffer because
it's no use any more.

Now, B's release didn't return credits.  The bh is part of the
transaction and was not released.

What does A do on journal_release_buffer()?  It can either:

1) return its credit.  Not legal: the bh is part of the transaction, A
had the only credit for it, it cannot be returned or else we risk
overflowing the journal.

2) Keep its credit.  Legal from jbd's perspective, but breaks ext3
callers: the whole point of journal_release_buffer() is to try to get a
credit back.  The caller has only a finite number of credits, and must
complete the handle within that limit.  If we don't return the credit,
then we've just lost a credit to the handle, and risk the handle running
out of credit before completing the operation (allocation or xattr
update.)

I looked into this in some depth the first time it came up in the
context of AG's xattr fixes.  The only solution I could see required us
to take a buffer credit during get_write_access in *ALL* cases where the
buffer is not already dirtied against the current transaction (ie. has
undergone journal_dirty_metadata() in addition to get_write_access()). 
(If it's dirty, then we don't have a problem, as the bh is guaranteed to
be used anyway.)  Only then can we safely do a release.

I coded up a patch for that, but came up against another difficulty. 
Trouble is, we don't always know if a bh is dirty against the
transaction.  If a bh is committing against one transaction, then a
get_write_access from a second transaction just sets b_next_transaction;
but the logic doesn't distinguish between that and a
journal_dirty_metadata() as far as the list operations are concerned, so
if we release the buffer in this state, we can't tell if it's dirty or
not.  

Your patch helps there: by checking b_tcount we will be able to tell
whether a buffer with b_next_transaction == j_running_transaction really
needs the credit or not.

Cheers,
 Stephen


