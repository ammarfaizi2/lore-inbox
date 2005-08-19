Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVHSUMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVHSUMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVHSUMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:12:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16534 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932699AbVHSUMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:12:41 -0400
Date: Fri, 19 Aug 2005 13:11:21 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
Message-ID: <20050819201121.GA2523@us.ibm.com>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43063B03.8050008@adaptec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:03:15PM -0400, Luben Tuikov wrote:
> On 08/19/05 15:38, Patrick Mansfield wrote:
> > On Fri, Aug 19, 2005 at 02:46:35PM -0400, Luben Tuikov wrote:
> > 
> > 
> >>Using the command time out hook and the strategy routine, gives _complete_
> >>control over host recovery, and I really do mean _complete_.
> >>
> > 
> > 
> > I assume you mean hostt->eh_timed_out.
> 
> Hi Patrick, how are you?

Good thanks :)

> > I was looking at using it in an LLDD, but hit two problems, and have
> > started to work on an alternate approach of cancelling (aborting or wtf you
> > want to call it) a list of commands in the eh thread.
> 
> The eh_timed_out + eh_strategy_handler is actually pretty perfect,
> and _complete_, for any application and purpose in recovering a

One other point: Another problems is that we quiesce all shost IO before
waking up the eh. 

I was changing it to wakeup the eh even while other IO is outstanding, so
the eh can wakeup and cancel individual commands while other IO is still
using the HBA.

> > The two problems I see with the hook are:
> > 
> > It calls the driver in interrupt context, so the called function can't
> > sleep.
> 
> Consider this: When SCSI Core told you that the command timed out,
> 	A) it has already finished,
> 	B) it hasn't already finished.
> 
> In case A, you can return EH_HANDLED.  In case B, you return
> EH_NOT_HANDLED, and deal with it in the eh_strategy_handler.

So, for EH_NOT_HANDLED, do you add the scmd to a LLDD list in your
eh_timed_out, then wait for the eh to run?

Or maybe your host can_queue is 1 :)

> (Hint: you can still "finish" it from there.)
> 
> EH_RESET_TIMER is not really needed provided that
> 	- your interface infrastructure is in place,
> 	- you set the timeout value properly in slave_configure.
> 
> > There is no queueing or list mechanism, so LLDD's that can only cancel one
> > command at a time will have problem.
> 
> See above.

I don't see it ... hence my question above.

-- Patrick Mansfield
