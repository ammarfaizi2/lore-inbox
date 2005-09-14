Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVINBny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVINBny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVINBny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:43:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932566AbVINBnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:43:52 -0400
Date: Tue, 13 Sep 2005 18:43:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-Id: <20050913184305.24705a98.akpm@osdl.org>
In-Reply-To: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz>
References: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> When a buffer is locked it does not mean that write-out is in progress. We
>  have to check if the buffer is dirty and if it is we have to submit it
>  for write-out. We unconditionally move the buffer to t_locked_list so
>  that we don't mistake unprocessed buffer and buffer not yet given to
>  ll_rw_block(). This subtly changes the meaning of buffer states in
>  t_locked_list - unlock buffer (for list users different from
>  journal_commit_transaction()) does not mean it has been written. But
>  only journal_unmap_buffer() cares and it now checks if the buffer
>  is not dirty.

Seems complex.  It means that t_locked_list takes on an additional (and
undocumented!) meaning.

Also, I don't think it works.  See ll_rw_block()'s handling of
already-locked buffers..

An alternative is to just lock the buffer in journal_commit_transaction(),
if it was locked-and-dirty.  And remove the call to ll_rw_block() and
submit the locked buffers by hand.

That would mean that if someone had redirtied a buffer which was on
t_sync_datalist *while* it was under writeout, we'd end up waiting on that
writeout to complete before submitting more I/O.  But I suspect that's
pretty rare.

One thing which concerns me with your approach is livelocks: if some process
sits in a tight loop writing to the same part of the same file, will it
cause kjournald to get stuck?

The problem we have here is "was the buffer dirtied before this commit
started, or after?".  In the former case we are obliged to write it.  In
the later case we are not, and in trying to do this we risk livelocking.
