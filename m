Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVAXRnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVAXRnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVAXRnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:43:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2196 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261534AbVAXRn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:43:29 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: fix against journal overflow
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3r7khv3id.fsf@bzzz.home.net>
References: <m3r7khv3id.fsf@bzzz.home.net>
Content-Type: text/plain
Message-Id: <1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 17:43:09 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-01-19 at 15:32, Alex Tomas wrote:

> under some quite high load, jbd can hit J_ASSERT(journal->j_free > 1)
> in journal_next_log_block(). The cause is the following:
> 
> journal_commit_transaction()
> {
>         struct buffer_head *wbuf[64];
>                 /* If there's no more to do, or if the descriptor is full,
>                    let the IO rip! */
>                 if (bufs == ARRAY_SIZE(wbuf) ||
>                     commit_transaction->t_buffers == NULL ||
>                     space_left < sizeof(journal_block_tag_t) + 16) {
> 
> so, the real limit isn't size of journal descriptor, but wbuf.

I don't see how that "limit" is relevant here.  wbuf is nothing but the
size of the IO batches we pass to ll_rw_block() during that commit
phase.  j_free affects the total size of space the *entire* commit has
to run into, and (as akpm has commented with a big marker beside it)
start_this_handle() reserves a *lot* of headroom for the extra space
that may be needed for transaction metadata.

(The comment there about journal_extend() needing to match it looks
correct, though --- that will need fixing.)

The only case I've ever seen the j_free > 1 assert fail on was the xattr
test that tridge was triggering with AG's first-generation xattr sharing
fix last December, and that was a journal_release_buffer() credits
accounting problem.

So NAK --- the wbuf batch size just doesn't seem to be relevant to the
problem being claimed.

Have you really seen this patch make a difference in testing?

Cheers,
 Stephen


