Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVAXSSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVAXSSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVAXSSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:18:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261545AbVAXSSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:18:51 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: fix against journal overflow
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3llaien2g.fsf@bzzz.home.net>
References: <m3r7khv3id.fsf@bzzz.home.net>
	 <1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3llaien2g.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106590709.2103.132.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 24 Jan 2005 18:18:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-01-24 at 17:47, Alex Tomas wrote:

>  SCT> I don't see how that "limit" is relevant here. ...

> 		if (bufs == ARRAY_SIZE(wbuf) ||
> 		    commit_transaction->t_buffers == NULL ||
> 		    space_left < sizeof(journal_block_tag_t) + 16) {
			/* Force a new descriptor to be generated next
>                            time round the loop. */

Sure.  So we know that for every 63 metadata blocks in the journal, we
can be writing one journal descriptor.  That grows the size of the
transaction slightly, by a factor of 1/63.

But __log_space_left() is supposed to account for that:

	/*
	 * Be pessimistic here about the number of those free blocks which
	 * might be required for log descriptor control blocks.
	 */
	...
	left -= (left >> 3);

which reduces the estimate of "usable" space left by a full 1/8th, which
is way more than the upper bounds of the effect that the limited wbuf
size ought to have.

journal_extend() uses __log_space_left() too, so ought to have the same
protection.

Actually, I think I'll withdraw the NAK on this patch, because the
change has other benefits ---- it's going to be both a stack-usage and a
performance improvement to use a generous kmalloc()ed wbuf[] here.  But
I still can't see why it would fix the problem you're claiming it
solves.

--Stephen

