Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbVHSVK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVHSVK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVHSVK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:10:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10967 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965128AbVHSVKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:10:24 -0400
Date: Fri, 19 Aug 2005 14:10:08 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
Message-ID: <20050819211008.GA3032@us.ibm.com>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com> <20050819201121.GA2523@us.ibm.com> <4306447D.7090204@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4306447D.7090204@adaptec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben -

On Fri, Aug 19, 2005 at 04:43:41PM -0400, Luben Tuikov wrote:
> On 08/19/05 16:11, Patrick Mansfield wrote:

> > I was changing it to wakeup the eh even while other IO is outstanding, so
> > the eh can wakeup and cancel individual commands while other IO is still
> > using the HBA.
> 
> Hmm, if you want to do this, then SCSI Core needs to know about:
> 	- Domain,
> 	- Domain device and
> 	- LU.

Not really, scsi core is just asking the LLDD to cancel or release the scmd.
That is really all we do in the eh today, and then if the LLDD can't
cancel the scmd, we take other sometimes less than useful steps.

The LLDD could start any error handling scheme it wants, independent of
scsi core action.

We don't initiate error handling in scsi core for other error cases, why
should a timeout be any different?

> The reason, is that you do not know why a task timed out.
> Is it the LU, is it the device, is it the domain?

Right, so in scsi core allow a simple method that can cancel commands
while the HBA is still in use.

> (Those are concepts talked about in SAM.)
> 
> Since currently, SCSI Core has no clue about those concepts,
> the current infrastructure, stalling IO to the host on eh,
> satisfies.
> 
> > So, for EH_NOT_HANDLED, do you add the scmd to a LLDD list in your
> > eh_timed_out, then wait for the eh to run?
> 
> No, no Patrick, I don't.  The SCSI Core does this for me, and then
> calls my eh_strategy routine and all the commands are on the list.

Oh right ... I was not thinking straight.

But I don't see how that gains much, if you sometimes still wait for scsi
core to quiesce IO and wakeup the eh.

-- Patrick Mansfield
