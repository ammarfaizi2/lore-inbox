Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVA0DI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVA0DI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAZXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:11:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262422AbVAZRMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:12:35 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3k6q18fwt.fsf@bzzz.home.net>
References: <m3wtu9v3il.fsf@bzzz.home.net>
	 <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3brbebh43.fsf@bzzz.home.net>
	 <1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3sm4p8tk7.fsf@bzzz.home.net>
	 <1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3k6q18fwt.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106759535.1953.53.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 26 Jan 2005 17:12:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-01-25 at 19:30, Alex Tomas wrote:

>  >> journal_dirty_metadata(handle, bh)
>  >> {
>  >>     transaction->t_reserved--;
>  >>     handle->h_buffer_credits--;
>  >>     if (jh->b_tcount > 0) {
>  >>         /* modifed, no need to track it any more */
>  >>          transaction-> t_outstanding_credits++;
>  >>        jh-> b_tcount = -1;
>  >>      }
>  >> }
> 
>  SCT> Actually, the whole thing can be wrapped in if (jh->b_tcount > 0) {}, I
>  SCT> think.

> the idea is:
> 1) the sooner we drop reservation, the higher probability to cover many
>    changes by single transaction

But that's exactly why we _don't_ want to do this.  You're dropping the
reservation, but remember, we return unused handle credits to the
transaction at the end of the handle's life.

So normally, when you are, for example, appending 4k at a time to a
large file, the first handle in a new transaction gets charged for the
indirect/bitmap updates.  But subsequent ones do not, so as the later
handles end, they return their credits to the transaction.  That allows
large numbers of handles to update the same buffers in the same
transaction.

But by reducing handle->h_buffer_credits early, even if the bh is
already modified in the current transaction, you are preventing the
return of those credits back to the transaction.  Effectively, each
modification of the same bh in the same transaction is being accounted
for separately, so you're charging the transaction multiple times for a
bh which is only going to be journaled once.  That's going to cause the
transaction to be closed early, as our accounting will tell us that the
transaction is full even when it has only a few buffers modified.

> 1) having h_buffer_credits being decremented for each modification
>    could help us to debug handle overflow situations
> 
>  SCT> If we do that, do we in fact need t_reserved at all?
> 
> hmm. if t_outstanding_credits holds number of modified buffers,
> then we need sum of all running h_buffer_credits to protect
> from transaction overflow. t_reserved is sum of h_buffer_credits.

Why can't we just maintain t_outstanding_credits for this?  Define that
as the sum of all credits either promised or consumed by any handles.

On journal_start(), t_outstanding_credits += blocks;

On journal_dirty_metadata(), 
	{
		if (jb->b_tcount > 0) {
			/* a promised credit has turned into a consumed one */
			handle->h_buffer_credits--;
			jh->b_tcount = -1;
		}
	}

On journal_stop(), any remaining handle credits are promised but
unconsumed; simply return them: 
	transaction->t_outstanding_credits -= handle->h_buffer_credits;

As before journal_release_buffer() doesn't have to do anything about
credits because we're only releasing buffers if they have not been
charged for yet.

--Stephen

