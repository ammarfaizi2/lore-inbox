Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVAYQWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVAYQWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVAYQWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:22:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262001AbVAYQWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:22:02 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3sm4p8tk7.fsf@bzzz.home.net>
References: <m3wtu9v3il.fsf@bzzz.home.net>
	 <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3brbebh43.fsf@bzzz.home.net>
	 <1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3sm4p8tk7.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 25 Jan 2005 16:21:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-01-25 at 14:36, Alex Tomas wrote:
> Hi, could you review the following solution?
> 
> 
>  t_outstanding_credits - number of _modified_ blocks in the transaction
>  t_reserved - number of blocks all running handle reserved
>  transaction size = t_outstanding_credits + t_reserved;

Ah, a work of genius.

Yes, this appears to cover all of the cases.  It changes the semantics
of the jbd layer subtly: a handle isn't "charged" for its use of bh's
until it actually dirties them.  But the handle is required to reserve
enough space up front in any case, so it shouldn't matter much exactly
when it gets charged.  It _would_ affect journal_extend(), if that were
called between a journal_get_write_access() and a
journal_dirty_metadata(), but I don't think we do that anywhere, and the
change in behaviour ought to be merely a slight difference in when it's
legal to extend --- it shouldn't break the rules.

> journal_dirty_metadata(handle, bh)
> {
> 	transaction->t_reserved--;
> 	handle->h_buffer_credits--;
> 	if (jh->b_tcount > 0) {
>                 /* modifed, no need to track it any more */
> 		transaction->t_outstanding_credits++;
> 		jh->b_tcount = -1;
> 	}
> }

Actually, the whole thing can be wrapped in if (jh->b_tcount > 0) {}, I
think.  If we have already charged the transaction for this buffer, then
there's no need to charge the handle for it again.  That's going to be
particularly important for truncate(), where we are continually updating
the same blocks (eg. bitmap, indirect blocks), so we want to make sure
that after the first journal_dirty_metadata() call, no further charge is
made.

If we do that, do we in fact need t_reserved at all?

Very nice!

Cheers,
 Stephen

