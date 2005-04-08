Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVDHOGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVDHOGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVDHOGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:06:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262820AbVDHOGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:06:40 -0400
Subject: Re: Problem in log_do_checkpoint()?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jeffm@suse.com,
       Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
References: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112969175.1975.96.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 08 Apr 2005 15:06:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-04 at 10:04, Jan Kara wrote:

>   In log_do_checkpoint() we go through the t_checkpoint_list of a
> transaction and call __flush_buffer() on each buffer. Suppose there is
> just one buffer on the list and it is dirty. __flush_buffer() sees it and
> puts it to an array of buffers for flushing. Then the loop finishes,
> retry=0, drop_count=0, batch_count=1. So __flush_batch() is called - we
> drop all locks and sleep. While we are sleeping somebody else comes and
> makes the buffer dirty again (OK, that is not probable, but I think it
> could be possible). 

Yes, there's no reason why not at that point.

> Now we wake up and call __cleanup_transaction().
> It's not able to do anything and returns 0.

I think the _right_ answer here is to have two separate checkpoint
lists: the current one, plus one for which the checkpoint write has
already been submitted.  That way, we can wait for IO completion on
submitted writes without (a) getting conned into doing multiple rewrites
if there's somebody else dirtying the buffer; or (b) getting confused
about how much progress we're making.  Buffers on the pre-write list get
written; buffers on the post-write list get waited for; and both count
as progress (eliminating the false assert-failure when we failed to
detect progress).

The prevention of multiple writes in this case should also improve
performance a little.

That ought to be pretty straightforward, I think.  The existing cases
where we remove buffers from a checkpoint shouldn't have to care about
which list_head we're removing from; those cases already handle buffers
in both states.  It's only when doing the flush/wait that we have to
distinguish the two.

Sounds good?

--Stephen

